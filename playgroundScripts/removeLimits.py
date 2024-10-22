import os
import re

def remove_limit_from_file(file_path):
    # Read the file content
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Regular expression to match "LIMIT" statements at the end of the file
    limit_regex = re.compile(r'^[\s]*LIMIT[\s]*[-0-9,]*[\s]*;[\s]*$', re.IGNORECASE)

    # Remove any line that matches the "LIMIT" statement
    with open(file_path, 'w') as file:
        for line in lines:
            if not limit_regex.match(line.strip()):
                file.write(line)

def process_sql_files(directory):
    # Check if the directory exists
    if not os.path.isdir(directory):
        print(f"Directory does not exist: {directory}")
        return

    # Process each .sql file in the directory
    for filename in os.listdir(directory):
        if filename.endswith(".sql"):
            file_path = os.path.join(directory, filename)
            remove_limit_from_file(file_path)
            print(f"Processed: {file_path}")

if __name__ == "__main__":
    # Specify the directory containing the .sql files
    directory = input("Enter the directory containing .sql files: ")
    process_sql_files(directory)
