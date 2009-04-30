module ActionView
  module Helpers
    class InstanceTag
      class << self
        def value(object, method_name)
          Rails.logger.info method_name
          method_name += "_#{I18n.locale}" if I18n.locale != I18n.default_locale && object.class.columns.select {|c| c.name == "#{method_name}_#{I18n.locale}"}.length > 0
          object.send method_name unless object.nil?
        end
        
        def value_before_type_cast(object, method_name)
          unless object.nil?
            method_name += "_#{I18n.locale}" if I18n.locale != I18n.default_locale && object.class.columns.select {|c| c.name == "#{method_name}_#{I18n.locale}"}.length > 0
            Rails.logger.info method_name
            return object.respond_to?(method_name + "_before_type_cast") ? object.send(method_name + "_before_type_cast") :object.send(method_name)
          end
        end
      end
    end
  end
end