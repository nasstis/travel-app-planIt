from firebase_functions.firestore_fn import (
    on_document_created,
    Event,
    DocumentSnapshot,
)
from firebase_admin import initialize_app, firestore
import google.cloud.firestore
import math
import googlemaps

initialize_app()

API_KEY = open("API_KEY.txt", "r").read()


@on_document_created(document="cities/{cityId}")
def createPlaces(event: Event[DocumentSnapshot]) -> None:
    radius = (math.sqrt(event.data.get("area") / math.pi)) * 1000
