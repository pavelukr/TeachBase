require 'pry'

module Validation

  def self.included(base)
    base.extend ClassMethods

    base.send :include, InstantMethods
  end

  module ClassMethods
    attr_reader :list_of_validations,
                :counter

    def validate(parameter, type_of_validation, extra = nil)
      @list_of_validations ||= []
      @list_of_validations.push([parameter, type_of_validation, extra])
    end
  end

  module InstantMethods
    def validate!
      binding.pry
      self.class.list_of_validations.each do |validation|
        if validation[2].nil?
          send((validation[1]).to_s, validation[0])
        else
          send((validation[1]).to_s, validation[0], validation[2])
        end
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def presence(name)
      var_value = instance_variable_get("@#{name}".to_s)
      if var_value.nil? || var_value.strip.empty?
        raise StandardError, "Your parameter isn't validated!"
      end
    end

    def format(number, format)
      var_value = instance_variable_get("@#{number}".to_s)
      if var_value !~ format
        raise StandardError, "Your number isn't validated!"
      end
    end

    def type(parameter, type_required)
      var_value = instance_variable_get("@#{parameter}".to_s)
      unless var_value.instance_of? type_required
        raise StandardError, "Your object isn't a required type"
      end
    end
  end
end
