module ActiveRecord
  module UpdatedAt
    module Model
      extend ActiveSupport::Concern

      included do
        alias_method :update_columns_without_updated_at, :update_columns
        alias_method :update_columns, :update_columns_with_updated_at
      end

      def update_column_without_updated_at(attribute, value)
        update_columns_without_updated_at(attribute => value)
      end

      def update_columns_with_updated_at(attributes)
        attribute_exists = has_attribute?(:updated_at)
        already_specified = attributes.with_indifferent_access.key?(:updated_at)

        if attribute_exists && !already_specified
          attributes[:updated_at] = Time.current
        end

        update_columns_without_updated_at(attributes)
      end
    end
  end
end
