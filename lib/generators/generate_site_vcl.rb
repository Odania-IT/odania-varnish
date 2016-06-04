module Varnish
	class GenerateSiteVcl
		attr_accessor :domain, :template, :default_subdomains

		def default_subdomain_for(domain)
			return self.default_subdomains[domain.name] unless self.default_subdomains[domain.name].nil?
			return self.default_subdomains['_general'] unless self.default_subdomains['_general'].nil?
			'www'
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

		def generates_general_varnish_config?
			subdomain = general_subdomain
			return true unless subdomain.get_redirects.empty?
			return true unless subdomain.assets.empty?
			return true unless subdomain.web.empty?
			false
		end

		def prepare_url(url)
			return "/#{url}" unless '/'.eql? url[0]
			url
		end

		def general_subdomain
			self.domain['_general']
		end

		def initialize(domain, default_subdomains)
			self.domain = domain
			self.default_subdomains = default_subdomains
			self.template = File.new("#{VARNISH_BASE_DIR}/templates/varnish/site.vcl.erb").read
			self.template = File.new("#{VARNISH_BASE_DIR}/templates/varnish/general_site.vcl.erb").read if '_general'.eql? domain.name
		end

		def render
			Erubis::Eruby.new(self.template).result(binding)
		end

		def write(out_dir)
			File.write("#{out_dir}/sites/#{self.domain.name}.vcl", self.render)
		end
	end
end
