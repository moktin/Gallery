require 'spec_helper'

describe User do

  it { should validate_presence_of(:full_name)}
  it { should_not allow_mass_assignment_of(:admin) }

  it 'validates uniqueness of full_name' do
    Factory(:user)
    User.new.should validate_uniqueness_of(:full_name)
  end

  describe '#admin?' do
    it 'return true if the user is an admin' do
      Factory(:user, :admin => true).should be_admin
    end

    it 'return false if the user is an admin' do
      Factory(:user).should_not be_admin
    end
  end
end
