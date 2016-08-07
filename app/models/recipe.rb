class Recipe < ActiveRecord::Base
    belongs_to :user #this methode create association with user 
    has_many :likes
    validates :title, presence: true, 
                      length: {minimum: 3, maximum: 35}
    
    validates :description, presence: true, 
                            length: {minimum: 10, maximum: 10000}
    
    validates :user_id, presence: true #this will ensure every time the recipe is create the user_id is present
    
    
    #These are Like and dislike methods to count how many likes or dislike a user has received
    def thumbs_up_total 
        self.likes.where(like: true).size
    end
    def thumbs_down_total 
        self.likes.where(like: false).size
    end
    #source: Udemy course

end
