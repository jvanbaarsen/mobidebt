class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.validate_password = true
    if @user.save
      redirect_to login_path, notice: 'Account created! Please login'
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params.require(:user).permit([:snack_credits, :drink_credits]))
      flash[:success] = 'Balance has been updated'
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def purchase
    if params[:type] == 'drink'
      current_user.purchase_drink
    else
      current_user.purchase_snack
    end
    redirect_to root_path, success: "A #{params[:type]} was purchased, credits deducted"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
