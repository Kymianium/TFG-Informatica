import json
import asyncio
import websockets
from entities import Medal, medal_collection

mysocket = None


async def handler(websocket, path):
    print(f"Client connected from {path}")
    global mysocket
    mysocket = websocket
    try:
        async for message in websocket:
            medal_data = json.loads(message)
            print(medal_data)
            newMedal = Medal(
                medal_data["name"],
                medal_data["color"],
                medal_data["description"],
                medal_data["when"],
                medal_data["how"],
            )
            print(f"Received medal: {str(newMedal)}")
            medal_collection.append(newMedal)
    except websockets.ConnectionClosed:
        print("Client disconnected")


async def send_message(message: str):
    global mysocket
    if mysocket:
        await mysocket.send(message)


async def server():
    async with websockets.serve(handler, "localhost", 1729):
        print("Server started on ws://localhost:1729")
        await asyncio.Future()  # Run forever
