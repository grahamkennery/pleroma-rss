FROM rust as builder

WORKDIR /usr/app/src

COPY . .

RUN cargo build --release

CMD ./target/release/pleroma-rss

FROM debian:11

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/app/src/target/release/pleroma-rss /usr/local/bin/pleroma-rss

CMD pleroma-rss
