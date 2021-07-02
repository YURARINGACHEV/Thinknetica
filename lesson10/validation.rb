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

  	def validate!(attribute_class)
  		self.class.validations.each do |val|
        val.each do |type_validate, params|
          puts "#{type_validate}, params #{params}"
          value = get_instance(params[:name], attribute_class)
          puts value
          attribute_class.send(type_validate, value , params[:param])
        end
      end
  	end
    
    def get_instance(name, attribute_class)
      attribute_class.instance_variable_get("@#{name}")
    end

	  def presence(value, param)
	  	raise "значение атрибута не должно быть nil и пустой строкой."  if value.nil? || value.empty?
	  end

	  def format(value, format)
      raise "Значение не соответствует формату" if value !~ format
    end

    def type(value, type_class)
      raise "Объект не соответствует классу" if value != type_class
    end
  end
end