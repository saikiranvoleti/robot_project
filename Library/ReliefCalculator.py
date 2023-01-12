from datetime import datetime, date
import math


def calculate_Relief(gender, dob, salary, tax):
    print(type(salary))
    print(type(tax))
    salary = float(salary)
    tax = int(tax)

    gvar: float = 0.00
    if gender == 'f':
        gvar = 500.00

    age = calculateAge(dob)
    if age <= 18:
        var = 1.00
    elif age <= 35:
        var = 0.8
    elif age <= 50:
        var = 0.5
    elif age <= 75:
        var = 0.367
    elif age <= 76:
        var = 0.05
    else:
        var = 0.00

    relief = ((salary - tax) * var) + gvar

    if relief < 50.00:
        relief = 50.00

    relief = math.floor(relief)
    relief = format(relief, ".2f")
    print(salary)
    print(tax)
    print(var)
    print(gvar)
    print(relief)
    return relief


def calculateAge(dob):
    date_str = dob
    birthDate = datetime.strptime(date_str, '%d%m%Y').date()
    today = date.today()
    age = today.year - birthDate.year - ((today.month, today.day) < (birthDate.month, birthDate.day))
    print(age)
    return age


# calculate_Relief('m', '29011975', 4833, 30)
# calculate_Relief('f', '04121954', 3648, 39)
calculate_Relief('f', '16041995', "3453", "431")
