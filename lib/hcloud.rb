# frozen_string_literal: true

require "active_model"
require "active_support/all"
require 'active_support/dependencies'
# require "zeitwerk"

require "byebug" if ENV["ENV"] == "development"

module HCloud
  class << self
    # Code loader instance
    # attr_reader :loader

    def root
      @root ||= Pathname.new(File.expand_path(File.join("..", ".."), __FILE__))
    end

    def setup
      # @loader = Zeitwerk::Loader.for_gem

      # Register inflections
      # require root.join("config/inflections.rb")

      # Collapse resources
      # loader.collapse(
      Dir[root.join('lib/hcloud/entities/*.rb')].each do |f| 
        require f
        ActiveSupport::Dependencies.autoload_paths += "#{f}" 
      end
      Dir[root.join('lib/hcloud/concerns/*.rb')].each do |f| 
        require f
        ActiveSupport::Dependencies.autoload_paths += "#{f}" 
      end
      Dir[root.join('lib/hcloud/resources/*.rb')].each do |f| 
        require f
        ActiveSupport::Dependencies.autoload_paths += "#{f}" 
      end
      Dir[root.join('lib/hcloud/*.rb')].each do |f| 
        require f
        ActiveSupport::Dependencies.autoload_paths += "#{f}" 
      end

      # Load types
      require root.join("lib/hcloud/resource_type")

      # loader.setup
      # loader.eager_load
    end
  end
end

HCloud.setup
