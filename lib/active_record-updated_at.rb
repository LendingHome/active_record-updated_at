require "active_record"
require_relative "active_record/updated_at/relation"

module ActiveRecord
  module UpdatedAt
    ActiveRecord::Relation.send(:prepend, Relation)

    STATE = "#{name}::DISABLED".freeze

    class << self
      def disable(state = true)
        disabled_was = Thread.current[STATE]
        Thread.current[STATE] = state
        yield
      ensure
        Thread.current[STATE] = disabled_was
      end

      def enable(&block)
        disable(false, &block)
      end

      def enabled?
        !Thread.current[STATE]
      end
    end
  end
end
