FROM ruby:2.6.2
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev unzip libldap2-dev libidn11-dev fonts-migmix

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# Yarn
RUN npm install -g yarn

# Google Chrome
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
#     && apt-get update && apt-get install -y google-chrome-stable

WORKDIR /spa-rails-api-sample
# ADD package.json /spa-rails-api-sample/package.json
# ADD yarn.lock /spa-rails-api-sample/yarn.lock
# RUN yarn install
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --jobs 4
ADD . /spa-rails-api-sample
