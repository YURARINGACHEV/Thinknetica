
module Accessors
  def attr_accessor_with_history(*attr_methods)
    attr_methods.each do |method|
      name_method = "@#{method}"
      history_method = "@#{method}_history"  
      define_method("#{method}_history") {instance_variable_get(history_method)}
      define_method("#{method}=") do |value|
        instance_variable_set(name_method, value)
        if instance_variable_get(history_method).nil?
          instance_variable_set(history_method, [instance_variable_get(name_method)])
        else
          instance_variable_get(history_method) << instance_variable_get(name_method)
        end
      end
      define_method(method) {instance_variable_get(name_method)}
    end
  end

  def strong_attr_acessor(name_attr,type)
    name_attr = "@#{name}"
    define_method(name_attr) {instance_variable_get(name_attr)}
    define_method("@#{name_attr}=") do |value|
      if value.is_a?(type)
        instance_variable_set(name_attr, value)
      else 
        raise TypeError
      end
    end
  end

end
class Test
  extend Accessors

  attr_accessor_with_history :a, :s
  strong_attr_acessor :b, String
  def initialize(b)
    @b = b
  end
end

# class X
#   def m 
#     puts "Hello"
#   end
  
#   def method_missing(name, *args)
#     self.class.send(:define_method, name.to_sym, lambda { |args| puts args.inspect })
#     puts "This #{name}, with arg #{args}"
#   end
# end

# class X
#   def m 
#     puts "Hello"
#   end
  
#   def method_missing(name, *args)
#     puts "This #{name}, with arg #{args}"
#   end
# end

