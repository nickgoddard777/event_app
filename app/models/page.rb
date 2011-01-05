class Page < ActiveRecord::Base
	attr_accessible :title, :page_type, :body
	
	validates	:title,			:presence	=> true
	
	validates	:body,			:presence	=> true
	
	validates	:page_type,		:presence	=> true,
								:inclusion 	=> %w[home contact about lisavickerage ellenwray],
								:uniqueness	=> true
end
