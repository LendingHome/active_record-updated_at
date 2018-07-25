require "active_record"
require_relative "active_record/updated_at/persistence"
require_relative "active_record/updated_at/relation"

module ActiveRecord
  module UpdatedAt
    ActiveRecord::Persistence.send(:include, Persistence)
    ActiveRecord::Relation.send(:include, Relation)

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
