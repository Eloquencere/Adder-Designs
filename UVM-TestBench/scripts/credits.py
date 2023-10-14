import sys
import pyfiglet
import time


def display_countdown(text, seconds):
    print(f"{text} in {seconds} seconds", end="", flush=True)
    for i in range(seconds, 0, -1):
        sys.stdout.write("\r")
        sys.stdout.write("\033[K")
        print(f"{text} in {i} seconds", end="", flush=True)
        time.sleep(1)
    sys.stdout.write("\r")
    sys.stdout.write("\033[K")
    print(f"{text} in 0 seconds")


print(pyfiglet.figlet_format("Bit Bots", font="georgia11", width=700))

print(
    "Made with 💙 by Sriranga(github.com/Eloquencere/) & Siddhaanth(github.com/spacebiz24/)"
)
print("\n")
display_countdown("Initialising Verification Environment", 7)
