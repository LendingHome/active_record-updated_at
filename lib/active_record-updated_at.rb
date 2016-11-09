require "active_record"
require_relative "active_record/updated_at/relation"

module ActiveRecord
  module UpdatedAt
    ActiveRecord::Relation.send(:prepend, Relation)

    class << self
      def disable(state = true)
        disabled_was = @disabled
        @disabled = state
        yield
      ensure
        @disabled = disabled_was
      end

      def enable(&block)
        disable(false, &block)
      end

      def enabled?
        !@disabled
      end
    end
  end
end
