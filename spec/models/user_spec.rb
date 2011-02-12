require 'spec_helper'

describe User do


  before do
    @teacher = Factory.create :user
    @user = Factory.create :user
  end

  it "should be possible to assign 5 courses to a user via << and save at the end" do
    5.times.map do
      c = Factory.create :course, :teacher => @teacher 
      @user.courses << c
    end
    @user.save
  end

  it "should be possible to assign 5 courses to a user via << and save at the end" do
    5.times.map do
      c = Factory.create :course, :teacher => @teacher 
      @user.courses << c
    end
    lambda do
      c = Factory.create :course, :teacher => @teacher 
      @user.courses << c
    end.should raise_error
  end
end
