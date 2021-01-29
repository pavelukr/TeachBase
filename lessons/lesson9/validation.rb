module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstantMethods
  end

  module ClassMethods
    attr_reader :list_of_validations

    def validate(name, type_of_validation, extra = nil)
      @list_of_validations = []
      @list_of_validations.push([type_of_validation, name, extra])
    end

    private

    def presence(name)
      name.nil? && name.strip.empty?
    end

    def format(number, format)
      number !~ format
    end

    def type(name, type_required)
      name.class != type_required
    end
  end

  module InstantMethods
    # Содержит инстанс-метод valid? который возвращает true,
    # если все проверки валидации прошли успешно и false, если есть ошибки валидации.

    def validate!
      self.class.list_of_validations.each do |validation|
        case validation[0].to_sym
        when :presence
          raise StandardError, "Your name isn't validated!" if send(:presence, validation[0][0])
        when :format
          raise StandardError, "Your number isn't validated!" if send(:format, validation[0], validation[0][0])
        when :type
          raise StandardError, "Your object isn't a required type" if send(:type, validation[0], validation[0][0])
        else
          puts 'Wrong type of validation, try again'
        end
      end
    end
  end
end
