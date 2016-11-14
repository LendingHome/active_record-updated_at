module ActiveRecord
  module UpdatedAt
    module Relation
      def self.included(base)
        base.class_eval do
          # We were originally using `prepend` to inject this behavior
          # directly into the `update_all` method but this was causing
          # `SystemStackError` exceptions when loaded alongside other
          # gems like `newrelic_rpm` which uses alias method chains.
          #
          # It's unlikely NewRelic will change their API anytime soon
          # since they have to support older versions of Ruby which do
          # not support `prepend` so we'll use this deprecated style
          # of method injection.
          #
          # Newer versions of ActiveRecord have already deprecated the
          # old `alias_method_chain` method so we're doing it manually
          # here to avoid deprecation warnings.
          alias_method :update_all_without_updated_at, :update_all
          alias_method :update_all, :update_all_with_updated_at
        end
      end

      def update_all_with_updated_at(query, *args, &block)
        attribute_exists = column_names.include?("updated_at")
        already_specified = Array(query).flatten.grep(/\bupdated_at\b/).any?
        enabled = UpdatedAt.enabled?
        updated_at = Time.current

        if attribute_exists && !already_specified && enabled
          case query
          when Array
            query.first << ", updated_at = ?"
            query << updated_at
          when Hash
            query[:updated_at] = updated_at
          when String
            query = ["#{query}, updated_at = ?", updated_at]
          end
        end

        update_all_without_updated_at(query, *args, &block)
      end
    end
  end
end
