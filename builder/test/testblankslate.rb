#!/usr/bin/env ruby

require 'test/unit'
require 'test/preload'
require 'builder/blankslate'

module Kernel
  def late_addition
    1234
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
    assert_equal :late_addition, Kernel.k_added_name
    assert_equal :another_late_addition, Object.o_added_name
  end
end

