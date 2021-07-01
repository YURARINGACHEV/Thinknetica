module Validation

	 def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    attr_accessor :validations

	  def validate(name, type_validate, param = '')
	  	self.validations ||= []
      val = { type_validate => { name: name, param: param } }
      validations << val
	  end  
  end

  module InstanceMethods

  	def validate!(station)
  		self.class.validations.each do |val|
        val.each do |type_validate, params|
          station.send(type_validate, params[:name] , params[:param])
        end
      end
  	end

	  def presence(value, param)
	  	raise "значение атрибута не должно быть nil и пустой строкой."  if value.nil? || value.empty?
	  end

	  def format(value, format)
      raise "Значение не соответствует формату" if value !~ format
    end

    def type(value, attribute_class)
      raise "Объект не соответствует классу" if attribute_class == value
    end
  end
end