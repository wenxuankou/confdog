# frozen_string_literal: true

module Confdog
  class Configuration
    attr_writer :url, :prefix

    def url
      @url ||= "redis://127.0.0.1:6379/1"
    end

    def prefix
      @prefix ||= "confdog"
    end
  end
end
