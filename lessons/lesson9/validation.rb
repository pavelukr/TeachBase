require 'pry'

module Validation

  def self.included(base)
    base.extend ClassMethods

    base.send :include, InstantMethods
  end

  module ClassMethods
    attr_reader :list_of_validations,
                :counter

    def validate(type_of_validation, parameter, extra = nil)
      puts parameter
      @list_of_validations ||= []
      @list_of_validations.push([parameter, type_of_validation, extra])
    end
  end

  module InstantMethods
    def validate!
      self.class.list_of_validations.each do |validation|
        case validation[1]
        when :presence
          raise StandardError, "Your parameter isn't validated!" if send(:presence, validation[0])
        when :format
          raise StandardError, "Your number isn't validated!" if send(:format, validation[0],
                                                                      validation[2])
        when :type
          raise StandardError, "Your object isn't a required type" if send(:type, validation[0],
                                                                                      validation[2])
        end
      end
    end

    private

    def presence(name)
      name.nil? && name.strip.empty?
    end

    def format(number, format)
      number !~ format
    end

    def type(parameter, type_required)
      parameter.class != type_required
    end
  end
end
