require 'spec_helper'

describe Movie do

  it 'should be invalid without a title' do
    t = Movie.new
    t.should_not be_valid
    t.errors[:title].should include("can't be blank")
  end

  it 'should be valid with a title' do
    t = Movie.new :title => 'Napoleon Dynamite'
    t.should be_valid
    t.errors[:title].should be_empty
  end

end
