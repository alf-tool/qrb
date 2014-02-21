module Qrb
  #
  # Abstract class for Q type (generators).
  #
  class Type

    def initialize(name)
      unless name.nil? or name.is_a?(String)
        raise ArgumentError, "String expected for type name, got `#{name}`"
      end
      @name = name
    end

    def name
      @name || default_name
    end

    def to_s
      name.to_s
    end

    def up(*args)
      raise NotImplementedError, "Missing #{self.class.name}#up"
    end

  protected

    def set_equal?(s1, s2)
      s1.size == s2.size and (s1-s2).empty?
    end

    def set_hash(arg)
      arg.map(&:hash).reduce(:^)
    end

  end # class Type
end # module Qrb
require_relative 'type/builtin_type'
require_relative 'type/union_type'
require_relative 'type/sub_type'
require_relative 'type/seq_type'
require_relative 'type/tuple_type'
require_relative 'type/relation_type'
require_relative 'type/user_type'
