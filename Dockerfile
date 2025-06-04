FROM caddy:2.10.0-builder AS builder

RUN go clean -modcache

COPY . /src/

RUN xcaddy build \
    --with github.com/tmacro/caddy-consul=/src \
    --with github.com/pteich/caddy-tlsconsul@v1.5.0 \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.10.0
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
