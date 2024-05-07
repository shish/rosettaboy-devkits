FROM debian:unstable AS build
ARG VERSION
RUN apt update && apt install -y wget adduser
RUN adduser --disabled-password dev
USER dev
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; \
    else ARCHITECTURE=amd64; fi \
	&& mkdir /home/dev/.go \
    && wget -nv https://go.dev/dl/go${VERSION}.linux-${ARCHITECTURE}.tar.gz -O - \
    | tar --strip-components=1 -xz -C /home/dev/.go

FROM scratch
COPY --from=build /home/dev/.go /home/dev/.go
