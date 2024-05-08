# Define the lists
List_of_Number_A = [1, 2, 3, 5, 6, 8, 9]
List_of_Number_B = [3, 2, 1, 5, 6, 0]

def find_duplicates(list1, list2):
    try:
        # Convert lists to sets to remove duplicates
        set1 = set(list1)
        set2 = set(list2)
        
        # Find common elements using set intersection
        duplicates = list(set1.intersection(set2))
        
        return duplicates
    except TypeError:
        # Handle error if input is not iterable
        print("Error: Input lists must be iterable.")
        return []

def write_to_log(filename, list_a, list_b, duplicates):
    try:
        with open(filename, 'w') as f:
            f.write("Test Automation Assignment #1\n")
            f.write("List of Number A: " + str(list_a) + "\n")
            f.write("List of Number B: " + str(list_b) + "\n")
            f.write("Number of numbers which are duplicates: " + str(len(duplicates)) + "\n")
            f.write("Duplicate items: " + str(duplicates) + "\n")
        print("Log file written successfully.")
    except Exception as e:
        print("Error:", str(e))


# Find duplicates
duplicates = find_duplicates(List_of_Number_A, List_of_Number_B)

# Write to log file
write_to_log("Log_Answer_Automate_Test_Assignment_01.txt", List_of_Number_A, List_of_Number_B, duplicates)