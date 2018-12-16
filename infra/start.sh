#!/usr/bin/env sh

export SECRET_KEY_BASE=`gopass misc/griha_openproject_secretkeybase`

docker-compose up
