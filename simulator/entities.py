from enum import Enum
import names
import time
import random
from datetime import datetime, timedelta


class currentDay:
    today = datetime.today()

    def get(self):
        return self.today.date()

    def advance(self):
        self.today = self.today + timedelta(days=1)


current_day = currentDay()


class Time(int, Enum):
    SHORT = 1
    MEDIUM = 2
    LONG = 3


class Hint(int, Enum):
    FEW = 1
    MEDIUM = 2
    MANY = 3


class Attempt(int, Enum):
    FEW = 1
    MEDIUM = 2
    MANY = 3


competences = [
    "Blockchain",
    "Crypto",
    "Forensics",
    "Gamepwn",
    "Hardware",
    "Web",
]


class Platform(Enum):
    PROFILE = 0
    SESSION = 1
    MEDALS = 2
    STATS = 3
    FOREING = 4


class Medal:
    def __init__(self, name, color, description, when, how):
        self.name = name
        self.color = color
        self.description = description
        self.when = when
        self.how = how
        self.winners = []

    def __str__(self):
        return f"{self.name} ({self.color})"


medal_collection = []


class Challenge:
    def __init__(self):
        self.name = names.get_last_name()
        self.competence = random.choice(competences)


class ChallengeSolved:
    def __init__(self, name, competence, time, attempts, hints):
        self.name = name
        self.competence = competence
        self.time = time
        self.attempts = attempts
        self.hints = hints

    @classmethod
    def solve(cls, challenge):
        return ChallengeSolved(
            challenge.name,
            challenge.competence,
            random.randint(1, 3),
            random.randint(1, 3),
            random.randint(1, 3),
        )


challenge_collection = []


class Student:
    def __init__(self):
        self.name = names.get_full_name()
        self.scores = {competence: 0 for competence in competences}
        self.medals = []
        self.challenges = []
        self.history = {}  # This diciontary has the day as a key and a list of actions

    def solve_challenge(self):
        if not challenge_collection:
            return
        challenge = random.choice(challenge_collection)
        solved = ChallengeSolved.solve(challenge)
        self.challenges.append(solved)
        self.scores[challenge.competence] += random.randint(5, 40)
        self.history[current_day.get()].append(solved)
        self.history[current_day.get()].append(
            f"score/{challenge.competence}/{self.scores[challenge.competence]}"
        )
        print(
            f"{self.name} ha resuelto {challenge.name}, de la competencia"
            f" {challenge.competence}. Su nueva puntuación en "
            f"{challenge.competence} es {self.scores[challenge.competence]}"
        )

    def log_in(self):
        self.history[current_day.get()] = ["front/1"]
        print(f"{self.name} ha iniciado sesión")

    def front(self):
        for _ in random.sample([0, 2, 3, 4], random.randint(1, 4)):
            time.sleep(0.3)
            if _ == 0:
                print(f"{self.name} ha visitado su perfil")
            elif _ == 2:
                print(f"{self.name} ha visitado las medallas")
            elif _ == 3:
                print(f"{self.name} ha visitado las estadísticas")
            elif _ == 4:
                print(f"{self.name} ha visitado las estadísticas de alguien")
            self.history[current_day.get()].append(f"front/{_}")

    def earn_medal(self, medal):
        self.medals.append(medal.name)
        self.history[current_day.get()].append(f"medal/{medal.name}")
        print(f"{self.name} ha ganado la medalla {medal.name}")


student_collection = []
