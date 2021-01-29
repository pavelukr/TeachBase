module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstantMethods
  end

  module ClassMethods
    attr_accessor :history

    def push_values(name, value)
      self.history ||= {}
      self.history[name] ||= []
      self.history[name].push(value)
    end

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          self.class.push_values(name, value)
          instance_variable_set(var_name, value)
        end
      end
    end

    def strong_attr_accessor(object, class_name)
      raise ArgumentError, "The #{object} isn't example of #{class_name}" unless object.instance_of? class_name

      var_name = "@#{object}".to_sym
      define_method(object) { instance_variable_get(var_name) }
      define_method("#{object}=".to_sym) { |value| instance_variable_set(var_name, value) }
    end
  end

  module InstantMethods
    def variable_history(name)
      puts name == 'a'
      self.class.history[name.to_sym]
    end
  end
end
