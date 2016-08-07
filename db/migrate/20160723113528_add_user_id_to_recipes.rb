class AddUserIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :user_id, :integer
  end
end
# This page was created when we generate the following: rails generate migration add_user_id_to_articles.
# In order to have a user_id in the recipe table we need to add the following a column:
# add_column :recipes, :user_id, :integer