#!/usr/bin/env bash

if [ ! -d ssh ]; then
  mkdir ssh
fi

ssh-keygen -t rsa -P '' -f ssh/docker-rsync_rsa
cat ssh/docker-rsync_rsa.pub > ssh/authorized_keys
