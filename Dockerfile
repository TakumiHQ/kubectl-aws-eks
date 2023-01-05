FROM amazon/aws-cli:latest
RUN curl -sL -o /usr/bin/jq https://stedolan.github.io/jq/download/linux64/jq
RUN chmod +x /usr/bin/jq
COPY latest.json /tmp/latest.json
RUN curl -sL -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    curl -sL -o /usr/bin/aws-iam-authenticator $((curl -s https://api.github.com/repos/kubernetes-sigs/aws-iam-authenticator/releases/latest | grep browser_download_url | grep -Eo 'https://.*linux_amd64') || (cat /tmp/latest.json | grep browser_download_url | grep -Eo 'https://.*linux_amd64'))  && \
    chmod +x /usr/bin/aws-iam-authenticator && \
    chmod +x /usr/bin/kubectl

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
