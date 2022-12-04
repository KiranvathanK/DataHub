FROM ubuntu:latest
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get update  
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get update && apt-get install -y \
curl
CMD /bin/bash
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN . ~/.bashrc
RUN apt-get install -y build-essential libpq-dev libssl-dev openssl libffi-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev libffi-dev wget libbz2-dev liblzma-dev unixodbc unixodbc-dev
RUN apt-get install -y postgresql-client-common postgresql-client
RUN apt-get install -y python3.8
RUN rm /usr/bin/python3
RUN ln -s python3.8 /usr/bin/python3
RUN echo $(python3 --version)
RUN apt-get update
RUN apt-get install -y python3-pip python3.8-dev
RUN mkdir /datahub
COPY . /datahub
WORKDIR /datahub
RUN pip3 install -r requirements.txt
