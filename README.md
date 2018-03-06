# KNIT Server
Docker configuration of KNIT Server

## Testing

Warning: This steps can break your system!

At first edit `/etc/hosts` as root user, and add following lines:
```
127.0.0.1       knit.pk.edu.pl
127.0.0.1       api.knit.pk.edu.pl
127.0.0.1       archive.knit.pk.edu.pl
```

Then optionally put changes on `docker-compose.yml`

And run:

`docker-compose up`