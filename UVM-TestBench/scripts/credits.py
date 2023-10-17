from sys import stdout
from time import sleep
from pyfiglet import figlet_format


def display_countdown(text, seconds):
    print(f"{text} in {seconds} seconds", end="", flush=True)
    for i in range(seconds, -1, -1):
        stdout.write("\r")
        stdout.write("\033[K")
        print(f"{text} in {i} seconds", end="", flush=True)
        sleep(1)


print(figlet_format("Bit Bots", font="georgia11", width=700))

print(
    "Made with 💙 by Sriranga(github.com/Eloquencere/) & Siddhaanth(github.com/spacebiz24/)"
, end = "\n\n")

display_countdown("Initialising Verification Environment", 10)
