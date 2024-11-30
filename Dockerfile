FROM ubuntu:latest RUN apt-get update && apt-get install -y xrdp RUN systemctl enable xrdp EXPOSE 3389 CMD ["xrdp"]
