module Content
  module Attributes

    extend ActiveSupport::Concern
    GLOBAL_RESTRICTED_PARAMTERS = %w{id created_at updated_at}

    def self.get_attributes(table_name)
      @attributes ||= (table_name.columns + table_name.reflect_on_all_associations).map { |c| c.name.to_s }
    end

    def get_allowed_attributes
      self.attributes.keys.select{|key| self.respond_to?(key)} - GLOBAL_RESTRICTED_PARAMTERS
    end

    included do
      def self.blocked_attributes
        @blocked_attributes || []
      end

      def self.restrict_attrs(*attribute_names)
     
        @blocked_attributes = attribute_names.map(&:to_s)
        @blocked_attributes.map! { |name| [name, "#{name}="] }
        @blocked_attributes.flatten!

        @blocked_attributes.each do |name|
          hide_method(name)
        end
      end

      def self.hide_method(name)
        define_method(name) do |*args, &block|
          raise_no_method_error_on(name)
        end
      end
    end

    def respond_to?(*method_names)
      method_names.all? do |name|
        next false if self.class.blocked_attributes.include?(name.to_s)
        super(name)
      end
    end

  private

    def raise_no_method_error_on(name)
      klass, type = self.class.name, attributes['type']
      type_name = (klass == type) ? klass : "#{klass}<#{type}>"
      message = "`#{name}' cannot be called on #{type_name} objects"
      raise NoMethodError, message
    end

  end
end