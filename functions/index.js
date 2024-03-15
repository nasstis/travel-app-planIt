require("dotenv").config();
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");

initializeApp();

API_KEY = process.env.API_KEY
url = "https://places.googleapis.com/v1/places:searchNearby"

exports.myfunction = onDocumentCreated("cities/{cityId}", async (event) => {
    const radius = (Math.sqrt(event.data.data().area / Math.PI)) * 1000;
    const parameters = {
        includedTypes: ["tourist_attraction"],
        maxResultCount: 10,
        locationRestriction: {
            circle: {
                center: {
                    latitude: event.data.data().latitude,
                    longitude: event.data.data().longitude
                },
                radius: radius
            }
        },
        languageCode: "en"
    };

    const headers = {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": API_KEY,
        "X-Goog-FieldMask": "places.displayName"
    };

    const response = await fetch(url, {
        method: 'POST',
        headers: headers,
        body: JSON.stringify(parameters)
    });

    const data = await response.json()

    console.log(JSON.stringify(data));
});
