require 'test_helper'

describe TimeType do

  let(:type) { TimeType.new }

  it 'simple values' do
    type.cast(1).must_equal 1
    type.cast(1.5).must_equal 1

    type.cast('1').must_equal 1
    type.cast('1m').must_equal 1
    type.cast('1 m').must_equal 1

    type.cast('1h').must_equal 60
    type.cast('1 h').must_equal 60

    type.cast('1.5h').must_equal 90
    type.cast('1.5 h').must_equal 90
  end

  it 'random objects cast to nil' do
    type.cast('').must_be_nil
    type.cast(nil).must_be_nil

    type.cast('1z').must_be_nil
    type.cast('1z2').must_be_nil
    type.cast('1.0 z').must_be_nil

    type.cast([1,2]).must_be_nil
    type.cast({ 1 => 2 }).must_be_nil
    type.cast((1..2)).must_be_nil
  end

  it 'casting objects without to_i' do
    type.cast(::Object.new).must_be_nil
  end

  it 'values zero or below are out of range' do
    assert_raises(::RangeError) do
      TimeType.new.serialize(0)
    end

    assert_raises(::RangeError) do
      TimeType.new.serialize(-1)
    end
  end

  it 'values above 1440 are out of range' do
    assert_raises(::RangeError) do
      TimeType.new.serialize(1441)
    end
  end

  it 'within 1 and 1440 minutes are in range' do
    TimeType.new.serialize(1).must_equal 1
    TimeType.new.serialize(500).must_equal 500
    TimeType.new.serialize(1440).must_equal 1440
  end

  it 'changed_in_place? without conversion' do
    value = type.cast(5)
    type.changed_in_place?(5, value).must_equal false
  end

  it 'changed_in_place? with string conversion' do
    value = type.cast('5m')
    type.changed_in_place?(5, value).must_equal true
  end
end
