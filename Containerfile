FROM docker.io/alpine:3 AS builder

ARG SNAIL_BASE_COMMIT=1ac85e0102363f1b3db62ee6f31263fdae4c6472

RUN apk add gcc make git musl-dev

WORKDIR /build
RUN git clone https://git.sdaoden.eu/scm/s-nail.git && \
  git -c advice.detachedHead=false -C s-nail checkout $SNAIL_BASE_COMMIT
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
