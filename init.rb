require 'redmine'
require 'redmine_custom_view_assigned'
require File.join(File.dirname(__FILE__), 'app/helpers/custom_view_assigned_helper.rb')
require File.join(File.dirname(__FILE__), 'lib/custom_view_assigned/hooks/views_issues_hook.rb')
require File.join(File.dirname(__FILE__), 'lib/custom_view_assigned/hooks/views_layouts_hook.rb')

Redmine::Plugin.register :redmine_custom_view_assigned do
  name        'Redmine Custom View Assigned plugin'
  author      'Alexander Bocharov'
  description 'This plugin for Redmine adds a custom view of the field assigned'
  version     '1.1.0'
  url         'http://alexbocharov.github.io/redmine_custom_view_assigned'

  requires_redmine :version_or_higher => '4.1.1'

  settings :default => {
        'filtering_users' => true,
        'grouping_mode' => 'groups'
    },
           :partial => 'settings/custom_view_assigned/general'

  menu :admin_menu,
       :redmine_custom_view_assigned,
       {:controller => 'settings', :action => 'plugin', :id => 'redmine_custom_view_assigned'},
       :caption => :label_custom_view_assigned,
       :html => {:class => 'icon'}
end
