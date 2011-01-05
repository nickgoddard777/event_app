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

Factory.define	:admin	do |admin|
	admin.email		"test.user@user.com"
	admin.password	"secret"
end

Factory.define :page do |page|
	page.title		"Home"
	page.body		"This is a test home page"
	page.page_type	"home"
end
