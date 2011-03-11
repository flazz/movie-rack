require 'spec_helper'

describe ShowtimesHelper do

  describe "#select_half_hours" do
    let(:tag) { helper.select_half_hours('time_to_go') }

    it "should have every half hour in the day" do

      (1..12).each do |n|
        tag.should include("#{n}:00 AM")
        tag.should include("#{n}:30 AM")
        tag.should include("#{n}:00 PM")
        tag.should include("#{n}:30 PM")
      end

      tag.scan(/<option\s/).size.should == 48
    end

  end

end
