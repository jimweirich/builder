#!/usr/bin/env ruby

# We are defining method_added in Kernel and Object so that when
# BlankSlate overrides them loater, we can verify that it correctly
# calls the older hooks.

module Kernel
  class << self
    attr_reader :k_added_name
    alias_method :preload_method_added, :method_added
    def method_added(name)
      preload_method_added(name)
      @k_added_name = name
    end
  end
end

class Object
  class << self
    attr_reader :o_added_name
    alias_method :preload_method_added, :method_added
    def method_added(name)
      preload_method_added(name)
      @o_added_name = name
    end
  end
end
