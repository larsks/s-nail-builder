FROM docker.io/alpine:3 AS builder

RUN apk add alpine-sdk

WORKDIR /build
RUN git clone https://git.sdaoden.eu/scm/s-nail.git
WORKDIR /build/s-nail
COPY *.patch ./
RUN <<EOF
set -e
for patch in *.patch; do
git -c user.name="s-nail builder" -c user.email="s-nail builder" am $patch
done
EOF

#WORKDIR /build/s-nail
#COPY ./ .

RUN make citron \
  VAL_SID= \
  VAL_MAILX=mail \
  OPT_COLOUR=no \
  OPT_MTA_ALIASES=no \
  OPT_NET=no \
  OPT_MLE=no \
  OPT_ERRORS=no \
  VAL_SYSCONFDIR=/etc \
  VAL_SYSCONFRC=mail.rc

FROM docker.io/alpine:3

COPY --from=builder /usr/local/bin/ /usr/local/bin/
