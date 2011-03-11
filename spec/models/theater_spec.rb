require 'spec_helper'

describe Theater do

  it 'should be invalid without a name' do
    t = Theater.new
    t.should_not be_valid
    t.errors[:name].should include("can't be blank")
  end

  it 'should be valid with a name' do
    t = Theater.new :name => 'Gator Cinemas'
    t.should be_valid
    t.errors[:name].should be_empty
  end

end
