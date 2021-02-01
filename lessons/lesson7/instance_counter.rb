module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstantMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstantMethods
    protected

    def register_instance
      if !self.class.instances.nil?
        self.class.instances += 1
      else
        self.class.instances = 1
      end
    end
  end
end
