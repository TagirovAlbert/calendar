class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to events_path

    end
  end

  def help
  end

  def about
  end
end
