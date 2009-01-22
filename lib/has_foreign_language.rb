# HasForeignLanguage
module HasForeignLanguage
  def self.included(mod)
    mod.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def has_foreign_language(*args)
      args.each do |field|
        # Define the Getter
        define_method(field.to_s) do
          if I18n.locale != I18n.default_locale && self.class.columns.select {|c| c.name == "#{field}_#{I18n.locale}"}.length > 0
            result=self.send("#{field}_#{I18n.locale}".to_sym)
            result.blank? ? super : self.send("#{field}_#{I18n.locale}".to_sym) #falling back to default if requested locale is nil
          else
            super
          end
        end

      # Define the Setter
      define_method("#{field}=") do |val|
        if I18n.locale != I18n.default_locale && self.class.columns.select {|c| c.name == "#{field}_#{I18n.locale}"}.length > 0
          self["#{field}_#{I18n.locale}".to_sym] = val
        else
          self[field.to_sym] = val
        end
      end

      # Define the Default Getter
      define_method("#{field}_#{I18n.default_locale}") do
        self.send(field.to_sym)
      end

      # Define the Default Setter
      define_method("#{field}_#{I18n.default_locale}=") do |val|
        self[field.to_sym] = val
      end
      end
    end
  end
end
      
