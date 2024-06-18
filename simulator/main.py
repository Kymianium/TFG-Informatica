from server import send_message, server
from entities import Challenge, Student, challenge_collection, student_collection
from running import run
from aioconsole import ainput
import asyncio
import time


async def process_input():
    while True:
        print("Selecciona una opción")
        print("\t[1] Añadir retos")
        print("\t[2] Añadir estudiantes")
        print("\t[3] Comenzar simulación")
        print("\t[4] Salir")
        choice = await ainput("Opción: ")
        if choice == "1":
            n = await ainput("Ingresa el número de retos: ")
            for _ in range(int(n)):
                reto = Challenge()
                challenge_collection.append(reto)
                await send_message(f"reto/{reto.name}/{reto.competence}")
                time.sleep(0.07)
            print("\n\nRetos añadidos\n\n")
        elif choice == "2":
            n = await ainput("Ingresa el número de estudiantes: ")
            for _ in range(int(n)):
                student_collection.append(Student())
            print("\n\nEstudiantes añadidos\n\n")
        elif choice == "3":
            days = await ainput("Ingresa el número de días: ")
            await run(int(days))
        elif choice == "4":
            quit()


async def main():
    task1 = asyncio.create_task(server())
    task2 = asyncio.create_task(process_input())
    await asyncio.gather(task1, task2)


asyncio.run(main())
