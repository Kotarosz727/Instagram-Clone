class SessionsController < ApplicationController
  
  def new
    if logged_in?
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page]).search(params[:search])
    @likes = Like.where(micropost_id: params[:micropost_id])
    end
  end

  def create
  auth = request.env['omniauth.auth']
  if auth.present?
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_back_or user
  else 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせは有効ではありません'
      render 'new'
    end
  end
end

  def destroy
    log_out
    redirect_to root_url
  end
  
end
