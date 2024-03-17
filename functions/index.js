require("dotenv").config();
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getStorage, getDownloadURL } = require("firebase-admin/storage");

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
        "X-Goog-FieldMask": "places.displayName,places.id,places.location,places.photos,places.shortFormattedAddress,places.rating,places.regularOpeningHours,places.userRatingCount,places.reviews,places.restroom,places.goodForChildren,places.editorialSummary,places.types,places.businessStatus"
    };

    const response = await fetch(url, {
        method: 'POST',
        headers: headers,
        body: JSON.stringify(parameters)
    });

    const data = await response.json();

    processData(data.places);
});

async function processData(places) {
    for (const place of places) {
        const photoUrls = await getPhotosUrl(place.photos);

        const placeMap = {
            "name": place.displayName.text,
            "id": place.id,
            "types": place.types,
            "latitude": place.location.latitude,
            "longitude": place.location.longitude,
            "rating": place.rating,
            "businessStatus": place.businessStatus,
            "address": place.shortFormattedAddress,
            "description": place.editorialSummary.text,
            "reviews": place.reviews,
            "photos": photoUrls,
        };

        if (place.goodForChildren !== undefined) {
            placeMap.goodForChildren = place.goodForChildren;
        }
        if (place.regularOpeningHours !== undefined) {
            placeMap.regularOpeningHours = place.regularOpeningHours.weekdayDescriptions;
        }
        if (place.restroom !== undefined) {
            placeMap.restroom = place.restroom;
        }

        await getFirestore().collection("places").doc(placeMap.id).set(placeMap);
    }
}

async function getPhotosUrl(photos) {
    const urls = [];
    for (const photo of photos) {
        try {
            const get_photo_url = `https://places.googleapis.com/v1/${photo.name}/media?maxHeightPx=${photo.heightPx}&maxWidthPx=${photo.widthPx}&key=${API_KEY}`;

            const headers = {
                "Content-Type": "application/json",
                "X-Goog-Api-Key": API_KEY,
            };

            const response = await fetch(get_photo_url, {
                method: 'GET',
                headers: headers,
            });

            const file = await response.arrayBuffer();
            var uint8file = new Uint8Array(file);

            const fileRef = getStorage().bucket().file(`${photo.name}.jpg`);
            await fileRef.save(uint8file, { resumable: false, metadata: { contentType: "image/jpg" } });

            const photoUrl = await getDownloadURL(fileRef);
            urls.push(photoUrl);
        } catch (error) {
            console.log("PHOTO ERROR", error);
        }
    }
    return urls;
}