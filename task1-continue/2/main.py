def convert_to_base_10(number_str, p):
    # folosim alfabetul pentru a sti valoarea literelor (A=10, B=11 etc.)
    digits = "0123456789ABCDEF"
    decimal_result = 0

    # parcurgem numarul de la stanga la dreapta
    for char in number_str:
        char = char.upper()
        # gasim ce valoare are cifra in baza 10
        value = digits.index(char)
        # inmultim ce avem deja cu baza p si adunam cifra noua
        decimal_result = decimal_result * p + value

    return decimal_result


def convert_from_base_10(n, q):
    # daca numarul este 0, rezultatul e direct "0"
    if n == 0: return "0"

    digits = "0123456789ABCDEF"
    result = ""

    # cat timp mai avem ceva de impartit
    while n > 0:
        # calculam restul impartirii la noua baza q
        remainder = n % q
        # punem cifra corespunzatoare in fata rezultatului
        result = digits[remainder] + result
        # facem impartirea intreaga ca sa mergem mai departe
        n = n // q

    return result


# aici incepe executia programului
try:
    # pasul 1: citim bazele si numarul de la tastatura
    base_p = int(input("Introdu baza initiala (p): "))
    base_q = int(input("Introdu baza in care vrei sa transformi (q): "))
    number_p = input(f"Introdu numarul in baza {base_p}: ")

    # pasul 2: transformam numarul din baza p in baza 10
    # este mai usor sa trecem prin baza 10 decat sa calculam direct
    intermediate_10 = convert_to_base_10(number_p, base_p)

    # pasul 3: transformam din baza 10 in baza finala q
    final_result = convert_from_base_10(intermediate_10, base_q)

    # afisam rezultatul final
    print(f"Numarul {number_p} transformat din baza {base_p} in baza {base_q} este: {final_result}")

# daca datele introduse nu sunt corecte (ex: cifra mai mare decat baza)
except ValueError:
    print("Eroare: Ai introdus cifre sau baze invalide.")
