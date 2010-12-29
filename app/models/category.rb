class Category < ActiveRecord::Base
	attr_accessible :name, :description
	
	has_many :events
	
	validates		:name,	:presence 		=> true,
							:uniqueness 	=> { :case_sensitive => false }
	
	validates		:description,	:presence => true
	
end
