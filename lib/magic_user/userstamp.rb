require 'active_support/core_ext/class/attribute'

module MagicUser
  module Userstamp
    extend ActiveSupport::Concern

    included do
      class_attribute :record_userstamps, :instance_writer => false
      self.record_userstamps = true
    end
    
    private
    
    def create
      if self.record_userstamps
        magic_user = User.current # TODO: Should be more flexible

        all_userstamp_attributes.each do |column|
          write_attribute(column.to_s, magic_user.present? ? magic_user.id : magic_user) if respond_to?(column) && self.send(column).nil?
        end
      end

      super
    end

    def update(*args)
      if should_record_userstamps?
        magic_user = User.current # TODO: Should be more flexible

        userstamp_attributes_for_update_in_model.each do |column|
          column = column.to_s
          next if attribute_changed?(column)
          write_attribute(column, magic_user.present? ? magic_user.id : magic_user)
        end
      end
      super
    end

    def should_record_userstamps?
      self.record_userstamps && (!partial_updates? || changed? || (attributes.keys & self.class.serialized_attributes.keys).present?)
    end

    def userstamp_attributes_for_create_in_model
      userstamp_attributes_for_create.select { |c| self.class.column_names.include?(c.to_s) }
    end

    def userstamp_attributes_for_update_in_model
      userstamp_attributes_for_update.select { |c| self.class.column_names.include?(c.to_s) }
    end

    def all_userstamp_attributes_in_model
      userstamp_attributes_for_create_in_model + userstamp_attributes_for_update_in_model
    end

    def userstamp_attributes_for_update
      [:updated_by]
    end

    def userstamp_attributes_for_create
      [:created_by]
    end

    def all_userstamp_attributes
      userstamp_attributes_for_create + userstamp_attributes_for_update
    end
    
  end
end