FROM ghcr.io/simonwoerpel/ftmstore-fastapi:develop


ENV FTM_STORE_URI=sqlite:////data/followthemoney.store

RUN mkdir /data
RUN curl -s https://data.ftm.store/eu_authorities/entities.ftm.json | ftm store write -d eu_authorities
RUN curl -s https://data.ftm.store/ec_meetings/entities.ftm.json | ftm store write -d ec_meetings

ENV CACHE=0
ENV PRELOAD_DATASETS=1
ENV INDEX_PROPERTIES=address
