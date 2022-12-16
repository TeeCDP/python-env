FROM harbor.mgmt-bld.oncp.dev/base_images/alpine:3.12.0
RUN apk add --no-cache python3 py3-pip
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk update
RUN apk add make automake gcc g++ subversion python3-dev git libffi-dev
RUN python3 -m pip install --upgrade pip --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org oauthlib -vvv
RUN pip install wheel --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org oauthlib -vvv
# RUN pip install --no-cache-dir six pytest numpy cython --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org oauthlib -vvv
# RUN pip install --no-cache-dir pandas --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org oauthlib -vvv
# RUN git config --global http.sslVerify false
# RUN git config --global core.compression 0
# RUN git -c http.sslVerify=false clone --depth 1 https://github.com/apache/arrow.git

COPY requirements_main.txt .
RUN pip install -r requirements_main.txt --no-cache-dir pandas --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org oauthlib -vvv

# RUN mkdir /arrow/cpp/build    
# WORKDIR /arrow/cpp/build

# ENV ARROW_BUILD_TYPE=release
# ENV ARROW_HOME=/usr/local
# ENV PARQUET_HOME=/usr/local

# #disable backtrace
# RUN sed -i -e '/_EXECINFO_H/,/endif/d' -e '/execinfo/d' ../src/arrow/util/logging.cc

# RUN cmake -DCMAKE_BUILD_TYPE=$ARROW_BUILD_TYPE \
#           -DCMAKE_INSTALL_LIBDIR=lib \
#           -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
#           -DARROW_PARQUET=on \
#           -DARROW_PYTHON=on \
#           -DARROW_PLASMA=on \
#           -DARROW_BUILD_TESTS=OFF \
#           ..
# RUN make -j$(nproc)
# RUN make install

# WORKDIR /arrow/python

# RUN python setup.py build_ext --build-type=$ARROW_BUILD_TYPE \
#        --with-parquet --inplace

RUN apk add build-base cmake bash autoconf zlib-dev flex bison

RUN pip install --extra-index-url https://pypi.fury.io/arrow-nightlies/pyarrow-1.1.0.dev11-cp36-cp36m-manylinux2014_x86_64.whl \
        --prefer-binary --no-cache-dir pandas --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host pypi.fury.io oauthlib -vvv

COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org oauthlib -vvv
WORKDIR /app


# install the dependencies and packages in the requirements file
# RUN pip install -r requirements.txt

# copy every content from the local file to the image
COPY . /app

# configure the container to run in an executed manner
ENTRYPOINT [ "python" ]

CMD ["view.py" ]
