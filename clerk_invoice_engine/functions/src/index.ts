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
  new InovieService(admin.firestore())
);

export const generateInvoiceForCandidate = functions.https.onCall(
  async (req, resp) => {
    try {
      // if (!context.auth) return {status: 'error', code: 401, message: 'Not signed in'}
      console.log("In Try block");
      console.log(req);
      console.log("Request Object Print .........................................");
      var candidateID = req.candidate_id;
      var res = await engine.generateInvoice(candidateID, req.user_id);
      return {
        status: true,
        data: res,
        message: "Invoice Generated succesfully",
      };
    } catch (error) {
      console.log("In catch block");
      return {
        error: error,
        status: false,
        message: "Server Error Can't generate Invoice",
      };
    }
  }
);
