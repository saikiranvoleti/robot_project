from datetime import datetime, date


def calculate_Relief(gender, dob, sal, tax):
    relief = 00.00
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

    gvar = {"m": 0.00,
            "f": 500.00}

    relief = ((sal - tax) * var) + gvar[gender]
    if relief < 50.00:
        relief = 50.00
    print(format(relief, ".2f"))
    return format(relief, ".2f")


def calculateAge(dob):
    date_str = dob
    birthDate = datetime.strptime(date_str, '%d%m%Y').date()
    today = date.today()
    age = today.year - birthDate.year - ((today.month, today.day) < (birthDate.month, birthDate.day))
    return age


calculate_Relief('f', '08072005', 15000, 10000)
