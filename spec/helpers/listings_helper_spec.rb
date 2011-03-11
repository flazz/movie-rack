require "spec_helper"

describe ListingsHelper do

  describe "#select_half_hour" do
    let(:tag) { helper.select_half_hours('time_to_go') }

    it "should have every half hour in the day" do

      (1..12).each do |n|
        tag.should include("#{n}:00 am")
        tag.should include("#{n}:30 am")
        tag.should include("#{n}:00 pm")
        tag.should include("#{n}:30 pm")
      end

      tag.scan(/<option\s/).size.should == 48
    end

  end

end
