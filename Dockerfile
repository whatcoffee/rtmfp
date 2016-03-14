FROM debian

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim nano curl wget zip build-essential git libssl-dev
RUN apt-get clean

RUN wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
RUN tar -xzf LuaJIT-2.0.4.tar.gz && rm LuaJIT-2.0.4.tar.gz && cd LuaJIT-2.0.4 && make && make install
RUN wget https://github.com/MonaSolutions/MonaServer/archive/master.zip
#RUN unzip master.zip && cd MonaServer-master && make && cd MonaServer && mkdir www && mkdir www/myapp && cp ../MonaCore/lib/libMonaCore.so libMonaCore.so && cp ../MonaBase/lib/libMonaBase.so libMonaBase.so
RUN unzip master.zip
RUN mv MonaServer-master MonaServer
RUN ls -al && ls -al MonaServer
RUN cd MonaServer && make && cd /
RUN cp MonaServer/MonaServer/MonaServer _monaserver && mkdir www && mkdir www/myapp
RUN cp MonaServer/MonaCore/lib/libMonaCore.so /usr/local/lib/libMonaCore.so && cp MonaServer/MonaBase/lib/libMonaBase.so /usr/local/lib/libMonaBase.so
ADD MonaServer.ini MonaServer.ini
RUN ls -al


EXPOSE 1935 1936

ENTRYPOINT ["./_monaserver"]
