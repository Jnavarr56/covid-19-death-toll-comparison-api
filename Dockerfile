
# Ruby on Rails Environment
FROM ruby:2.7.1

# Set up Linux
RUN apt-get update -qq 



# RUN apt install -q -y chromium
# WORKDIR /tmp
# RUN unzip chromedriver_linux64.zip -d /usr/local/bin
# RUN rm -f chromedriver_linux64.zip


RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# RUN gem install selenium-webdriver
# RUN wget http://chromedriver.storage.googleapis.com/87.0.4280.20/chromedriver_linux64.zip
# RUN ls
# COPY chromedriver_linux64.zip /app/chromedriver_linux64.zip


# Dependency stuff
RUN bundle install 

# Copy ./run.sh into here
COPY . /app 

ENTRYPOINT ["sh", "./run.sh"]






