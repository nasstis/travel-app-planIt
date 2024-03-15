import json
from firebase_functions.firestore_fn import (
    on_document_created,
    Event,
    DocumentSnapshot,
)
from firebase_admin import initialize_app
import math
from decouple import config
import requests

initialize_app()

API_KEY = config("API_KEY")
url = "https://places.googleapis.com/v1/places:searchNearby"


@on_document_created(document="cities/{cityId}")
def createPlaces(event: Event[DocumentSnapshot]) -> None:
    radius = (math.sqrt(event.data.get("area") / math.pi)) * 1000

    parameters = {
        "includedTypes": ["tourist_attraction"],
        "maxResultCount": 10,
        "locationRestriction": {
            "circle": {
                "center": {
                    "latitude": event.data.get("latitude"),
                    "longitude": event.data.get("longitude"),
                },
                "radius": radius,
            }
        },
        "languageCode": "en",
    }

    headers = {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": API_KEY,
        "X-Goog-FieldMask": "places.displayName",
    }

    post_response = requests.post(url, json=parameters, headers=headers)

    print(post_response.content)
