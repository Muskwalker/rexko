require File.dirname(__FILE__) + '/../test_helper'

class LocusTest < ActiveSupport::TestCase
  fixtures :loci, :attestations, :parses
  
  def test_attests_form
    assert loci(:natvilcius).attests?("liters"), "#attests? should report :natvilcius containing 'liters'"
    assert loci(:nemo).attests?("litres"), "#attests? should report :nemo containing 'litres'"
    
    assert !loci(:natvilcius).attests?("litres"), "#attests? should not report :natvilcius containing 'litres'"
    assert !loci(:nemo).attests?("liters"), "#attests? should not report :nemo containing 'liters'"
  end
end
