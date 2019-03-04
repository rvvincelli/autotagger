#docker build -t autotagger .
#docker run -v /abs/path/to/sourcedir/:/source -v /abs/path/to/destdir:/dest autotagger

FROM python:3.6.3

RUN pip install discogs-cli unidecode pyaml mutagen musicbrainzngs jellyfish munkres discogs_client

RUN find . -name discogs.py -exec sed -i 's/color=True/color=False/g' {} +

COPY *.sh /autotagger/

COPY beet.py /autotagger/

RUN mkdir /autotagger/beets
COPY beets/ /autotagger/beets/
RUN mkdir /autotagger/beetsplug
COPY beetsplug/ /autotagger/beetsplug/
RUN export PYTHONPATH=${PYTHONPATH}:/autotagger/beets:/autotagger/beetsplug

RUN mkdir -p /root/.config/beets
RUN echo "***THE FOLLOWING COMMAND EXPECTS THREE FILE CREATED WHEN FIRST RUNNING beets"
RUN echo "TO CREATE THEM DOWNLOAD AND RUN beets LOCALLY - http://beets.io/"
COPY config.yaml discogs_token.json state.pickle /root/.config/beets/

ENV SOURCEDIR=/source
ENV DESTDIR=/dest
ENV INPUTFILE=/autotagger/ls.txt
ENV TOKEN=REPLACEMEEE
RUN echo "beets TOKEN IS: $TOKEN - IS THIS CORRECT?"

ENTRYPOINT ["/autotagger/entrypoint.sh"]

