# frozen_string_literal: true

# Counter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # show instanse
  module ClassMethods
    attr_accessor :instances

    def count_instances
      @instances ||= 0
      @instances
    end
  end

  # count instance
  module InstanceMethods
    protected

    def register_instance
      # self.class.count_instances ||= 0
      self.class.instances += 1
    end
  end
end
