# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
	user.name	"Tomas Lukosius"
	user.email	"tomas@ebox.lt"
	user.password	"foobar"
	user.password_confirmation	"foobar"
end
