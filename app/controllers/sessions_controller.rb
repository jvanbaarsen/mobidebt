class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  def new
    redirect_to dashboard_path if current_user
  end

  def create
    user = login(params[:user][:email], params[:user][:password])
    if user
      redirect_to root_path, notice: "Welcome #{user.name}"
    else
      flash.now[:error] = 'Unknown/wrong credentials'
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = 'See you later, alligator'
    redirect_to login_path
  end
end
