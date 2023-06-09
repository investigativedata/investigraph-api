FROM ghcr.io/investigativedata/ftmstore-fastapi:develop

ENV FTM_STORE_URI=sqlite:////data/followthemoney.store

RUN mkdir /data

ADD "https://data.ftm.store/investigraph.json" /data/catalog.json
RUN chown 1000:1000 /data/catalog.json
RUN curl -s https://data.ftm.store/eu_authorities/entities.ftm.json | ftm store write -d eu_authorities
RUN curl -s https://data.ftm.store/ec_meetings/entities.ftm.json | ftm store write -d ec_meetings
RUN curl -s https://data.ftm.store/gdho/entities.ftm.json | ftm store write -d gdho

ENV CACHE=1
ENV PRELOAD_DATASETS=1
ENV INDEX_PROPERTIES=address
ENV CATALOG=/data/catalog.json

ENV TITLE="Investigraph API"
ENV CONTACT_URL=https://github.com/investigativedata/investigraph-api
ENV CONTACT_EMAIL=simon@investigativedata.org

USER 1000
