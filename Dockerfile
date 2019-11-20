FROM ruby:2.6.1
RUN apt-get update 
RUN apt-get install default-libmysqlclient-dev

RUN gem update --system
RUN gem install mysql2
RUN gem install bundle
RUN gem install bundler

RUN mkdir /interface-ms
WORKDIR /interface-ms
ADD Gemfile /interface-ms/Gemfile
ADD Gemfile.lock /interface-ms/Gemfile.lock
RUN bundle install
ADD . /interface-ms

EXPOSE 4009