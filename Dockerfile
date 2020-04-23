FROM quay.io/openshift/origin-operator-registry:latest

USER 0
RUN rm -rf /manifests \
    && rm -rf /db \
    && mkdir -p /manifests \
    && mkdir -p /db \
    && touch /db/bundles.db \
    && chown -R 1001:1001 /db

USER 1001
COPY content/manifests/ /manifests

# Initialize the database
RUN initializer --manifests /manifests/ --output /db/bundles.db

ENTRYPOINT ["registry-server"]
CMD ["--database", "/db/bundles.db"]
