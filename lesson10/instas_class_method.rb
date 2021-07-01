# frozen_string_literal: true

# Counter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # show instanse
  module ClassMethods
    attr_accessor :instances, :hash_train_or_staition

    def count_instances
      @instances ||= 0
      @instances
    end

    def add_train_or_staition(value)
      @hash_train_or_staition ||= {}
      @hash_train_or_staition[count_instances + 1] = value
    end
  end

  # count instance
  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
