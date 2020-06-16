
# Ruby on Rails Environment
FROM ruby:latest

# Set up Linux
RUN apt-get update -qq && apt-get install -y

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Dependency stuff
RUN bundle install 

# Copy ./run.sh into here
COPY . /app 

ENTRYPOINT ["sh", "./run.sh"]






