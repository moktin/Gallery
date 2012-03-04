require 'spec_helper'

describe Admin::HomeController do
  it { should be_a(AdminController)}

  describe '#index' do
    before do
      sign_in(Factory(:admin))
      get :index
    end

    it 'is a success' do
      response.should be_success
    end
  end
end
