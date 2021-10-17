FROM ubuntu:focal

RUN apt-get update
RUN apt-get install ruby2.7 ruby2.7-dev build-essential git curl -y
RUN gem install bundler --no-document
RUN gem install thin --no-document

WORKDIR /usr/local/locomotive
COPY . .
RUN bundle install
RUN gem build locomotive.gemspec
RUN gem install locomotive

COPY ./spec/dummy /usr/local/dummy
WORKDIR /usr/local/dummy
RUN bundle install

ENTRYPOINT ["thin", "-R", "config.ru", "-a", "0.0.0.0", "-p", "8080", "start"]