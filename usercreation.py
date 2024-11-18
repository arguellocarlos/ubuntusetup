import os
import subprocess

def add_new_user():
    username = input("Enter the name of the new user: ")
    subprocess.run(["sudo", "adduser", username])
    subprocess.run(["sudo", "usermod", "-aG", "sudo", username])
    home_dir = f"/home/{username}"
    directories = ["Documents", "Pictures", "Videos", "Downloads", "Music", "Desktop"]
    for directory in directories:
        os.makedirs(os.path.join(home_dir, directory))
    print(f"User {username} added with sudo permissions and home directories created.")
