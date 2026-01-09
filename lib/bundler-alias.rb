require "bundler/alias/version"
require "bundler/friendly_errors.rb"
require "yaml"

module Bundler
  module Alias
    class << self
      attr_reader :aliases

      def register
        return if defined?(@registered) && @registered
        @registered = true

        @aliases = Hash[Bundlerbut .settings[:aliases].split(',').map {|i| i.split ':' } ]

        Bundler::Plugin.add_hook('before-install-all') do |_d|
          require "bundler/alias/dependency_patch"
          # This hook makes bundler load the plugin and monkey patch as needed.
        end

      end
    end
  end
end
