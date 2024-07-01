#!/bin/sh
set -e
set -x

# echo "00: $0"
# echo "0@: $@"
# 00: /usr/local/bin/docker-entrypoint.sh
# 0@: redis-server

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
fi

# echo "10: $0"
# echo "1@: $@"
# 10: /usr/local/bin/docker-entrypoint.sh
# 1@: redis-server

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	find . \! -user redis -exec chown redis '{}' +
	# find . ! -user redis -exec chown redis {} +
	exec gosu redis "$0" "$@"
	# exec gosu redis /usr/local/bin/docker-entrypoint.sh redis-server
fi

# set an appropriate umask (if one isn't set already)
# - https://github.com/docker-library/redis/issues/305
# - https://github.com/redis/redis/blob/bb875603fb7ff3f9d19aad906bd45d7db98d9a39/utils/systemd-redis_server.service#L37
um="$(umask)"
if [ "$um" = '0022' ]; then
	umask 0077
fi

# echo "20: $0"
# echo "2@: $@"
# 20: /usr/local/bin/docker-entrypoint.sh
# 2@: redis-server

exec "$@"
# exec redis-server
