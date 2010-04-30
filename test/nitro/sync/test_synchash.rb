# TODO: Need test!!!!!

require 'sync/hash'
require 'test/unit'

class TC_SyncHash < Test::Unit::TestCase

  def test_01
    assert_nothing_raised{ @h = SyncHash.new }
  end

end


