#require 'devise/controllers/helpers'

module SuperRolesHelper
	
	MAPPINGS = {
		commenter: {
			roles: %w{super_user user}
		},
 		creator: {
 			roles: %w{admin super_user}
 		}
 	}

 	MAPPINGS.each do |super_role, options|

 		if options.is_a? Hash
 			roles = options[:roles]
 			each = options[:each]
 		else
 			roles = *options
 			each = false
 		end

 		
 		define_method "#{super_role}_signed_in?" do
 			signed_in? roles
 		end
	
 		define_method "current_#{super_role}" do |first=nil|
 			roles.map!(&:to_sym).unshift roles.delete(first.to_sym) if first
 			roles.inject(nil) do |found, role|
 				found || eval("current_#{role}")
 			end
 		end

 		define_method "current_#{super_role.to_s.pluralize}" do |first=nil|
 			roles.map!(&:to_sym).unshift roles.delete(first.to_sym) if first
 			roles.inject([]) do |users, role|
 				users.push eval("current_#{role}")
 			end.compact
 		end

 		define_method "authenticate_#{super_role}!" do |redirect_role=nil|
 			eval "authenticate_#{redirect_role}" unless eval "#{super_role}_signed_in?"
 		end

 		define_method "authenticate_#{super_role.to_s.pluralize}!" do |redirect_role=nil|
			#TODO?			
 		end

 	end

end