#!/usr/bin/env ruby

require 'test/unit'
require 'test/preload'
require 'builder'
require 'builder/css'

class TestCSS < Test::Unit::TestCase
  def setup
    @css = Builder::CSS.new
  end

  def test_create
    assert_not_nil @css
  end

  def test_block
    @css.body {
      color 'green'
    }
    assert_equal "body {\n  color: green;\n}\n\n", @css.target!
  end
    
  def test_attribute
    @css.color 'green'
    assert_equal "  color: green;\n", @css.target!
  end

  def test_id
    @css.id!('nav') { color 'green' }
    assert_equal "#nav {\n  color: green;\n}\n\n", @css.target!
  end

  def test_class
    @css.class!('nav') { color 'green' }
    assert_equal ".nav {\n  color: green;\n}\n\n", @css.target!
  end

  def test_elem_with_id
    @css.div(:id => 'nav') { color 'green' }
    assert_equal "div#nav {\n  color: green;\n}\n\n", @css.target!
  end

  def test_elem_with_class
    @css.div(:class => 'nav') { color 'green' }
    assert_equal "div.nav {\n  color: green;\n}\n\n", @css.target!
  end

  def test_comment
    @css.comment!('foo')
    assert_equal "/* foo */\n", @css.target!
  end

  def test_selector
    @css.a(:hover) { color 'green' }
    assert_equal "a:hover {\n  color: green;\n}\n\n", @css.target!
  end
end
