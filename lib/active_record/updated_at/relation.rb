module ActiveRecord
  module UpdatedAt
    module Relation
      extend ActiveSupport::Concern

      included do
        alias_method :update_all_without_updated_at, :update_all
        alias_method :update_all, :update_all_with_updated_at
      end

      def update_all_with_updated_at(query, *args, &block)
        attribute_exists = column_names.include?("updated_at")
        already_specified = Array(query).flatten.grep(/\bupdated_at\b/).any?
        updated_at = Time.current #.iso8601(6)

        if attribute_exists && !already_specified
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
