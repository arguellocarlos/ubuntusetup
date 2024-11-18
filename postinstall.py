import os
import platform
import shutil
import psutil
import time
import subprocess
from usercreation import add_new_user
from packageinstall import install_packages

def check_ubuntu_version():
    version = platform.linux_distribution()[1]
    print(f"Ubuntu Version: {version}")

def check_disk_space():
    total, used, free = shutil.disk_usage("/")
    print(f"Disk Space Available: {free // (2**30)} GB")

def check_uptime():
    uptime_seconds = time.time() - psutil.boot_time()
    uptime_string = time.strftime("%H:%M:%S", time.gmtime(uptime_seconds))
    print(f"Uptime: {uptime_string}")

def check_free_memory():
    memory = psutil.virtual_memory()
    print(f"Free Memory (RAM): {memory.available // (2**20)} MB")

def check_cpu_load():
    load = os.getloadavg()
    print(f"CPU Load: {load}")

def print_ascii_art():
    art = """
    _    _ _    _ _    _ _    _ _    _ 
   | |  | | |  | | |  | | |  | | |  | |
   | |  | | |  | | |  | | |  | | |  | |
   | |  | | |  | | |  | | |  | | |  | |
   | |__| | |__| | |__| | |__| | |__| |
    \____/ \____/ \____/ \____/ \____/ 
    """
    print(art)

def menu():
    print("Menu:")
    print("1. Create User")
    print("2. Install default Packages")
    print("3. Option 3")
    print("4. Option 4")
    print("5. Option 5")
    choice = input("Enter your choice (1-5): ")
    if choice == "1":
        print("Submenu A:")
        print("A. Add a new user with sudo permissions")
        submenu_choice = input("Enter your choice (A): ")
        if submenu_choice.upper() == "A":
            add_new_user()
        else:
            print("Invalid choice.")
    elif choice == "2":
        install_packages()
    else:
        print("Invalid choice.")

if __name__ == "__main__":
    print_ascii_art()
    menu()
    check_ubuntu_version()
    check_disk_space()
    check_uptime()
    check_free_memory()
    check_cpu_load()
