FROM ruby:2.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY . .
RUN bundle install && rake db:migrate

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
