#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim
# [1/8] FROM docker.io/library/debian:bookworm-slim@sha256:67f3931ad8cb1967beec602d8c0506af1e37e8d73c2a0b38b181ec5d8560d395

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN set -eux; \
	groupadd -r -g 999 redis; \
	useradd -r -g redis -u 999 redis
# [2/8] RUN
# set -eux;
# groupadd -r -g 999 redis;
# useradd -r -g redis -u 999 redis

# runtime dependencies
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
# add tzdata explicitly for https://github.com/docker-library/redis/issues/138 (see also https://bugs.debian.org/837060 and related)
		tzdata \
	; \
	rm -rf /var/lib/apt/lists/*
# [3/8] RUN
# set -eux;
# apt-get update;
# apt-get install -y --no-install-recommends tzdata;
# rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
# https://github.com/tianon/gosu/releases
ENV GOSU_VERSION 1.17
RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates gnupg wget; \
	rm -rf /var/lib/apt/lists/*; \
	arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	case "$arch" in \
		'amd64') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-amd64'; sha256='bbc4136d03ab138b1ad66fa4fc051bafc6cc7ffae632b069a53657279a450de3' ;; \
		'arm64') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-arm64'; sha256='c3805a85d17f4454c23d7059bcb97e1ec1af272b90126e79ed002342de08389b' ;; \
		'armel') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-armel'; sha256='f9969910fa141140438c998cfa02f603bf213b11afd466dcde8fa940e700945d' ;; \
		'i386') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-i386'; sha256='087dbb8fe479537e64f9c86fa49ff3b41dee1cbd28739a19aaef83dc8186b1ca' ;; \
		'mips64el') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-mips64el'; sha256='87140029d792595e660be0015341dfa1c02d1181459ae40df9f093e471d75b70' ;; \
		'ppc64el') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-ppc64el'; sha256='1891acdcfa70046818ab6ed3c52b9d42fa10fbb7b340eb429c8c7849691dbd76' ;; \
		'riscv64') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-riscv64'; sha256='38a6444b57adce135c42d5a3689f616fc7803ddc7a07ff6f946f2ebc67a26ba6' ;; \
		's390x') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-s390x'; sha256='69873bab588192f760547ca1f75b27cfcf106e9f7403fee6fd0600bc914979d0' ;; \
		'armhf') url='https://github.com/tianon/gosu/releases/download/1.17/gosu-armhf'; sha256='e5866286277ff2a2159fb9196fea13e0a59d3f1091ea46ddb985160b94b6841b' ;; \
		*) echo >&2 "error: unsupported gosu architecture: '$arch'"; exit 1 ;; \
	esac; \
	wget -O /usr/local/bin/gosu.asc "$url.asc"; \
	wget -O /usr/local/bin/gosu "$url"; \
	echo "$sha256 */usr/local/bin/gosu" | sha256sum -c -; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	chmod +x /usr/local/bin/gosu; \
	gosu --version; \
	gosu nobody true
# [4/8]
# RUN set -eux;
# savedAptMark="$(apt-mark showmanual)";
# apt-get update;
# apt-get install -y --no-install-recommends ca-certificates gnupg wget;
# rm -rf /var/lib/apt/lists/*;
# arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')";
# case "$arch" in
# 	'amd64')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-amd64';
# 		sha256='bbc4136d03ab138b1ad66fa4fc051bafc6cc7ffae632b069a53657279a450de3'
# 		;;
# 	'arm64')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-arm64';
# 		sha256='c3805a85d17f4454c23d7059bcb97e1ec1af272b90126e79ed002342de08389b'
# 		;;
# 	'armel')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-armel';
# 		sha256='f9969910fa141140438c998cfa02f603bf213b11afd466dcde8fa940e700945d'
# 		;;
# 	'i386')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-i386';
# 		sha256='087dbb8fe479537e64f9c86fa49ff3b41dee1cbd28739a19aaef83dc8186b1ca'
# 		;;
# 	'mips64el')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-mips64el';
# 		sha256='87140029d792595e660be0015341dfa1c02d1181459ae40df9f093e471d75b70'
# 		;;
# 	'ppc64el')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-ppc64el';
# 		sha256='1891acdcfa70046818ab6ed3c52b9d42fa10fbb7b340eb429c8c7849691dbd76'
# 		;;
# 	'riscv64')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-riscv64';
# 		sha256='38a6444b57adce135c42d5a3689f616fc7803ddc7a07ff6f946f2ebc67a26ba6'
# 		;;
# 	's390x')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-s390x';
# 		sha256='69873bab588192f760547ca1f75b27cfcf106e9f7403fee6fd0600bc914979d0'
# 		;;
# 	'armhf')
# 		url='https://github.com/tianon/gosu/releases/download/1.17/gosu-armhf';
# 		sha256='e5866286277ff2a2159fb9196fea13e0a59d3f1091ea46ddb985160b94b6841b'
# 		;;
# 	*)
# 		echo >&2 "error: unsupported gosu architecture: '$arch'";
# 		exit 1
# 		;;
# esac;
# wget -O /usr/local/bin/gosu.asc "$url.asc";
# wget -O /usr/local/bin/gosu "$url";
# echo "$sha256 */usr/local/bin/gosu" | sha256sum -c -;
# export GNUPGHOME="$(mktemp -d)";
# gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4;
# gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu;
# gpgconf --kill all;
# rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc;
# apt-mark auto '.*' > /dev/null;
# [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null;
# apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false;
# chmod +x /usr/local/bin/gosu;
# gosu --version;
# gosu nobody true

