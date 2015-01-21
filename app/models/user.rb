class User < ActiveRecord::Base
	has_many :answers
	include ActiveModel::SecurePassword
	    has_secure_password

end
