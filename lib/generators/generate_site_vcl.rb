module Varnish
	class GenerateSiteVcl
		attr_accessor :domain, :template, :default_domains, :valid_domains

		def initialize(domain)
			self.domain = domain
			self.template = File.new("#{VARNISH_BASE_DIR}/templates/varnish/site.vcl.erb").read
		end

		def template_url_for(domain, page)
			"&domain=#{domain.name}"+
			"&plugin_url=#{page.plugin_url.nil? ? '/' : page.plugin_url}"+
			"&group_name=#{Odania.varnish_sanitize(page.group_name)}"
		end

		# Checks if anything would be generated for this domain
		def generates_varnish_config?
			return true unless domain.get_redirects.empty?
			domain.subdomains.each_pair do |_name, subdomain|
				return true unless subdomain.get_redirects.empty?
				return true unless subdomain.assets.empty?
				return true unless subdomain.web.empty?
			end
			false
		end

		def general_subdomain
			self.domain['_general']
		end

		def render
			Erubis::Eruby.new(self.template).result(binding)
		end

		def write(out_dir)
			File.write("#{out_dir}/sites/#{self.domain.name}.vcl", self.render)
		end
	end
end
