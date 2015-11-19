class SessionsController < ApplicationController

  before_action :validates_login, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user.nil?
      flash[:errors] = "WRONG CREDENTIALS...MAN"
      redirect_to new_session_path
    else
      login_user!(user)
      redirect_to cats_url
    end

  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_session_url
    end
  end

end
