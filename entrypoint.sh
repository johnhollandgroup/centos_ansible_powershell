#!/usr/bin/env bash
set -e

cp /certs/* /etc/pki/ca-trust/source/anchors/
update-ca-trust force-enable
update-ca-trust extract

exec "$@"
