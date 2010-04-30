# Pool - Thread Safe Object Store
# Copyright (c) 2004 George Moschovitis
#
# TODO: Could use the SizedQueue/Queue?

require 'thread'
require 'monitor'

# Generalized object pool implementation. Implemented as a thread
# safe stack. Exclusive locking is needed both for push and pop.
#
class Pool < Array

  include MonitorMixin

  def initialize
    super
    @cv = new_cond()
  end

  # Add, restore an object to the pool.
  #
  def push(obj)
    synchronize do
      super
      @cv.signal()
    end
  end
  alias_method :<<, :push

  # Obtain an object from the pool.
  #
  def pop
    synchronize do
      @cv.wait_while { empty? }
      super
    end
  end

  # Obtains an object, passes it to a block for processing
  # and restores it to the pool.
  #
  def obtain
    result = nil
    begin
      obj = pop()
      result = yield(obj)
    ensure
      push(obj)
    end
    return result
  end

end

