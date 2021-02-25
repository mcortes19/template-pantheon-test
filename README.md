# PlatformSh Drupal Template

Template based on [drupal/recomended-project](https://github.com/drupal/recommended-project) to create drupal projects to be deployed in [Platformsh](https://platform.sh/), also includes:

- [bloom](https://github.com/ManatiCR/bloom)

## Dependencies

- Docker
- Docker Compose
- [Chirripo Launcher](https://docs.chirripo.dev/chirripo-launcher/)
- [Chirripo Proxy](https://docs.chirripo.dev/chirripo-proxy/)

## Getting Started

### Prepare for local development

This template uses [chirripo](https://docs.chirripo.dev/) as local environment.

Generate local settings files **(run this command at root of the project)**:

```bash
./scripts/local-settings.sh
```

Install the requiered dependencies:

```bash
composer install --ignore-platform-reqs
npm install
```

Run the local environemnt **([Chirripo Launcher](https://docs.chirripo.dev/chirripo-launcher/) should be installed in order to execute chirripo command globally)**:

```bash
chirripo start
```

Install the local site **(run this command at root of the project)**:

```bash
./scripts/site-install.sh
```

Enable and configure the [Chirripo Proxy](https://docs.chirripo.dev/chirripo-proxy/).

Start the proxy:

```bash
chirripo proxy-up
```

### Import the existing site

Download database in the root of the project, then change the name of the file by `db_site.sql.gz`

Import the databese:

```bash
./scripts/install-from-db.sh
```

Add the site URL in the  `settings/settings.local.php` file:

```php
$config['stage_file_proxy.settings']['origin'] = 'SITE_URL';
```

## Installed Stuff

You can change any variable defined in the `.env` file to make adjustments to the provided setup. You can edit the file named `docker-compose.override.yml` in the root of the project to make more advanced customizations.

### Solr

Core is created as `collection1`.

Solr address is `solr`.

Path is `/`.

## Testing

This project uses `npm` to run `gulp` tasks.

To run drupalcs, phplint and eslint tasks:

```bash
npm run test
```

To compile/transpile Javascript es6:

```bash
npm run build:js
```

To run lighthouse test in front page:

```bash
npm run lighthouse
```

To run lighthouse in a custom url:

```bash
node_modules/.bin/lhci autorun --collect.url=CUSTOM_URL
```
