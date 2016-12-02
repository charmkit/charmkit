require 'charmkit'

class Install < Charmkit
  scroll :core
  scroll :nginx
  scroll :php

  incant :nginx_install
  incant :php_install

  parry :nginx_installed do
    NGINX.install_vhost server_name: config('server_name'), application_path: config('app_path')
  end

  def summon
    log "Running example charm code"
  end
end
