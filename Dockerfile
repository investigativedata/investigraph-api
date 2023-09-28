FROM ghcr.io/investigativedata/ftmstore-fastapi:develop

ENV FTM_STORE_URI=sqlite:////data/followthemoney.store
ENV CATALOG=/data/catalog.json

USER 0
RUN mkdir /data
ADD "https://data.ftm.store/investigraph.eu.json" /data/catalog.json
RUN curl -s https://s3.investigativedata.org/data.ftm.store/eu_authorities/entities.ftm.json | ftmq --store-dataset eu_authorities -o $FTM_STORE_URI
RUN curl -s https://s3.investigativedata.org/data.ftm.store/ec_meetings/entities.ftm.json | ftmq --store-dataset ec_meetings -o $FTM_STORE_URI
RUN curl -s https://s3.investigativedata.org/data.ftm.store/eu_transparency_register/entities.ftm.json | ftmq --store-dataset eu_transparency_register -o $FTM_STORE_URI
RUN chown -R 1000:1000 /data

USER 1000

ENV CACHE=0
ENV TITLE="Investigraph API"
ENV CONTACT_URL=https://github.com/investigativedata/investigraph-api
ENV CONTACT_EMAIL=simon@investigativedata.org
