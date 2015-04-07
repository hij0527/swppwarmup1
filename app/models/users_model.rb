class UsersModel < ActiveRecord::Base
	validates :username, presence: true, length: { in: 5..20 }, uniqueness: true
	validates :password, presence: true, length: { in: 8..20 }
end
