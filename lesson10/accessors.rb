# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*attr_methods)
    attr_methods.each do |method|
      name_method = "@#{method}"
      history_method = "@#{method}_history"
      define_method("#{method}_history") { instance_variable_get(history_method) }
      define_method("#{method}=") do |value|
        instance_variable_set(name_method, value)
        if instance_variable_get(history_method).nil?
          instance_variable_set(history_method, [instance_variable_get(name_method)])
        else
          instance_variable_get(history_method) << instance_variable_get(name_method)
        end
      end
      define_method(method) { instance_variable_get(name_method) }
    end
  end

  def strong_attr_acessor(name_attr, type, attribute_class)
    # name_attr = "#{name}".to_sym
    value = attribute_class.instance_variable_get(name_attr)
    if value.is_a?(type)
      puts attribute_class.to_s
      define_method("@#{value}=".to_sym) do |val|
        instance_variable_set(value, val)
      end
    else
      raise TypeError
    end
  end
end

class Test
  extend Accessors

  attr_accessor :b, :attribute_class

  attr_accessor_with_history :a, :s
  # strong_attr_acessor :b, String
  def initialize(b)
    @b = b
    @attribute_class = self
  end
end
