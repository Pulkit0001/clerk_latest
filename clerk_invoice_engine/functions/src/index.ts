import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { ClerkEngine } from "./clerk_engine";
import { CandidateService } from "./service/candidate_service";
import { ChargeService } from "./service/charge_service";
import { InovieService } from "./service/invoice_service";
import serviceAccount from "./clerk-service-account.json";

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
  });
export const engine = new ClerkEngine(
    new CandidateService(admin.firestore()),
    new ChargeService(admin.firestore()),
    new InovieService(admin.firestore()),
); 
// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase!");
});

export const generateInvoiceForCandidate = functions.https.onCall(
  async (request, response) => {
    try {
        var candidateID = request.body.id;
        await engine.generateInvoice(candidateID, request.auth.uid);
        return {
          status: false,
          message: "Server Error Can't generate Invoice",
        };
    } catch (error) {
       return {
          error: error,
          status: false,
          message: "Server Error Can't generate Invoice",
        };
    }
  }
);

// export const expireSubscriptions = functions.pubsub
//   .schedule("every 1 mins")
//   .onRun(() => iapRepository.expireSubscriptions());
