import { firestore } from "firebase-admin";
import Timestamp = firestore.Timestamp;

const CANDIDATES_COLLECTION = "candidates";
const USERS_COLLECTION = "users";
const CHARGES_COLLECTION = "charges";

export class CandidateService {
  constructor(private firestore: FirebaseFirestore.Firestore) {}

  async getBillableCharges(
    id: string,
    userId: string
  ): Promise<Array<firestore.QueryDocumentSnapshot<firestore.DocumentData>>> {
    try {
      var res = await this.firestore
        .collection(USERS_COLLECTION)
        .doc(userId)
        .collection(CANDIDATES_COLLECTION)
        .doc(id)
        .collection(CHARGES_COLLECTION)
        // .where("next_billing_date", "<=", Timestamp.now())
        .where("status", "==", "active")
        .get();
      if (res.docs.length) {
        var charges =
          Array<firestore.QueryDocumentSnapshot<firestore.DocumentData>>();
        res.docs.forEach((element) => {
          charges.push(element);
        });
        return charges;
      } else {
        throw Error("Candidate Not found");
      }
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  async updateChargesNextBillingDate(
    canidateId: string,
    userId: string,
    chargesDoc: Map<string, any>
  ): Promise<void> {
    const documents = await this.firestore
      .collection(USERS_COLLECTION)
      .doc(userId)
      .collection(CANDIDATES_COLLECTION)
      .doc(canidateId)
      .collection(CHARGES_COLLECTION)
      .where(firestore.FieldPath.documentId(), "in", [...chargesDoc.keys()])
      .get();

    const writeBatch = this.firestore.batch();
    documents.docs.forEach((doc) => {
      if (chargesDoc.get(doc.id) !== undefined) {
        console.log(chargesDoc.get(doc.id));
        // console.log((chargesDoc.get(doc.id)));
        writeBatch.update(doc.ref, chargesDoc.get(doc.id));
      }
    });
    await writeBatch.commit();
  }

  async updateCandidateBillingDate(
    id: string,
    userId: string,
    nextBillingDate: Timestamp,
    invoiceId: String | undefined
  ): Promise<void> {
    try {
      var candidate = this.firestore
        .collection(USERS_COLLECTION)
        .doc(userId)
        .collection(CANDIDATES_COLLECTION)
        .doc(id);
      var data;
      if (invoiceId) {
        data = {
          next_billing_date: nextBillingDate,
          candidate_payments:
            firestore.FieldValue.arrayUnion(invoiceId),
        };
      } else {
        data = {
          next_billing_date: nextBillingDate,
        };
      }
      await candidate.update(data);
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  async updateCandidateNotifyDate(
    id: string,
    userId: string,
    lastNotified: Timestamp
  ): Promise<void> {
    try {
      var candidate = this.firestore
        .collection(USERS_COLLECTION)
        .doc(userId)
        .collection(CANDIDATES_COLLECTION)
        .doc(id);

      await candidate.update({
        last_notified: lastNotified,
      });
    } catch (e) {
      console.log(e);
      throw e;
    }
  }
}
