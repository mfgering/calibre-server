from calibre.srv.users import *
import sys
username = sys.argv[1]
password = sys.argv[2]
m = UserManager()
if m.has_user(username):
	m.change_password(username, password)
else:
	m.add_user(username, password, readonly=False)
