module HomeHelper
	def resourse_name
		:user
	end
	
	def resource
		@resource ||= User.new
	end
	
	def devise_mapping
		@devise_mapping ||= Devise.mapping[:user]
	end
end
