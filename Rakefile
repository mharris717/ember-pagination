require 'mharris_ext'
require 'coffee_short_get'
require 'npm_overapp'

NpmOverapp.app_name = "ember-pagination"

%w(build deps).each do |f|
  load File.dirname(__FILE__) + "/tasks/#{f}.rb"
end