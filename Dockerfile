FROM ruby:2.2.1

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile* /app/

RUN bundle install -j4

ADD . /app

# Let's create a user to run the app that is not root
RUN /usr/sbin/useradd --create-home --home /app --shell /bin/bash fulcrum

RUN chown -R fulcrum:fulcrum /app

USER fulcrum

CMD ["rails", "server"]
