# By using symbol ':user', we get the factory girl to simulate the User model.
Factory.define :user do |user|
	user.name	"Don Garry"
	user.email	"dongarry@example.com"
	user.password "password"
	user.password_confirmation "password"
end