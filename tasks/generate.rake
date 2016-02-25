namespace :varnish do
	desc 'Generate varnish config'
	task :generate do
		out_dir = ENV['OUT_DIR'].nil? ? '/etc/varnish' : ENV['OUT_DIR']
		Odania.varnish.generate out_dir
		Odania.varnish.reload_config
	end
end
