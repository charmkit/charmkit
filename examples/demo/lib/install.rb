require 'charmkit'

class Install < Charmkit
  plugin :core
  plugin :nginx
  plugin :php

  incant :nginx_install do |nginx|
    ngnix.install
    nginx.set_vhost server_name: config('server_name'),
                    application_path: config('app_path')
  end
  incant :php_install do |php|
    php.install version: 7,
                plugins: ['fpm',
                          'cgi',
                          'curl',
                          'gd',
                          'json',
                          'mcrypt',
                          'readline',
                          'mbstring',
                          'xml']
  end


  def summon
    log "Running example charm code"
  end
end
