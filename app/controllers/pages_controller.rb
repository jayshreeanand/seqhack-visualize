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

  def select_front
  end

  def select_back
  end

  def select_arm
  end
  
  def view_model
    render(:layout => "layouts/model")
  end
  
  def ucs_config
    send_file Rails.root.join("app", "views", "pages", "UCS_config.json"), type: 'application/js'
  end
  
  def umich_ucs
    send_file Rails.root.join("app", "views", "pages", "umich_ucs.js"), type: 'text/javascript'
  end
  
  def asian_male
    send_file Rails.root.join("app", "assets", "images", "texture_background.jpg")
  end
end
