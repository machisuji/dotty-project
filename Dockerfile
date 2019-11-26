FROM openjdk:11.0.5-stretch

RUN cd /usr/lib && \
  curl -O https://sbt-downloads.cdnedge.bluemix.net/releases/v1.3.4/sbt-1.3.4.tgz && \
  tar xf sbt-1.3.4.tgz && \
  rm sbt-1.3.4.tgz

ENV PATH="/usr/lib/sbt/bin:$PATH"

RUN mkdir /usr/src/dotty-project

WORKDIR /usr/src/dotty-project

COPY build.sbt /usr/src/dotty-project/
COPY project/build.properties project/plugins.sbt /usr/src/dotty-project/project/

# we do this first with an empty project just do download all the things
RUN sbt && sbt compile

COPY src /usr/src/dotty-project/src

CMD ["sbt"]
