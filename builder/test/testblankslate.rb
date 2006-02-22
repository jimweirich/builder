#!/usr/bin/env ruby

require 'test/unit'
require 'test/preload'
require 'builder/blankslate'

module LateObject
  def late_object
    33
  end
  def LateObject.included(mod)
    # Modules defining an included method should not prevent blank
    # slate erasure!
  end
end

module LateKernel
  def late_kernel
    44
  end
  def LateKernel.included(mod)
    # Modules defining an included method should not prevent blank
    # slate erasure!
  end
end

module Kernel
  include LateKernel

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
  include LateObject
  def another_late_addition
    4321
  end
end

class TestBlankSlate < Test::Unit::TestCase
  def setup
    @bs = BlankSlate.new
  end
  
  def test_create
    assert nil != @bs
  end

  def test_undefined_methods_remain_undefined
    assert_raise(NoMethodError) { @bs.no_such_method }
    assert_raise(NoMethodError) { @bs.nil? }
  end

  def test_methods_added_late_to_kernel_remain_undefined
    assert_equal 1234, nil.late_addition
    assert_raise(NoMethodError) { @bs.late_addition }
  end

  def test_methods_added_late_to_object_remain_undefined
    assert_equal 4321, nil.another_late_addition
    assert_raise(NoMethodError) { @bs.another_late_addition }
  end

  def test_preload_method_added
    assert Kernel.k_added_names.include?(:late_addition)
    assert Object.o_added_names.include?(:another_late_addition)
  end

  def test_method_defined_late_multiple_times_remain_undefined
    assert_equal 22, nil.double_late_addition
    assert_raise(NoMethodError) { @bs.double_late_addition }
  end

  def test_late_included_module_in_object_is_ok
    assert_equal 33, 1.late_object
    assert_raise(NoMethodError) { @bs.late_object }
  end

  def test_late_included_module_in_kernel_is_ok
    assert_raise(NoMethodError) { @bs.late_kernel }
  end
end

