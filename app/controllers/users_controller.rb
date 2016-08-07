class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]#Before filters use the before_action command to arrange for a particular method to be called before the given actions.
  before_action :require_same_user, only: [:edit, :update, :destroy]# this will require the same user who created the account to perform only edit, update actions 
  before_action :require_admin, only: [:destroy]# this will require the same user who created the recipes to perform only edit, update and destroy actions 

    
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 2)
    #Source: https://www.railstutorial.org/book/updating_and_deleting_users
    #Source: https://hackhands.com/pagination-rails-will_paginate-gem/
  end
    
  def show
    @user_recipes = @user.recipes.paginate(page: params[:page], per_page: 1) 
    #Source: https://www.railstutorial.org/book/updating_and_deleting_users
    #Source: https://hackhands.com/pagination-rails-will_paginate-gem/
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User and all recipes created by user have been deleted' }
    end
  end
  
  def edit
  end
  
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_path(@user), notice: 'Welcome to COOK IT APP #{@user.username}' }
      else
        format.html { render :new }
      end
    end
  end
  


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to recipes_path, notice: 'Your account was updated successfully' }
      else
        format.html { render :edit }
      end
    end
  end



  
  
  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
      @user = User.find(params[:id]) #Source:https://www.railstutorial.org/book/updating_and_deleting_users
    end
  
  
  def require_same_user
    if current_user != @user and !current_user.admin? # this statemnet checks if the curent user is not the recipe creator and not the admin
        respond_to do |format| 
          format.html { redirect_to root_path, notice: 'You can only edit your own account' }
        end
    end
  end
  
  def require_admin
    if logged_in? and !current_user.admin? # this statemnet checks if the curent user is not the recipe creator and not the admin
        respond_to do |format| 
          format.html { redirect_to root_path, notice: 'Only admin users can perform that action' }
        end
    end
  end
end

#this code:  @user = User.find(params[:id]) 
#source:https://www.railstutorial.org/book/updating_and_deleting_users
