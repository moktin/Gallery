class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_adminship

end
