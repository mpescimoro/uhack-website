# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.delete_all
SuperUser.delete_all
Post.delete_all
Tag.delete_all
#Tagship.delete_all

Admin.create(email: 'adm@uhack.com', password: 'koala666')
SuperUser.create(email: 'giocaniato@gmail.com', username: 'gio', password: 'koala666')
SuperUser.create(email: 'pes@ci.com', username: 'pesci', password: 'koala666')
SuperUser.create(email: 'phi@ls.com', username: 'phil!', password: 'koala666')
SuperUser.create(email: 'gue@st.com', username: 'guest', password: 'koala666')

tag_names = %w{wolololo y_u_no_hack programming hardware stuff courses}
%w{I\ gelati\ sono\ buoni Molto\ interessante Hack\ Hack\ Hack}.each_with_index do |title, i|
	post = Post.create(title: title, body: "<p>#{title * 120}</p>", published_at: Time.now - i.weeks, creator: SuperUser.all.to_a.shuffle.first)
  post.add_or_create_tags tag_names.shuffle.take(1 + rand(4))
  post.save
end
