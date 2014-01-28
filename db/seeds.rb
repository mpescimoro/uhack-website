# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_posts(titles, times)
	if titles.respond_to? :each
		titles.each do |title|
			Post.create(title: title, body: title * times, published_at: Time.now)
		end
	else
		Post.create(title: title, body: title * times, published_at: Time.now)
	end
end

Admin.delete_all
SuperUser.delete_all
Post.delete_all

Admin.create(email: 'adm@uhack.com', password: 'koala666')
SuperUser.create(email: 'giocaniato@gmail.com', username: 'gio', password: 'koala666')
SuperUser.create(email: 'pes@ci.com', username: 'pesci', password: 'koala666')
SuperUser.create(email: 'phi@ls.com', username: 'phil!', password: 'koala666')

create_posts ["Moriremo tutti", "Oggi ho fatto la cacca", "Molto interessante"], 100


