#!/usr/bin/env ruby

require 'test/unit'
require 'builder/xchar'

class TestNameCollisions < Test::Unit::TestCase
  module Collide
    def xchr
    end
  end

  def test_no_collision
    assert_nothing_raised do
      Builder.check_for_name_collision(Collide, :not_defined)
    end
  end

  def test_collision
    assert_raise RuntimeError do
      Builder.check_for_name_collision(Collide, "xchr")
    end
  end

  def test_collision_with_symbol
    assert_raise RuntimeError do
      Builder.check_for_name_collision(Collide, :xchr)
    end
  end
end