ENV REDIS_VERSION 6.2.14
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-6.2.14.tar.gz
ENV REDIS_DOWNLOAD_SHA 34e74856cbd66fdb3a684fb349d93961d8c7aa668b06f81fd93ff267d09bc277

RUN set -eux; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
		\
		dpkg-dev \
		gcc \
		libc6-dev \
		libssl-dev \
		make \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL"; \
	echo "$REDIS_DOWNLOAD_SHA *redis.tar.gz" | sha256sum -c -; \
	mkdir -p /usr/src/redis; \
	tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1; \
	rm redis.tar.gz; \
	\
# disable Redis protected mode [1] as it is unnecessary in context of Docker
# (ports are not automatically exposed when running inside Docker, but rather explicitly by specifying -p / -P)
# [1]: https://github.com/redis/redis/commit/edd4d555df57dc84265fdfb4ef59a4678832f6da
	grep -E '^ *createBoolConfig[(]"protected-mode",.*, *1 *,.*[)],$' /usr/src/redis/src/config.c; \
	sed -ri 's!^( *createBoolConfig[(]"protected-mode",.*, *)1( *,.*[)],)$!\10\2!' /usr/src/redis/src/config.c; \
	grep -E '^ *createBoolConfig[(]"protected-mode",.*, *0 *,.*[)],$' /usr/src/redis/src/config.c; \
# for future reference, we modify this directly in the source instead of just supplying a default configuration flag because apparently "if you specify any argument to redis-server, [it assumes] you are going to specify everything"
# see also https://github.com/docker-library/redis/issues/4#issuecomment-50780840
# (more exactly, this makes sure the default behavior of "save on SIGTERM" stays functional by default)
	\
# https://github.com/jemalloc/jemalloc/issues/467 -- we need to patch the "./configure" for the bundled jemalloc to match how Debian compiles, for compatibility
# (also, we do cross-builds, so we need to embed the appropriate "--build=xxx" values to that "./configure" invocation)
	gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
	extraJemallocConfigureFlags="--build=$gnuArch"; \
# https://salsa.debian.org/debian/jemalloc/-/blob/c0a88c37a551be7d12e4863435365c9a6a51525f/debian/rules#L8-23
	dpkgArch="$(dpkg --print-architecture)"; \
	case "${dpkgArch##*-}" in \
		amd64 | i386 | x32) extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-page=12" ;; \
		*) extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-page=16" ;; \
	esac; \
	extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-hugepage=21"; \
	grep -F 'cd jemalloc && ./configure ' /usr/src/redis/deps/Makefile; \
	sed -ri 's!cd jemalloc && ./configure !&'"$extraJemallocConfigureFlags"' !' /usr/src/redis/deps/Makefile; \
	grep -F "cd jemalloc && ./configure $extraJemallocConfigureFlags " /usr/src/redis/deps/Makefile; \
	\
	export BUILD_TLS=yes; \
	make -C /usr/src/redis -j "$(nproc)" all; \
	make -C /usr/src/redis install; \
	\
# TODO https://github.com/redis/redis/pull/3494 (deduplicate "redis-server" copies)
	serverMd5="$(md5sum /usr/local/bin/redis-server | cut -d' ' -f1)"; export serverMd5; \
	find /usr/local/bin/redis* -maxdepth 0 \
		-type f -not -name redis-server \
		-exec sh -eux -c ' \
			md5="$(md5sum "$1" | cut -d" " -f1)"; \
			test "$md5" = "$serverMd5"; \
		' -- '{}' ';' \
		-exec ln -svfT 'redis-server' '{}' ';' \
	; \
	\
	rm -r /usr/src/redis; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	find /usr/local -type f -executable -exec ldd '{}' ';' \
		| awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); printf "*%s\n", so }' \
		| sort -u \
		| xargs -r dpkg-query --search \
		| cut -d: -f1 \
		| sort -u \
		| xargs -r apt-mark manual \
	; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	redis-cli --version; \
	redis-server --version
