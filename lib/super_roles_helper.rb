require 'devise/controllers/helpers'

module SuperRolesHelper
	
	MAPPINGS = {
		commenter: {
			roles: %w{super_user user},
			each: false
		},
 		creator: {
 			roles: %w{admin super_user},
 			each: false
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

 		if each
 			define_method "#{super_role}_signed_in?" do
 				roles.all? { |role| signed_in? role }
 			end
	
 			define_method "current_#{super_role}" do |first=nil|
 				roles.map!(&:to_sym).unshift roles.delete(first.to_sym) if first
 				roles.inject([]) do |users, role|
 					users.push eval("current_#{role}")
 				end
 				users.all? ? users : nil
 			end

 		else
 			define_method "#{super_role}_signed_in?" do
 				signed_in? roles
 			end
	
 			define_method "current_#{super_role}" do |first=nil|
 				roles.map!(&:to_sym).unshift roles.delete(first.to_sym) if first
 				roles.inject(nil) do |found, role|
 					found || eval("current_#{role}")
 				end
 			end
 		end
 	end

end