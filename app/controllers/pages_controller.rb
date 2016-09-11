class PagesController < ApplicationController
   before_action :authenticate_user!, :except => [:home]

  def home
    render(:layout => "layouts/home")
  end

  def dashboard
    render(:layout => "layouts/dashboard")
  end
  
  def select_parts
  end
end
