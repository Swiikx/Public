server {
    listen ${serveur.port}${serveur.ssl_enabled ? " ssl" : ""};
    server_name ${serveur.server_name};
    root ${serveur.root_path};
    index ${serveur.index};

    access_log /var/log/nginx/${serveur.nom}_access.log;
    error_log  /var/log/nginx/${serveur.nom}_error.log;

%{if serveur.ssl_enabled}
    ssl_certificate     /etc/ssl/certs/${serveur.nom}.crt;
    ssl_certificate_key /etc/ssl/private/${serveur.nom}.key;
    ssl_protocols       TLSv1.2 TLSv1.3;
%{endif}

%{if serveur.rate_limiting}
    limit_req_zone $binary_remote_addr zone=${serveur.nom}:10m rate=10r/s;
    limit_req zone=${serveur.nom} burst=20 nodelay;
%{endif}

    location / {
        try_files $uri $uri/ =404;
    }

%{for loc in serveur.locations}
    location ${loc.path} {
%{if loc.proxy_pass != ""}
        proxy_pass ${loc.proxy_pass};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
%{else}
        root ${serveur.root_path};
%{endif}
    }
%{endfor}
}
