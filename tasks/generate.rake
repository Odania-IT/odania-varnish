namespace :varnish do
	desc 'Generate varnish config'
	task :generate do
		out_dir = ENV['OUT_DIR'].nil? ? '/etc/varnish' : ENV['OUT_DIR']
		Varnish.generate out_dir
		Varnish.reload_config
	end
end
