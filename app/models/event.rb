# == Schema Information
# Schema version: 20101216010006
#
# Table name: events
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  start_date  :date
#  end_date    :date
#  link_url    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Event < ActiveRecord::Base
	attr_accessible :title, :description, :start_date, :end_date, :link_url, :category_id
	
	belongs_to :category
	
	url_regex = /^(http|https)(:\/\/)[a-z0-9]+([-.]{1}[a-z0-9]+)*/i
	
	validates	:title,			:presence => true
	
	validates	:description,	:presence => true
	
	validate	:start_date_cannot_be_in_the_past
	
	validate	:end_date_cannot_be_earlier_than_the_start_date
	
	validates	:link_url,		:format	=> { :with => url_regex }
	
	def start_date_cannot_be_in_the_past
		errors.add(:start_date, "can't be in the past") if !start_date.blank? and start_date < Date.today
	end
	
	def end_date_cannot_be_earlier_than_the_start_date
		errors.add(:end_date, "can't be before the start date") if !end_date.blank? and end_date <= start_date
	end
end
