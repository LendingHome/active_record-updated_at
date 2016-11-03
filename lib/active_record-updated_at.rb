require "active_record"
require_relative "active_record/updated_at/model"
require_relative "active_record/updated_at/relation"

module ActiveRecord
  Base.send(:include, UpdatedAt::Model)
  Relation.send(:include, UpdatedAt::Relation)
  Querying.delegate(:update_all_with_updated_at, :update_all_without_updated_at, to: :all)
end
