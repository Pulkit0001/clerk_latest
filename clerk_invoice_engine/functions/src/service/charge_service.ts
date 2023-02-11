import { firestore } from "firebase-admin";

const CHARGES_COLLECTION = "charges";
const USERS_COLLECTION = "users";

export class ChargeService {
  constructor(private firestore: FirebaseFirestore.Firestore) {}

  async getChargesById(
    userId: string,
    ids: Array<string>
  ): Promise<Array<firestore.QueryDocumentSnapshot<firestore.DocumentData>>> {
    try {
        console.log(ids);
        console.log(userId);
      var res = await this.firestore
        .collection(USERS_COLLECTION)
        .doc(userId)
        .collection(CHARGES_COLLECTION)
        .where(firestore.FieldPath.documentId(), "in", ids)
        .get();
        console.log(res);
      if (res.docs.length > 0) {
        return res.docs.map((e) => e);
      } else {
        throw Error("Charges Not found");
      }
    } catch (e) {
      console.log(e);
      throw e;
    }
  }
}
