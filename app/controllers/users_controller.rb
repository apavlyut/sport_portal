class UsersController < ApplicationController
  layout 'application'
  
  def index
    @users = User.find(:all)
  end
  
  #This show action only allows users to view their own profile
  def show
    id = params[:id].to_i
    id_a = Friendship.find(:all, :conditions => ['a = ? and status > 0', id])
    id_b = Friendship.find(:all, :conditions => ['b = ? and status > 0', id])
    ids = []
    id_a.each do |a|
      ids << a.b
    end
    id_b.each do |b|
      ids << b.a
    end
    @friends = User.find_all_by_id(ids)
    @they_are_friends = true if ids.include?(current_user.id.to_s)
    if id == current_user.id
      showToCurrent
    else
      showToAnother
    end
    @user = current_user
  end
  
  def showToCurrent
    @user = current_user
    # render :text => "text to render..."
  end
  
  def showToAnother
    @user = User.find(params['id'])
    render :action => "showToAnother"
  end
    
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    cookies.delete :auth_token
    # params[:user]['activated_at'] = Time.now
    @user = User.new(params[:user])
    @user.save!
    # Uncomment to have the user logged in after creating an account - Not Recommended
    # self.current_user = @user
  flash[:notice] = "Thanks for signing up! Please check your email to activate your account before logging in."
    redirect_to login_path    
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "There was a problem creating your account."
    render :action => 'new'
  end
  
  def edit
    @user = current_user
  end

  def admin_edit
    @user = User.find(params[:id])
		@roles = Role.public_roles
  end
  
  def admin_update
    @user = User.find(params['id'])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
      # render :text => params
      redirect_to :action => 'admin_show', :id => @user
    else
      redirect_to :back
    end  
  end
  
  def admin_show
    @user = User.find(params['id'])
  end
  
  def update
    @user = User.find(current_user)
    if @user.update_attributes(params[:user])
      flash[:notice] = "Профиль обновлен"
      redirect_to :back
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :back
    # if @user.update_attribute(:enabled, false)
    #   flash[:notice] = "User disabled"
    # else
    #   flash[:error] = "There was a problem disabling this user."
    # end
    # redirect_to :action => 'index'
  end
   
  def enable
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, true)
      flash[:notice] = "User enabled"
    else
      flash[:error] = "There was a problem enabling this user."
    end
      redirect_to :action => 'index'
  end
 
  def addFriend
    current = current_user.id
    friend = params[:id]
    error = true if current == friend
    error = true if areFriends?(current, friend)
    unless error
      friendship = Friendship.new(:a => current, :b => friend, :status => 0)
      if friendship.save
        message = Message.new
        message.sendInvite(current, current_user.login, friend)
        flash[:notice] = 'Пользователю отправлен запрос о добавлении в друзья'
      else
        flash[:error] = 'Ошибка! Невозможно добавить в друзья'
      end
    else
      flash[:error] = 'Ошибка'
    end
    redirect_to :back
  end
  
  def acceptInvite
    a = current_user.id
    b = params[:id]
    unless areFriends?(a,b)
      error = true
      flash[:error] = 'Инвайт не найден'
    end
    friends = Friendship.find(:first, :conditions => ['((a = ? and b =? and status = 0) or (a = ? and b =? and status = 0)) ', a,b, b,a])
    if friends.nil? and !error
      error = true
      flash[:error] = 'Инвайт уже был активирован ранее'
    end
    begin
      friends.update_attribute(:status, 1)
    rescue
      flash[:error] = 'Что-то пошло не так во время добавления нового друга =('
    else
      flash[:notice] = 'Инвайт активирован. У вас появился новый друг!'
    end
    redirect_to :back
  end
  
  def ignoreInvite
    a = current_user.id
    b = params[:id]
    unless areFriends?(a,b)
       error = true
       flash[:error] = 'Инвайт не найден'
     end
     friends = Friendship.find(:first, :conditions => ['((a = ? and b =? and status = 0) or (a = ? and b =? and status = 0)) ', a,b, b,a])
     if friends.nil? and !error
       error = true
       flash[:error] = 'Инвайт уже был активирован ранее'
     end
     begin
       friends.destroy
     rescue
       flash[:error] = 'Что-то пошло не так'
     else
       flash[:notice] = 'Инвайт удален'
     end
     redirect_to :back
  end
  
  private 
  # Проверяем, отправлено ли приглашение
  def areFriends?(a,b)
    friends = Friendship.find(:first, :conditions => ['(a = ? and b =?) or (a = ? and b =?)', a,b, b,a])
    res = false
    res = true unless friends.nil?
    res
  end
  
end