#!/usr/bin/env python3

import sys
import random
import string

def generate_random_filename(length=8):
    """
    Generates a random string of given length using lowercase letters and digits.
    """
    chars = string.ascii_lowercase + string.digits
    return ''.join(random.choices(chars, k=length))

def main():
    if len(sys.argv) < 3:
        print("Usage: python generate_random_files.py <number_of_files> <extensions_comma_separated> [names_comma_separated]")
        print("Example without names: python generate_random_files.py 5 txt,png,jpg")
        print("Example with names:    python generate_random_files.py 3 txt jpg files_01,files_02,files_03")
        sys.exit(1)

    # Number of files to generate
    num_files = int(sys.argv[1])
    # List of possible extensions
    extensions = sys.argv[2].split(",")

    # Optional list of names (must match the number of files if provided)
    if len(sys.argv) > 3:
        names = sys.argv[3].split(",")
        if len(names) != num_files:
            print("Error: The number of provided names must match the number of files to generate.")
            sys.exit(1)
    else:
        names = None

    for i in range(num_files):
        # Pick a random extension from the list
        extension = random.choice(extensions)

        # Determine the base filename
        if names:
            base_filename = names[i]
        else:
            base_filename = generate_random_filename()

        filename = f"{base_filename}.{extension}"

        # Generate random file content (optional behavior).
        # Here, we write a random number of bytes between 1KB and 10KB.
        file_size = random.randint(1024, 10 * 1024)  # 1 KB to 10 KB
        random_data = bytes(random.getrandbits(8) for _ in range(file_size))

        # Create and write to the file
        with open(filename, "wb") as f:
            f.write(random_data)

        print(f"Created file: {filename}")

if __name__ == "__main__":
    main()