# [5/8] RUN
# set -eux;
# savedAptMark="$(apt-mark showmanual)";
# apt-get update;
# apt-get install -y --no-install-recommends ca-certificates wget dpkg-dev gcc libc6-dev libssl-dev make;
# rm -rf /var/lib/apt/lists/*;
# wget -O redis.tar.gz "http://download.redis.io/releases/redis-6.2.14.tar.gz";
# echo "34e74856cbd66fdb3a684fb349d93961d8c7aa668b06f81fd93ff267d09bc277 *redis.tar.gz" | sha256sum -c -;
# mkdir -p /usr/src/redis;
# tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1;
# rm redis.tar.gz;
# grep -E '^ *createBoolConfig[(]"protected-mode",.*, *1 *,.*[)],$' /usr/src/redis/src/config.c;
# sed -ri 's!^( *createBoolConfig[(]"protected-mode",.*, *)1( *,.*[)],)$!\10\2!' /usr/src/redis/src/config.c;
# grep -E '^ *createBoolConfig[(]"protected-mode",.*, *0 *,.*[)],$' /usr/src/redis/src/config.c;
# gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)";
# extraJemallocConfigureFlags="--build=$gnuArch";
# dpkgArch="$(dpkg --print-architecture)";
# case "${dpkgArch##*-}" in
# 	amd64 | i386 | x32)
# 		extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-page=12"
# 		;;
# 	*)
# 		extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-page=16"
# 		;;
# esac;
# extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-hugepage=21";
# grep -F 'cd jemalloc && ./configure ' /usr/src/redis/deps/Makefile;
# sed -ri 's!cd jemalloc && ./configure !&'"$extraJemallocConfigureFlags"' !' /usr/src/redis/deps/Makefile;
# grep -F "cd jemalloc && ./configure $extraJemallocConfigureFlags " /usr/src/redis/deps/Makefile;
# export BUILD_TLS=yes;
# make -C /usr/src/redis -j "$(nproc)" all;
# make -C /usr/src/redis install;
# serverMd5="$(md5sum /usr/local/bin/redis-server | cut -d' ' -f1)";
# export serverMd5;
# find /usr/local/bin/redis* -maxdepth 0 -type f -not -name redis-server -exec sh -eux -c 'md5="$(md5sum "$1" | cut -d" " -f1)"; test "$md5" = "$serverMd5"; ' -- '{}' ';' -exec ln -svfT 'redis-server' '{}' ';';
# rm -r /usr/src/redis;
# apt-mark auto '.*' > /dev/null;
# [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null;
# find /usr/local -type f -executable -exec ldd '{}' ';' | awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); printf "*%s\n", so }' | sort -u | xargs -r dpkg-query --search | cut -d: -f1 | sort -u | xargs -r apt-mark manual;
# apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false;
# redis-cli --version;
# redis-server --version

