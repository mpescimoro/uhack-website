class AddFulltextIndexesToPost < ActiveRecord::Migration
  def change
  	execute %Q{create index on posts using gin(to_tsvector('english', title));
  		create index on posts using gin(to_tsvector('english', body));}
  end
end
