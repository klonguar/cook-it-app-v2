class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  #Before filters use the before_action command to arrange for a particular method to be called before the given actions,
  #This before action will restrict the filter to act only :show, :edit, :update, :destroy
  
  before_action :require_user, except: [:index, :show] 
  # This will restrit all action except the index and sow action as it needs a logged in user too perform the other action
  
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # this will require the same user who created the recipes to perform only edit, update and destroy actions 


  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 2)
    #Source: https://www.railstutorial.org/book/updating_and_deleting_users
    #https://hackhands.com/pagination-rails-will_paginate-gem/  
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user #this will ensure that recipe has a user source: video
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
  
def like
  @recipe = Recipe.find(params[:id])
  like = Like.create(like: params[:like], user: current_user, recipe: @recipe)
  respond_to do |format|
    if like.valid?
      format.html { redirect_to :back, notice: 'Your selection was successful.' }
    else
      format.html { redirect_to :back, notice: 'You can only like/dislike a recipe once.' }
    end
  end
end
#source: Udemy course



  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :description)
    end
  end
    def require_same_user
      if current_user != @recipe.user and !current_user.admin?# this statemnet checks if the curent user is not the recipe creator and not the admin 
        respond_to do |format|
          format.html { redirect_to root_path, notice: 'You can only edit your own account' }
        end
    end
  
  
end

#Source:https://www.railstutorial.org/book/updating_and_deleting_users