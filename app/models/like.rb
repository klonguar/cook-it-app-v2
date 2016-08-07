class Like < ActiveRecord::Base
    belongs_to :user
    #This is an association with the user
    belongs_to :recipe
    #This is an association with the recipe
    validates_uniqueness_of :user, scope: :recipe 
    #this will make sure that the user will like or dislike only once
end
#source: Udemy course
