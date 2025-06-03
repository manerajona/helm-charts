FROM python:3.8-buster

EXPOSE 8000

COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
RUN mkdir -p /usr/src/app /home/apiuser
RUN useradd -s /bin/bash -d /home/apiuser apiuser
RUN chown -R apiuser /usr/src/ /home/apiuser


USER apiuser

COPY main.py /usr/src/app
WORKDIR /usr/src/app

CMD python ./main.py

# docker build -t manerajona/simple-api:v1 .
# docker login -u manerajona
# docker push