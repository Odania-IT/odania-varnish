require_relative 'generate_site_vcl'

module Varnish
	class GenerateSitesVcl
		attr_accessor :domains, :template

		def initialize(domains)
			self.domains = domains
			self.template = File.new("#{VARNISH_BASE_DIR}/templates/varnish/sites.vcl.erb").read
		end

		def render
			Erubis::Eruby.new(self.template).result(binding)
		end

		def write(out_dir)
			File.write("#{out_dir}/sites.vcl", self.render)

			Dir.mkdir "#{out_dir}/sites" unless File.directory? "#{out_dir}/sites"
			self.domains.each_pair do |_domain_name, domain|
				out = GenerateSiteVcl.new(domain)
				out.write out_dir
			end
		end
	end
end
