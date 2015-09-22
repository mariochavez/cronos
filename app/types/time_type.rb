class TimeType < ActiveRecord::Type::Value
  REGEX = /^(?<time>\d*(\.\d*)?)(\s*(?<span>h|m|H|M))?$/

  def initialize(*)
    super
    @range = min_value...max_value
  end

  def type
    :integer
  end

  def cast(value)
    return nil if !value.present?

    new_value = value
    if value.is_a?(::String)
      new_value = cast_string(value)
    end

    cast_value = if new_value.nil?
                     nil
                   else
                     new_value.to_i rescue nil
                   end

    @casted_value = value != cast_value
    cast_value
  end

  def serialize(value)
    new_value = cast(value) if !value.is_a?(::Integer)

    result = new_value || value
    if result
      ensure_in_range(result)
    end
    result
  end

  def changed_in_place?(raw_old_value, new_value)
    @casted_value || false
  end

  protected

  attr_reader :range

  private

  def cast_string(value)
    new_value = nil
    valid_time = value.match(REGEX)

    if valid_time
      span_time = if valid_time[:span].try(:downcase) == 'h'.freeze
                    60
                  else
                    1
                  end
      new_value = valid_time[:time].to_d * span_time
    end

    new_value
  end

  def min_value
    1
  end

  def max_value
    1441
  end

  def ensure_in_range(value)
    unless range.cover?(value)
      raise RangeError, "#{value} is out of range for #{self.class} with limit #{max_value - 1}"
    end
  end
end
