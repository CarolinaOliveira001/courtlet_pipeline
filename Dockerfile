FROM carolina30/r421_rap:version1

RUN mkdir /home/courtcases

COPY _targets.R /_targets.R

COPY functions.R /functions.R

CMD R -e "targets::tar_make()"