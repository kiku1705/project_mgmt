class Role < ActiveRecord::Base
	has_many :users
	self.primary_key = :name
end
