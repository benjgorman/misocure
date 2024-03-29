class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def verify
    
    #@user = User.find_by_verify_token(params[:id])
    @user = User.find(:all, :conditions => {:verify_token => params[:id]})
    
    if @user.nil?
      render :action => "notverified"
    end
    
    found = 0
      
     @user.each_with_index do |user, i|
          user.update_attribute(:status, 1)
          found = 2
      end
     
     
    if found == 0
      render :action => "notverified"
    end
    
    if found == 1
      render :action => "reverified"
    end
    
    if found == 2
      render :action => "verify"
    end
    
  end
  
  def index
    @title = "Browse users" 
    @users = User.search(params[:search])
  end
  
  def show
    @user = User.find_by_id(params[:id])
    if @user.nil?
      render :action => "notfound"
    else
    @artists = @user.artists.paginate(:page => params[:page])
    @title = @user.name
    end
  end
  
  def new
    @user = User.new
    @title = "Sign Up"
  end
  
  def create
    @user = User.new(params[:user])
    @user.status = 0
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample App!"
      MisocureMailer.welcome_email(@user).deliver
      redirect_to @user
    else
      @title = "Sign Up"
      @user.password = nil 
      @user.password_confirmation = nil 
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
