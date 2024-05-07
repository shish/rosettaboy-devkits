FROM debian:unstable AS build
ARG TARGETPLATFORM
ARG VERSION
RUN apt update && apt install -y wget adduser git bzip2
RUN adduser --disabled-password dev
USER dev
ENV PATH="/home/dev/.pypy/bin:$PATH"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=linux64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=aarch64; else ARCHITECTURE=linux64; fi \
    && wget -nv https://downloads.python.org/pypy/pypy3.10-v${VERSION}-${ARCHITECTURE}.tar.bz2 -O - \
    | tar -xj -C /tmp \
    && mv /tmp/pypy3.10-v${VERSION}-${ARCHITECTURE} /home/dev/.pypy

FROM scratch
COPY --from=build /home/dev/.pypy /home/dev/.pypy
