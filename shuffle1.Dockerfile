FROM python:3.8-bullseye

# Installeer Java + tools voor PySpark
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk git && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Installeer Python libraries
RUN pip install --no-cache-dir pyspark \
    google-api-python-client \
    google-auth \
    google-auth-httplib2 \
    google-auth-oauthlib

# Zet werkmap
WORKDIR /app

# Clone je GitHub repo en haal alleen het script op
RUN git clone https://github.com/alextolm001/shuffle_1.git /app/code

# Verplaats enkel count_votes.py
RUN cp /app/code/count_votes.py .

# Service account wordt later gemount

# Run script
CMD ["python", "count_votes.py"]
