class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destory]
  before_action :correct_user,   only: [:edit, :update, :destory]
  
  def index
    @users = User.paginate(page: params[:page])
  end  
  
  def show
    @user=User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
   @user = User.new(user_params)
   if @user.save
      log_in @user
      flash[:success] = "おっす！"
      redirect_to @user
   else
      render 'new'
   end
  end 
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
   if @user.update_attributes(user_params)
    flash[:success] = "プロフィールが更新されました"
    redirect_to @user 
   else
  render 'edit'  
   end  
  end 
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーが削除されました"
    redirect_to root_url
  end  
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end   
    
   
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
end
