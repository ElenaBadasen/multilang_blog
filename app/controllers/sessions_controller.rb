class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      p "HERE"
      log_in user
      redirect_to categories_path(user.name)
      # Log the user in and redirect to the user's show page.
    else
      # Create an error message.
      p "ERROR"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
