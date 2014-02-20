module Qrb
  class UpHandler

    def initialize
      @stack = []
    end

    def deeper(location)
      @stack.push(location.to_s)
      res = yield
    ensure
      @stack.pop
      res
    end

    def just_try
      [ true, yield ]
    rescue UpError => cause
      [ false, nil ]
    end

    def try(type, value)
      yield
    rescue UpError => cause
      failed!(type, value, cause)
    end

    def failed!(type, value, cause = nil)
      msg = default_error_message(type, value)
      raise UpError.new(msg, cause, location)
    end

    def fail!(msg, cause = nil)
      raise UpError.new(msg, cause, location)
    end

    def default_error_message(type, value)
      value_s, type_s = value_to_s(value), type_to_s(type)
      "Invalid value `#{value_s}` for #{type_s}"
    end

    def location
      @stack.join('/')
    end

  private

    def value_to_s(value)
      s = value.to_s
      s = "#{s[0..25]}..." if s.size>25
      s
    end

    def type_to_s(type)
      type.name.to_s
    end

  end # class UpHandler
end # module Qrb
