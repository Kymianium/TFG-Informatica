import random
import time
from datetime import datetime, timedelta

from aioconsole import ainput

from entities import student_collection, challenge_collection, current_day
from logic import refresh


async def new_day():
    current_day.advance()
    print(f"\n\nNuevo día {current_day.get().strftime('%d/%m/%Y')}\n\n")
    await ainput("Presiona enter para continuar\n\n")


async def simulate_student_day():
    for student in student_collection:
        time.sleep(0.3)
        if random.randint(1, 100) > 5:
            student.log_in()
            if random.randint(1, 100) > 50 and challenge_collection:
                time.sleep(0.3)
                student.solve_challenge()
            if random.randint(1, 100) > 10:
                time.sleep(0.3)
                student.front()


async def run(days):
    for _ in range(days):
        await new_day()
        await simulate_student_day()
        await refresh()
