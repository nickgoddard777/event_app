require 'faker'

namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		Event.create!(	:title => "Example Event",
						:description =>	"This is an example event",
						:start_date => "01/01/2020",
						:end_date => "03/01/2020",
						:link_url => "http://www.test.com")
		99.times do |n|
			Event.create!(	:title => "Example Event",
							:description =>	"This is an example event",
							:start_date => "01/01/2020",
							:end_date => "03/01/2020",
							:link_url => "http://www.test.com")	
		end
	end
end
			