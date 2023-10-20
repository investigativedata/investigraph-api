FROM ghcr.io/investigativedata/ftmstore-fastapi:main

ENV FTM_STORE_URI=sqlite:////data/followthemoney.store
ENV CATALOG=https://data.ftm.store/investigraph.json

USER 0
RUN mkdir /data
RUN chown -R 1000:1000 /data
USER 1000

RUN ftmq catalog iterate -i https://data.ftm.store/investigraph.json -o $FTM_STORE_URI

ENV CACHE=0
ENV TITLE="Investigraph API"
ENV CONTACT_URL=https://github.com/investigativedata/investigraph-api
ENV CONTACT_EMAIL=simon@investigativedata.org
