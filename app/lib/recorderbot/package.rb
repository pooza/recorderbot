module Recorderbot
  module Package
    def environment_class
      return Environment
    end

    def package_class
      return Package
    end

    def config_class
      return Config
    end

    def http_class
      return HTTP
    end

    def self.name
      return 'recorderbot'
    end

    def self.version
      return Config.instance['/package/version']
    end

    def self.url
      return Config.instance['/package/url']
    end

    def self.full_name
      return "#{name} #{version}"
    end

    def self.user_agent
      return "#{name}/#{version} (#{url})"
    end
  end
end
