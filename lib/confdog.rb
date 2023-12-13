# frozen_string_literal: true

require "redis"

require_relative "confdog/version"
require_relative "confdog/configuration"
require_relative "confdog/kv"

module Confdog
  class << self
    def version
      VERSION
    end

    def setup
      yield configuration if block_given?
      Kv.load
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def [](key)
      Kv.get key
    end

    def method_missing(method_name)
      Kv.get method_name
    end
  end
end
