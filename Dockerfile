# syntax=docker/dockerfile:1
# check=error=true

# この Dockerfile は開発環境向けの設定例です

ARG RUBY_VERSION=3.2.7
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# 基本パッケージのインストール（libyaml-dev を含む）
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl libjemalloc2 libvips postgresql-client libyaml-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# 開発環境向け設定
ENV RAILS_ENV="development"

FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential git libpq-dev pkg-config libyaml-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    bundle exec bootsnap precompile --gemfile

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

FROM base

COPY --from=build "/usr/local/bundle" "/usr/local/bundle"
COPY --from=build /rails /rails

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# 開発環境用はポート3000を利用する例
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
