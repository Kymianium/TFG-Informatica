from datetime import timedelta, datetime
from typing import Callable
import time

from entities import (
    Challenge,
    ChallengeSolved,
    Medal,
    Student,
    medal_collection,
    challenge_collection,
    student_collection,
    current_day,
)
from server import send_message


def solveChallenge(name, competence, time, attempts, hints):
    def condition(action):
        if not isinstance(action, ChallengeSolved):
            return False
        if name != "Cualquiera" and action.name != name:
            return False
        if competence != "Cualquiera" and action.competence != competence:
            return False
        if (
            time != "Cualquiera" and action.time != time
        ):  # NOTE: If it must be solved using few time, this must be one!
            return False
        if attempts != "Cualquiera" and action.attempts != attempts:
            return False
        if hints != "Cualquiera" and action.hints != hints:
            return False
        return True

    return condition


def stats(points, competence):
    def condition(action):
        if not isinstance(action, str):
            return False
        data = action.split("/")
        if data[0] != "score":
            return False
        if competence != "Cualquiera" and data[1] != competence:
            return False
        if data[2] < points:
            return False
        return True

    return condition


def platform(which):
    def condition(action):
        if not isinstance(action, str):
            return False
        data = action.split("/")
        if data[0] != "front":
            return False
        if data[1] != which:
            return False
        return True

    return condition


def medal(name):
    def condition(action):
        if not isinstance(action, str):
            return False
        data = action.split("/")
        if data[0] != "medal":
            return False
        if data[1] != name:
            print(f"Nombre incorrecto, esperada {name} y recibida {data[1]}")
            return False
        return True

    return condition


def checkUnique(student: Student, condition) -> bool:
    for day in student.history.keys():
        for action in student.history[day]:
            if condition(action):
                return True
    return False


def checkPeriodically(student: Student, condition, amount, period) -> bool:
    if period == "daily":
        daychecked = current_day.get()
        for _ in range(0, amount):
            if daychecked not in student.history.keys():
                return False
            met = False
            for action in student.history[daychecked]:
                if condition(action):
                    met = True
                    break
            if not met:
                return False
            daychecked -= timedelta(days=1)
        return True
    elif period == "weekly":
        daychecked = current_day.get()
        while True:
            # If the day is not in the history and it's monday, return False
            # If the day is not in the history and it's not monday, go back
            # to the previous day and check
            while daychecked not in student.history.keys():
                if daychecked.weekday() == 0:
                    return False
                daychecked -= timedelta(days=1)

            for action in student.history[daychecked]:
                if condition(action):
                    if amount == 1:
                        return True
                    daychecked -= timedelta(days=daychecked.weekday() + 1)
                    amount -= 1
                    break

            # If it's monday and the condition is not met yet, return False
            if daychecked.weekday() == 0:
                return False
            daychecked -= timedelta(days=1)
    elif period == "monthly":
        daychecked = current_day.get()
        while True:
            # If the day is not in the history and it's the first day of the month, return False
            # If the day is not in the history and it's not the first day of the month, go back
            # to the previous day and check
            while daychecked not in student.history.keys():
                if daychecked.day == 1:
                    return False
                daychecked -= timedelta(days=1)

            for action in student.history[daychecked]:
                if condition(action):
                    if amount == 1:
                        return True
                    daychecked -= timedelta(days=daychecked.day)
                    amount -= 1
                    break

            if daychecked.day == 1:
                return False
            daychecked -= timedelta(days=1)
    else:
        return False


def checkSpecificDate(student: Student, condition, date) -> bool:
    if date.date() not in student.history.keys():
        return False
    for action in student.history[date.date()]:
        if condition(action):
            return True
    return False


def checkMedal(student: Student, med: Medal):
    for i in range(len(med.when)):
        condition: Callable
        how_data = med.how[i].split("/")
        if how_data[0] == "ch":
            hints = "Cualquiera"
            attempts = "Cualquiera"
            time = "Cualquiera"
            if how_data[3] == "Pocas pistas":
                hints = 1
            elif how_data[3] == "Pocos intentos":
                attempts = 1
            elif how_data[3] == "Poco tiempo":
                time = 1
            condition = solveChallenge(how_data[1], how_data[2], time, attempts, hints)
        elif how_data[0] == "st":
            condition = stats(how_data[1], how_data[2])
        elif how_data[0] == "front":
            condition = platform(how_data[1])
        elif how_data[0] == "md":
            condition = medal(how_data[1])
        else:
            return False

        if med.when[i] == "":
            if not checkUnique(student, condition):
                return False
        else:
            period = med.when[i].split("/")
            if len(period) == 2:
                if period[1] == "días":
                    if not checkPeriodically(
                        student, condition, int(period[0]), "daily"
                    ):
                        return False
                elif period[1] == "semanas":
                    if not checkPeriodically(
                        student, condition, int(period[0]), "weekly"
                    ):
                        return False
                elif period[1] == "meses":
                    if not checkPeriodically(
                        student, condition, int(period[0]), "monthly"
                    ):
                        return False
            else:
                year = int(med.when[i].split("-")[0])
                month = int(med.when[i].split("-")[1])
                day = int(med.when[i].split("-")[2].split(" ")[0])
                if not checkSpecificDate(
                    student, condition, datetime(year, month, day)
                ):
                    return False
    return True


async def refresh():
    for medal in medal_collection:
        for student in student_collection:
            if medal.name in student.medals:
                continue
            if checkMedal(student, medal):
                medal.winners.append(student.name)
                student.earn_medal(medal)
                await send_message(f"md/{student.name}/{medal.name}")
                time.sleep(0.1)
                # Por si gana una medalla que te hace ganar otra medalla
                for medalla in medal_collection:
                    if medalla.name in student.medals:
                        continue
                    if checkMedal(student, medalla):
                        medalla.winners.append(student.name)
                        student.earn_medal(medalla)
                        await send_message(f"md/{student.name}/{medalla.name}")
                        time.sleep(0.1)


async def new_challenge():
    challenge = Challenge()
    challenge_collection.append(challenge)
    await send_message(f"ch/{challenge.name}/{challenge.competence}")


def new_student():
    student = Student()
    student_collection.append(student)
