/* eslint-disable max-len, require-jsdoc */
require("dotenv").config();
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getStorage, getDownloadURL } = require("firebase-admin/storage");

initializeApp();

const API_KEY = process.env.API_KEY;
const url = "https://places.googleapis.com/v1/places:searchNearby";

const db = getFirestore();

exports.myfunction = onDocumentCreated(
  {
    document: "cities/{cityId}",
    region: "europe-west1",
    timeoutSeconds: 540,
    memory: "512MiB",
  }, async (event) => {
    const radius = Math.sqrt(event.data.data().area / Math.PI) * 1000;
    const parameters = {
      includedTypes: ["tourist_attraction"],
      maxResultCount: 10,
      locationRestriction: {
        circle: {
          center: {
            latitude: event.data.data().latitude,
            longitude: event.data.data().longitude,
          },
          radius: radius,
        },
      },
      languageCode: "en",
    };
    const headers = {
      "Content-Type": "application/json",
      "X-Goog-Api-Key": API_KEY,
      "X-Goog-FieldMask": "places.displayName,places.id,places.location,places.photos,places.shortFormattedAddress,places.rating,places.regularOpeningHours,places.userRatingCount,places.reviews,places.restroom,places.goodForChildren,places.editorialSummary,places.types,places.businessStatus",
    };

    const response = await fetch(url, {
      method: "POST",
      headers: headers,
      body: JSON.stringify(parameters),
    });

    const data = await response.json();
    const batch = db.batch();
    await processData(data.places, event.data.data().cityId, batch);
    await batch.commit();
  });

async function processData(places, cityId, batch) {
  for await (const place of places) {
    const photoUrls = await getPhotosUrl(place.photos);

    const placeMap = {
      name: place.displayName.text,
      id: place.id,
      types: place.types,
      latitude: place.location.latitude,
      longitude: place.location.longitude,
      address: place.shortFormattedAddress,
      ratingCount: place.userRatingCount,
      photos: photoUrls,
      cityId: cityId,
    };

    if (place.reviews) {
      placeMap.reviews = place.reviews;
    } else {
      placeMap.reviews = [];
    }
    if (place.editorialSummary) {
      placeMap.description = place.editorialSummary.text;
    }
    if (place.businessStatus) {
      placeMap.businessStatus = place.businessStatus;
    }
    if (place.rating) {
      placeMap.rating = place.rating;
    }
    if (place.goodForChildren) {
      placeMap.goodForChildren = place.goodForChildren;
    }
    if (place.regularOpeningHours) {
      placeMap.openingHours = place.regularOpeningHours.weekdayDescriptions;
    }
    if (place.restroom) {
      placeMap.restroom = place.restroom;
    }

    const placeRef = db.collection("places").doc(placeMap.id);
    batch.set(placeRef, placeMap);
  }
}

async function getPhotosUrl(photos) {
  console.log("getPhotourls");
  let filteredUrls = [];
  try {
    const urls = await photos.map(async (photo) => {
      const getPhotoUrl = `https://places.googleapis.com/v1/${photo.name}/media?maxHeightPx=${photo.heightPx}&maxWidthPx=${photo.widthPx}&key=${API_KEY}`;

      const headers = {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": API_KEY,
      };

      const response = await fetch(getPhotoUrl, {
        method: "GET",
        headers: headers,
      });

      const file = await response.arrayBuffer();
      const uint8file = new Uint8Array(file);

      if (file.byteLength < 1024) {
        return;
      }

      const fileRef = getStorage().bucket().file(`${photo.name}.jpg`);
      await fileRef.save(uint8file, { resumable: false, metadata: { contentType: "image/jpg" } });

      const photoUrl = await getDownloadURL(fileRef);
      return photoUrl;
    });

    const urlsData = await Promise.all(urls);
    filteredUrls = urlsData.filter(Boolean);
  } catch (error) {
    console.log("PHOTO ERROR", error);
  }
  return filteredUrls;
}
