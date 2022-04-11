class HomeController < ApplicationController
  def index
  end

  def contact
    @contacts = Contact.all
  end

  def about
    @abouts = About.all
  end
end
