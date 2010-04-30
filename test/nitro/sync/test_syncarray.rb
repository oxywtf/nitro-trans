# TODO: Need test!!!!!!!!!

require 'sync/array'
require 'test/unit'

class TC_SyncArray < Test::Unit::TestCase

  def test_01
    assert_nothing_raised{ @s = SyncArray.new }
  end

end

