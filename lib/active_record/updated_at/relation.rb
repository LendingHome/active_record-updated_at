module ActiveRecord
  module UpdatedAt
    module Relation
      def update_all(query, *args, &block)
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

        super
      end
    end
  end
end
