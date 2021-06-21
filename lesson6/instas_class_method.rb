# Создать модуль InstanceCounter, содержащий 
#следующие методы класса и инстанс-методы, 
#которые подключаются автоматически при вызове 
#include в классе:
# Методы класса:
# - instances, который возвращает кол-во экземпляров 
#данного класса
# Инстанс-методы:
#  - register_instance, который увеличивает счетчик 
#кол-ва экземпляров класса и который можно 
#вызвать из конструктора. При этом данный метод 
#не должен быть публичным.
# Подключить этот модуль в классы поезда, маршрута и станции.
# Примечание: инстансы подклассов могут 
#считаться по отдельности, не увеличивая 
#счетчик инстансев базового класса.

module InstanceCounter
  
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    attr_accessor :count_instances

    def instances
      @count_instances
    end
  end

  module InstanceMethods
    
    protected

    def register_instance
      self.class.count_instances ||= 0
      self.class.count_instances += 1
    end
  end
end