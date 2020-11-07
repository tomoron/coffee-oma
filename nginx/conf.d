upstream unicorn {
  server 127.0.0.1:3000;
}

server {
  listen 80 default_server;
  server_name localhost;
  root /usr/share/nginx/html;
  try_files $uri/index.html $uri @unicorn;

  proxy_connect_timeout 600;
  proxy_read_timeout 600;
  proxy_send_timeout 600;

  client_max_body_size 100m;
  error_page 404 /404.html;
  error_page 505 502 503 504 /500.html;

  location @unicorn {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_pass http://unicorn;
  }
}
