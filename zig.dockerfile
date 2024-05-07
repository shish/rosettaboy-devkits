FROM debian:unstable AS build
ARG VERSION
RUN apt update && apt install -y wget adduser xz-utils
RUN adduser --disabled-password dev
USER dev
RUN 
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=x86_64; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=aarch64; \
    else ARCHITECTURE=x86_64; fi \
	&& mkdir /home/dev/.zig \
    && wget -nv https://ziglang.org/download/${VERSION}/zig-linux-${ARCHITECTURE}-${VERSION}.tar.xz -O - \
    | tar --strip-components=1 -C ~/.zig -xJ

FROM scratch
COPY --from=build /home/dev/.zig /home/dev/.zig
