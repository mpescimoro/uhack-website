module DeviseGroupAliases
	include Devise::Controllers::Helpers
	
	@@MAPPINGS = {
		commenter: %w{super_user user}, 
 		creator: %w{admin super_user}
 	}

 	@@MAPPINGS.each do |alias, roles|

 		define_method "#{alias}_signed_in?" do
 			roles.inject(false) do |signed, role|
 				eval "#{role}_signed_in?"
 			end
 		end

 	end


end