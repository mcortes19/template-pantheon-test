#!/usr/bin/env bash
if [ ! -f ./settings/settings.local.php ]; then
  echo "Creating ./settings/settings.local.php"
  printf "<?php\n\n/**\n * @file\n * Local development settings.\n */\n\n\$config['system.performance']['css']['preprocess'] = FALSE;\n\$config['system.performance']['js']['preprocess'] = FALSE;\n\$settings['container_yamls'][] = \$app_root . '/' . \$site_path . '/services.local.yml';\n\$settings['cache']['bins']['render'] = 'cache.backend.null';\n\$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';\n\$settings['cache']['bins']['page'] = 'cache.backend.null';\n\$GLOBALS['_kint_settings']['maxLevels'] = 3;\n\$settings['file_temp_path'] = '/tmp';\n\$settings['hash_salt'] = 'local';\n\$settings['skip_permissions_hardening'] = TRUE;\n\$config['system.logging']['error_level'] = 'verbose';\n\$settings['file_private_path'] = 'sites/default/files/private';\n\$config['stage_file_proxy.settings']['origin'] = '';\n// Trusted host configuration.\n\$settings['trusted_host_patterns'] = [\n  '^localhost',\n  '^127.0.0.1',\n  '^[a-zA-Z0-9-]*(.docker)\$',\n];\n" > settings/settings.local.php
fi
if [ ! -f ./settings/settings.secret.php ]; then
  echo "Creating ./settings/settings.secret.php"
  printf "<?php\n\n/**\n * @file\n * Secret configuration settings for the site.\n */\n\n// Database settings.\n\$databases['default']['default'] = [\n  'database' => !isset(\$_ENV['MYSQL_DATABASE']) ? 'drupal' : \$_ENV['MYSQL_DATABASE'],\n  'username' => !isset(\$_ENV['MYSQL_USER']) ? 'drupal' : \$_ENV['MYSQL_USER'],\n  'password' => !isset(\$_ENV['MYSQL_PASSWORD']) ? 'drupal' : \$_ENV['MYSQL_PASSWORD'],\n  'host' => 'db',\n  'driver' => 'mysql',\n];\n" > settings/settings.secret.php
fi
if [ ! -f ./settings/services.local.yml ]; then
  echo "Creating ./settings/services.local.yml"
  printf "parameters:\n  http.response.debug_cacheability_headers: true\n  twig.config:\n    debug: true\n    auto_reload: true\n    cache: false\nservices:\n  cache.backend.null:\n    class: Drupal\Core\Cache\NullBackendFactory\n" > settings/services.local.yml
fi
echo "Complete."
