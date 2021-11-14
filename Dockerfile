FROM ruby:2.5.3
#RUN apt-get update
#RUN apt-get install -y yarnpkg
#RUN ln -s /usr/bin/yarnpkg /usr/local/bin/yarn
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /workspace
COPY Gemfile /workspace/Gemfile
COPY Gemfile.lock /workspace/Gemfile.lock
RUN gem install bundler
RUN bundle install
