<?php

/**
 * @file
 * Drupal site-specific configuration file.
 */

// Default Drupal 8 settings.
//
// These are already explained with detailed comments in Drupal's
// default.settings.php file.
//
// See https://api.drupal.org/api/drupal/sites!default!default.settings.php/8
$databases = [];
$config_directories = [];
$settings['update_free_access'] = FALSE;
$settings['container_yamls'][] = $app_root . '/' . $site_path . '/services.yml';
$settings['file_scan_ignore_directories'] = [
  'node_modules',
  'bower_components',
];


// Config Split module settings.
$config['config_split.config_split.dev']['status'] = TRUE;

// Environment indicator module settings.
$config['environment_indicator.indicator']['bg_color'] = '#863DA1';
$config['environment_indicator.indicator']['fg_color'] = '#FFFFFF';
$config['environment_indicator.indicator']['name'] = 'Local';

// Environment dependent configuration (in PlatformSh).
if (getenv('PANTHEON_ENVIRONMENT')) {

  switch (getenv('PANTHEON_ENVIRONMENT')) {
    case 'live':
      // Config Split.
      $config['config_split.config_split.dev']['status'] = FALSE;
      // Environment indicator.
      $config['environment_indicator.indicator']['bg_color'] = '#FF0100';
      $config['environment_indicator.indicator']['fg_color'] = '#FFFFFF';
      $config['environment_indicator.indicator']['name'] = 'Live';
      break;

    case 'test':
      // Config Split.
      $config['config_split.config_split.dev']['status'] = FALSE;
      // Environment indicator.
      $config['environment_indicator.indicator']['bg_color'] = '#F39500';
      $config['environment_indicator.indicator']['fg_color'] = '#FFFFFF';
      $config['environment_indicator.indicator']['name'] = 'Staging';
      break;

    case 'dev':
      // Config Split.
      $config['config_split.config_split.dev']['status'] = TRUE;
      // Environment indicator.
      $config['environment_indicator.indicator']['bg_color'] = '#0FC37B';
      $config['environment_indicator.indicator']['fg_color'] = '#FFFFFF';
      $config['environment_indicator.indicator']['name'] = 'Development';
      break;
  }

  // Automatic Pantheon settings.
  if (file_exists($app_root . '/' . $site_path . '/settings.pantheon.php')) {
    include $app_root . '/' . $site_path . '/settings.pantheon.php';
  }
}

// Set up a config sync directory.
//
// This is defined inside the read-only "config" directory, deployed via Git.
$settings['config_sync_directory'] = '../config/sync';

// Local settings. These come last so that they can override anything.
if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
  include $app_root . '/' . $site_path . '/settings.local.php';
}

// Secret settings contains database settings and other sensitive
// environment specific information that shouldn't be in version control.
if (file_exists($app_root . '/' . $site_path . '/settings.secret.php')) {
  include $app_root . '/' . $site_path . '/settings.secret.php';
}
