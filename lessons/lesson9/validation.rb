module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstantMethods
  end

  module ClassMethods

    def presence(name)
      name.nil? && name.strip.empty?
    end

    def format(number, format)
      number !~ format
    end

    def type(name, type_required)
      name.class != type_required
    end

    def validate(name, type_of_validation, *extra)
      case type_of_validation.to_sym
      when :presence
        raise StandardError, "Your name isn't validated!" if presence(name)
      when :format
        raise StandardError, "Your number isn't validated!" if format(name, extra[0])
      when :type
        raise StandardError, "Your object isn't a required type" if type(name, extra[0])
      else
        puts 'Wrong type of validation, try again'
      end
    end
  end

  module InstantMethods
    # Содержит инстанс-метод validate!, который запускает все проверки (валидации),
    # указанные в классе через метод класса validate.
    # В случае ошибки валидации выбрасывает исключение с сообщением о том,
    # какая именно валидация не прошла

    def validate!(*args)
      self.class.validate :args[0], args[1]
      self.class.
    end

    # Содержит инстанс-метод valid? который возвращает true,
    # если все проверки валидации прошли успешно и false, если есть ошибки валидации.

    def validate!

    end
  end

end