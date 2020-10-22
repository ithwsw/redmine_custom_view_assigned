# Redmine Custom View Assigned plugin

This plugin for Redmine adds a custom view of the field assigned.
More [project site](http://alexbocharov.github.io/redmine_custom_view_assigned/)

## Installation

To install the Redmine Custom View Assigned plugin, execute the following commands from the root of your redmine directory, assuming that your RAILS_ENV enviroment variable is set to "production":

    git clone git://github.com/alexbocharov/redmine_custom_view_assigned.git plugins/redmine_custom_view_assigned

More information on installing Redmine plugins can be found here: [http://www.redmine.org/wiki/redmine/Plugins](http://www.redmine.org/wiki/redmine/Plugins "Redmine Plugins")

After the plugin is installed and the db migration completed, you will
need to restart Redmine for the plugin to be available.

## Uninstall

    Remove your plugin from the plugins folder: #{RAILS_ROOT}/plugins
    Restart Redmine

## Changelog

### v1.2.0
* For Redmine 4.1.1
  Environment:
    Redmine version 4.1.1.stable
    Ruby version    2.6.6-p146 (2020-03-31) [x86_64-linux]
    Rails version   5.2.4.2

### v1.1.0
* For Redmine 3.4 or higher.

### v1.0.5
* Fixed versions
* Support for previous versions of Redmine.

### v1.0.4
* Added Simplified Chinese translation.

### v1.0.3
* Added sorting of groups.

### v1.0.2
* Fix bug with admin page not displayed.

### v1.0.1
* Fixed bug with presetting mode group.

### v1.0.0
* Added possibility to configure the plugin.
* Grouping users by roles, groups or groups without.
* Added a filter to the list of users for a workflow.
* Added German, Spanish, French, Italian, Portuguese translations.
