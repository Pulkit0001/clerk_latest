import * as admin from "firebase-admin";

import {ClerkEngine} from "./clerk_engine";
import {CandidateService} from "./service/candidate_service";

import serviceAccount from "./clerk-service-account.json";

import {ChargeService} from "./service/charge_service";
import {InovieService} from "./service/invoice_service";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

var service = new CandidateService(admin.firestore());
var chargeService = new ChargeService(admin.firestore());
const invoiceService = new InovieService(admin.firestore());
const engine = new ClerkEngine(service, chargeService, invoiceService);
engine
  .generateInvoice("XgCyMTaP1S97hfAj2RTP", "efwvzJt2LRWI6dpcYuqex5wt3ZX2")
  .then((res) => console.log(res))
  .catch((err) => console.log(err));

// service
//   .getBillableCharges("XgCyMTaP1S97hfAj2RTP", "efwvzJt2LRWI6dpcYuqex5wt3ZX2")
//   .then((res) => console.log(res.map((e) => e.data())))
//   .catch((err) => console.log(err));

// chargeService
//   .getChargesById("efwvzJt2LRWI6dpcYuqex5wt3ZX2", [
//     "6JsadFlyBLWTPwXZz0g8",
//     "ndC1hcyu2mqaROslcgNh",
//     "MsEH2skvALKIGCjXW8bE",
//   ])
//   .then((res) => console.log(res.map((e) => e.data())))
//   .catch((err) => console.log(err));
