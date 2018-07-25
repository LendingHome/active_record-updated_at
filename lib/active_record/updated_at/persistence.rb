module ActiveRecord
  module UpdatedAt
    module Persistence
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
          alias_method :update_columns_without_updated_at, :update_columns
          alias_method :update_columns, :update_columns_with_updated_at
        end
      end

      def update_columns_with_updated_at(attributes, &block)
        attribute_exists = attribute_names.include?("updated_at")
        already_specified = Array(attributes).flatten.grep(/\bupdated_at\b/).any?
        enabled = UpdatedAt.enabled?
        updated_at = Time.current

        if attribute_exists && !already_specified && enabled
          attributes[:updated_at] = updated_at
        end

        update_columns_without_updated_at(attributes, &block)
      end
    end
  end
end
