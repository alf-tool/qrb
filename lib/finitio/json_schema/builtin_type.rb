module Finitio
  module JsonSchema

    BUILTIN_MAPPING = {
      NilClass => "null",
      String => "string",
      Integer => "integer",
      Fixnum => "integer",
      Bignum => "integer",
      Float => "number",
      Numeric => "number"
    }

  end
  class BuiltinType

    def to_json_schema(*args, &bl)
      mapped = JsonSchema::BUILTIN_MAPPING[ruby_type]
      if mapped
        { type: mapped }
      else
        raise JsonSchema::Error, "Unable to map #{ruby_type} to json-schema"
      end
    end

  end # class BuiltinType
end # module Finitio
