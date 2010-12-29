Factory.define :event do |event|
	event.title				"New Event"
	event.description		"This is a new event"
	event.start_date		"01/01/2020"
	event.end_date			"02/01/2020"
	event.link_url			"http://www.test.com"
	event.association 		:category
end

Factory.define :category do |category|
	category.sequence(:name)	{ |n| "Category#{n}" }
	category.description		"This is a test category"
end
