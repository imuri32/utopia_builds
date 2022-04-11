class HomeController < ApplicationController
  def index
  end

  def contact
    @contacts = Contact.all
  end
end
