require 'charmkit'

template('examples/my-demo-charm/templates/vhost.conf',
         '/tmp/nginx-data.conf',
         public_address: 'localhost',
         app_path: '/srv/app')

inline_template('vhost.conf',
                '/tmp/output.txt',
                public_address: "localhost",
                app_path: "/srv/app")
__END__

@@ nginx.conf

server_connections { 50m; }

@@ vhost.conf

server {
        ## Your website name goes here.
        server_name <%= public_address %>;
        ## Your only path reference.
        root <%= app_path %>;
        location / {
		index doku.php;
                # This is cool because no php is touched for static content.
                # include the "?$args" part so non-default permalinks doesn't break when using query string
                try_files $uri $uri/ @dokuwiki;
        }

	location ~ ^/lib.*\.(gif|png|ico|jpg)$ {
                    expires 30d;
	}

	location ^~ /conf/ { return 403; }
	location ^~ /data/ { return 403; }

 	location @dokuwiki {
		rewrite ^/_media/(.*) /lib/exe/fetch.php?media=$1 last;
		rewrite ^/_detail/(.*) /lib/exe/detail.php?media=$1 last;
		rewrite ^/_export/([^/]+)/(.*) /doku.php?do=export_$1&id=$2 last;
		rewrite ^/(.*) /doku.php?id=$1 last;
	}

        location ~ \.php$ {
                include fastcgi_params;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        }
	# Block access to data folders
	location ~ /(data|conf|bin|inc)/ {
		deny all;
	}
	# Block access to .htaccess files
	location ~ /\.ht {
		deny  all;
	}
}
