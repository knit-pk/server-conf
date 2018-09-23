# KNIT Server
Docker configuration of KNIT Server

## Testing

Warning: This steps can break your system!

At first edit `/etc/hosts` as root user, and add following lines:
```
127.0.0.1       knit.pk.edu.pl
127.0.0.1       www.knit.pk.edu.pl
127.0.0.1       admin.knit.pk.edu.pl
127.0.0.1       api.knit.pk.edu.pl
127.0.0.1       archive.knit.pk.edu.pl
127.0.0.1       static.knit.pk.edu.pl
```

Create default docker-compose.override.yml:

```bash
$ cp docker-compose.override.dist docker-compose.override.yml
```

Then optionally put changes on `docker-compose.override.yml`

And run:

```bash
$ docker-compose build --pull
$ docker-compose up -d
```

You might want to deploy some fixtures to the api:

```bash
$ docker-compose exec api sh
# now you should be in api container

# install development tools and deploy fixtrues
$ composer install
$ APP_ENV=dev make fixtures-reload
```

## Available services:

- (www.)knit.pk.edu.pl - KNIT Homepage
- api.knit.pk.edu.pl - KNIT API
- api.knit.pk.edu.pl/admin - KNIT API Admin
- admin.knit.pk.edu.pl:8081 - PHPMyAdmin
- archive.knit.pk.edu.pl - Old CMS (TBD)
- (*.)knit.pk.edu.pl:8080 - Traefik Dashboard and API