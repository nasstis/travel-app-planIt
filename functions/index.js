
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");

initializeApp();

exports.myfunction = onDocumentCreated("cities/{cityId}", (event) => {
    console.log("Document data:", event.data.data().cityId);
});
