const INVOICE_COLLECTION = "invoices";
const USERS_COLLECTION = "users";
export class InovieService {
  constructor(private firestore: FirebaseFirestore.Firestore) {}

  async createInvoice(userId: string, data: any): Promise<string> {
    try {
      var res = await this.firestore
        .collection(USERS_COLLECTION)
        .doc(userId)
        .collection(INVOICE_COLLECTION)
        .add(data);
      return res.id;
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  async updateInvoice(
    userId: string,
    invoiceId: string,
    data: any
  ): Promise<void> {
    try {
      await this.firestore
        .collection(USERS_COLLECTION)
        .doc(userId)
        .collection(INVOICE_COLLECTION)
        .doc(invoiceId)
        .update(data);
    } catch (e) {
      console.log(e);
      throw e;
    }
  }
}
