
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

def simpleCipher(encrypted, k):
    decrypted = ""
    print("Alphabet:", alphabet) 

    for char in encrypted:
        newindex = alphabet.index(char)
        new_index = (newindex - k) % 26
        decrypted += alphabet[new_index]

    return decrypted


encrypted = 'TPWPIXQITEWW'
k = 4
decrypted = simpleCipher(encrypted, k)
print("Decrypted string:", decrypted)  


with open('Log_Answer_Automate_Test_Assignment_06.txt', 'w') as f:
    f.write("Test Automation Assignment #6\n")
    f.write("Alphabet from proposition: " + alphabet + "\n")
    f.write("Value of k (The position number to counterclockwise.): " + str(k) + "\n")
    f.write("Answer after turning the clockwise " + str(k) + " times.\n")
    f.write("Decrypted string: " + decrypted + "\n")
    
