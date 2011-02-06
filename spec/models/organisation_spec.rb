require 'spec_helper'

describe Organisation do

  it "should map to a user" do
     user = Factory.create :user
     org = Factory.create :organisation
     org.users << user

     Organisation.find_by_name(org.name).users.should == [user]

  end
end
