#!/usr/bin/env ruby

#--
# Portions copyright 2011 by Bart ten Brinke (info@retrosync.com).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#++

require 'test/unit'
require 'test/preload'
require 'builder'

class TestMethodCaching < Test::Unit::TestCase

  def test_method_call_caching
    xml = Builder::XmlMarkup.new
    xml.cache_me
    assert xml.respond_to?(:cache_me)
  end

end

