FROM python:3.8.13-slim

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# RUN apk add --no-cache python3 py3-pip

# RUN apk update

RUN apt update -y && apt-get install -y python3-dev build-essential

# the --no-install-recommends helps limit some of the install so that you can be more explicit about what gets installed

# RUN apk add make automake gcc g++ subversion python3-dev git libffi-dev
# RUN python3 -m pip install --upgrade pip --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.
# # RUN apk add python3 py3-pip gcc python3-dev g++
# RUN pip install pandas --no-cache-dir --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org oauthlib -vvv


COPY requirements_main.txt .
RUN pip install -r requirements_main.txt --no-cache-dir --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org -vvv

# RUN apk add build-base cmake bash autoconf zlib-dev flex bison

# RUN pip install --extra-index-url https://pypi.fury.io/arrow-nightlies/pyarrow-1.1.0.dev11-cp36-cp36m-manylinux2014_x86_64.whl \
#         --prefer-binary --no-cache-dir --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host pypi.fury.io oauthlib -vvv

COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org -vvv
WORKDIR /app


# install the dependencies and packages in the requirements file
# RUN pip install -r requirements.txt

# copy every content from the local file to the image
COPY . /app

# configure the container to run in an executed manner
ENTRYPOINT [ "python3" ]

EXPOSE 5000

CMD ["view.py" ]
