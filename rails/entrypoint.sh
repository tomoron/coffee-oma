#!/bin/sh
set -e

echo "$ENV_FILE" | base64 -d >.env

telnet email-smtp.ap-northeast-1.amazonaws.com 587

bin/rails db:migrate:reset RAILS_ENV=production

bin/rails db:seed RAILS_ENV=production

RAILS_ENV=production bin/delayed_job -n 2 start

rake jobs:clear

exec "$@"
