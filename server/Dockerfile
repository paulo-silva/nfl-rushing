FROM elixir:1.11.3

WORKDIR /app
COPY mix.exs /app/
COPY mix.lock /app/

RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix deps.get \
  && mix deps.compile
ADD . /app

RUN mix compile

CMD ["mix", "phx.server"]
