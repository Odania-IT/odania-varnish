# Generate the vcl files
require 'odania'

out_dir = '/etc/varnish'
Odania.varnish.generate out_dir
Odania.varnish.reload_config
