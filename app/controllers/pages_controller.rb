class PagesController < ApplicationController
  # before_filter :authenticate_user!

  def home
    render(:layout => "layouts/home")
  end

  def dashboard
    render(:layout => "layouts/dashboard")
  end
  
  def select_parts
  end
end
