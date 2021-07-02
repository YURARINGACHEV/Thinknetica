module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(names, type_validate, param = '')
      self.validations ||= []
      val = { type_validate => { name: names, param: param } }
      validations << val
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |val|
        val.each do |type_validate, params|
          value = get_instance(params[:name])
          send(type_validate, value, params[:param])
        end
      end
    end

    def get_instance(name)
      instance_variable_get("@#{name}")
    end

    def presence(value, _param)
      raise 'значение атрибута не должно быть nil и пустой строкой.' if value.nil? || value.empty?
    end

    def format(value, format)
      raise 'Значение не соответствует формату' if value !~ format
    end

    def type(value, type_class)
      raise 'Объект не соответствует классу' unless value.is_a?(type_class)
    end
  end
end
