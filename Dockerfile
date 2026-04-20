FROM ghcr.io/pixlcore/xyops-shell-image:latest

# Install AWS CLI v2
RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws

RUN aws configure set default.s3.max_concurrent_requests 20 && \
    aws configure set default.s3.max_queue_size 10000 && \
    aws configure set default.s3.multipart_threshold 64MB && \
    aws configure set default.s3.multipart_chunksize 64MB

COPY s3sync /usr/bin/s3sync
RUN chmod +x /usr/bin/s3sync

CMD ["xyrun"]
