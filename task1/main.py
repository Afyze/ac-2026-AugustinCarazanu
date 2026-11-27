def convert_from_decimal(n, target_base):
    # verificam daca numarul e zero. daca da, raspunsul e simplu 0
    if n == 0: return "0"

    # aici avem alfabetul la numere
    # trebuie literele a-f pentru baza 16 (hex)
    digits = "0123456789ABCDEF"

    # aici vom construi raspunsul final, incepem cu un text gol
    result = ""

    # bucla care merge cat timp mai avem numar de impartit
    while n > 0:
        # pasul 1: aflam restul impartirii (modulo %)
        # pentru binar (baza 2), restul e 0 sau 1
        # pentru hex (baza 16), restul e intre 0 si 15
        remainder = n % target_base

        # pasul 2: luam caracterul potrivit pentru restul gasit
        # daca restul e 10, luam 'A' din lista digits
        # il punem in fata rezultatului (pentru ca se construieste invers)
        result = digits[remainder] + result

        # pasul 3: impartim numarul la baza ca sa trecem la urmatoarea cifra
        # // inseamna impartire intreaga -,
        n = n // target_base

    # trimitem rezultatul final inapoi
    return result


# program run aici
try:
    # cerem utilizatorului un numar si il transformam in intreg
    num = int(input("Enter a natural number: "))

    # folosim aceeasi functie, schimband doar baza
    # aici trimitem '2' pentru a primi rezultatul in binar
    print(f"Binary: {convert_from_decimal(num, 2)}")

    # aici trimitem '8' pentru octal
    print(f"Octal:  {convert_from_decimal(num, 8)}")

    # aici trimitem '16' pentru hexadecimal
    print(f"Hex:    {convert_from_decimal(num, 16)}")

# daca utilizatorul scrie litere in loc de cifre, prindem eroarea aici
except ValueError:
    print("Invalid input.")