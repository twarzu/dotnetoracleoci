# Base image id
FROM microsoft/dotnet:2.0-runtime-jessie

# Install packages required by OCI, iInstall Oracle Client Instant, rename required files missing by installer
RUN apt-get update && apt-get install -y alien libaio1 libc6 libgcc1 lsb
WORKDIR /oracleoci
COPY /rpm .
RUN alien -i oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
ENV LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib
RUN ln -s $LD_LIBRARY_PATH/libclntsh.so.12.1 $LD_LIBRARY_PATH/libclntsh.so \
    && ln -s $LD_LIBRARY_PATH/libocci.so.12.1 $LD_LIBRARY_PATH/libocci.so \
    && cd .. \
    && rm -rf /oracleoci