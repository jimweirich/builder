#!/usr/bin/env ruby

require 'test/unit'
require 'test/preload'
require 'builder/blankslate'

module Kernel
  def late_addition
    1234
  end

  def double_late_addition
    11
  end

  def double_late_addition
    22
  end
end



class Object
  def another_late_addition
    4321
  end
end

class TestBlankSlate < Test::Unit::TestCase
  def setup
    @bs = Builder::BlankSlate.new
  end
  
  def test_create
    assert nil != @bs
  end

  def test_undefined
    assert_raise(NoMethodError) { @bs.no_such_method }
    assert_raise(NoMethodError) { @bs.nil? }
  end

  def test_no_later_additions
    assert_raise(NoMethodError) { @bs.late_addition }
    assert_raise(NoMethodError) { @bs.another_late_addition }
  end

  def test_preload_method_added
    assert Kernel.k_added_names.include?(:late_addition)
    assert Object.o_added_names.include?(:another_late_addition)
  end

  def test_double_defined_method
    assert_raise(NoMethodError) { @bs.double.late_addition }
  end
end

