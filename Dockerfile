FROM ruby:2.6.5

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim yarn

RUN mkdir /rails6_practice_1
WORKDIR /rails6_practice_1

COPY Gemfile /rails6_practice_1/Gemfile
COPY Gemfile.lock /rails6_practice_1/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /rails6_practice_1

RUN mkdir -p tmp/sockets

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
