def string_to_hex(input_string):
    # Calculate the length of the input string
    string_length = len(input_string)

    # Convert the length to hexadecimal
    hex_length = hex(string_length)[2:].zfill(2).upper()

    return hex_length

# Input strings
title_string = "nicky dos dev"
author_string = "by nicky blackburn"

# Convert strings to hexadecimal
title_hex = string_to_hex(title_string)
author_hex = string_to_hex(author_string)

# Output the hexadecimal values
print("Title length:", title_hex)
print("Author length:", author_hex)
