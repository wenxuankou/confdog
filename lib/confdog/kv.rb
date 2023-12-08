# frozen_string_literal: true

module Confdog
  class Kv
    class << self
      attr_accessor :kv_map

      def load
        keys = conn.keys("#{prefix}.*")

        keys.each do |key|
          kv_map[key] = conn.get(key)
        end
      end

      def prefix
        Confdog.configuration.prefix
      end

      def conn
        @conn ||= Redis.new url: Confdog.configuration.url
      end

      def kv_map
        @kv_map ||= {}
      end

      def get(key)
        key = "#{prefix}.#{key}"
        kv_map[key]
      end
    end
  end
end