# + apt-mark showmanual
# + savedAptMark=tzdata
# + apt-get update
# + apt-get install -y --no-install-recommends ca-certificates wget dpkg-dev gcc libc6-dev libssl-dev make
# + rm -rf /var/lib/apt/lists/auxfiles /var/lib/apt/lists/deb.debian.org_debian-security_dists_bookworm-security_InRelease /var/lib/apt/lists/deb.debian.org_debian-security_dists_bookworm-security_main_binary-amd64_Packages.lz4 /var/lib/apt/lists/deb.debian.org_debian_dists_bookworm-updates_InRelease /var/lib/apt/lists/deb.debian.org_debian_dists_bookworm-updates_main_binary-amd64_Packages.lz4 /var/lib/apt/lists/deb.debian.org_debian_dists_bookworm_InRelease /var/lib/apt/lists/deb.debian.org_debian_dists_bookworm_main_binary-amd64_Packages.lz4 /var/lib/apt/lists/lock /var/lib/apt/lists/partial
# + wget -O redis.tar.gz http://download.redis.io/releases/redis-6.2.14.tar.gz
# + echo 34e74856cbd66fdb3a684fb349d93961d8c7aa668b06f81fd93ff267d09bc277 *redis.tar.gz
# + sha256sum -c -
# + mkdir -p /usr/src/redis
# + tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1
# + rm redis.tar.gz
# + grep -E ^ *createBoolConfig[(]"protected-mode",.*, *1 *,.*[)],$ /usr/src/redis/src/config.c
# + sed -ri s!^( *createBoolConfig[(]"protected-mode",.*, *)1( *,.*[)],)$!\10\2! /usr/src/redis/src/config.c
# + grep -E ^ *createBoolConfig[(]"protected-mode",.*, *0 *,.*[)],$ /usr/src/redis/src/config.c
# + dpkg-architecture --query DEB_BUILD_GNU_TYPE
# + gnuArch=x86_64-linux-gnu
# + extraJemallocConfigureFlags=--build=x86_64-linux-gnu
# + dpkg --print-architecture
# + dpkgArch=amd64
# + extraJemallocConfigureFlags=--build=x86_64-linux-gnu --with-lg-page=12
# + extraJemallocConfigureFlags=--build=x86_64-linux-gnu --with-lg-page=12 --with-lg-hugepage=21
# + grep -F cd jemalloc && ./configure  /usr/src/redis/deps/Makefile
# cd jemalloc && ./configure --with-version=5.1.0-0-g0 --with-lg-quantum=3 --with-jemalloc-prefix=je_ CFLAGS="$(JEMALLOC_CFLAGS)" LDFLAGS="$(JEMALLOC_LDFLAGS)"

# + sed -ri s!cd jemalloc && ./configure !&--build=x86_64-linux-gnu --with-lg-page=12 --with-lg-hugepage=21 ! /usr/src/redis/deps/Makefile

# + grep -F cd jemalloc && ./configure --build=x86_64-linux-gnu --with-lg-page=12 --with-lg-hugepage=21  /usr/src/redis/deps/Makefile
# cd jemalloc && ./configure --build=x86_64-linux-gnu --with-lg-page=12 --with-lg-hugepage=21 --with-version=5.1.0-0-g0 --with-lg-quantum=3 --with-jemalloc-prefix=je_ CFLAGS="$(JEMALLOC_CFLAGS)" LDFLAGS="$(JEMALLOC_LDFLAGS)"

# + export BUILD_TLS=yes
# + nproc
# + make -C /usr/src/redis -j 4 all
# + make -C /usr/src/redis install
# + md5sum /usr/local/bin/redis-server
# + cut -d  -f1
# + serverMd5=64a551245748806319a871a099c692a6
# + export serverMd5
# + find /usr/local/bin/redis-benchmark /usr/local/bin/redis-check-aof /usr/local/bin/redis-check-rdb /usr/local/bin/redis-cli /usr/local/bin/redis-sentinel /usr/local/bin/redis-server -maxdepth 0 -type f -not -name redis-server -exec sh -eux -c md5="$(md5sum "$1" | cut -d" " -f1)"; test "$md5" = "$serverMd5"; -- {} ; -exec ln -svfT redis-server {} ;
# + md5sum /usr/local/bin/redis-benchmark
# + cut -d  -f1
# + md5=2af7407928c2f94826ca8514753544e5
# + test 2af7407928c2f94826ca8514753544e5 = 64a551245748806319a871a099c692a6
# + md5sum /usr/local/bin/redis-cli
# + cut -d  -f1
# + md5=a0c3661e6b7e2155da3df6c76ee5aa06
# + test a0c3661e6b7e2155da3df6c76ee5aa06 = 64a551245748806319a871a099c692a6

# + rm -r /usr/src/redis
# + apt-mark auto .*
# + [ -z tzdata ]
# + apt-mark manual tzdata
# + find /usr/local -type f -executable -exec ldd {} ;
# + awk /=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); printf "*%s\n", so }
# + + xargs -r dpkg-query --search
# + sort -u
# + cut -d: -f1
# + xargs -r apt-mark manual
# + redis-cli --version
# + redis-server --version

RUN mkdir /data && chown redis:redis /data
# [6/8] RUN mkdir /data && chown redis:redis /data

VOLUME /data
WORKDIR /data
# [7/8] WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
# [8/8] COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]
