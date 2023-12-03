import { firestore } from "firebase-admin";
import { CandidateService } from "./service/candidate_service";
import { ChargeService } from "./service/charge_service";
import { InovieService } from "./service/invoice_service";
import Timestamp = firestore.Timestamp;

const secondsInDay = 60 * 60 * 24;
export class ClerkEngine {
  constructor(
    private candidateService: CandidateService,
    private chargesService: ChargeService,
    private invoiceService: InovieService
  ) { }

  async generateInvoice(candidateId: string, userId: string): Promise<string> {
    try {
      var billableCharges = await this.candidateService.getBillableCharges(
        candidateId,
        userId
      );
      var charges = await this.chargesService.getChargesById(
        userId,
        billableCharges.map((e) => e.data()["charge_id"])
      );
      var data = this._generateInvoiceData(charges.map((e) => e.data()));

      var invoiceId = await this.invoiceService.createInvoice(userId, data);

      var chargesData = this._generateNextBillingData(billableCharges, charges);

      await this.candidateService.updateChargesNextBillingDate(
        candidateId,
        userId,
        chargesData
      );

      var minDate = Date.now() + 17520 * 60 * 60 * 1000000;
      chargesData.forEach((e) => {
        
       console.log( e.next_billing_date.seconds, "Charge Next Billing Date");
       console.log( Timestamp.fromMillis(minDate).seconds, "Min date");
        if (e.next_billing_date.seconds <= Timestamp.fromMillis(minDate).seconds) {
          minDate = e.next_billing_date.seconds;
        }
      });
      console.log(Timestamp.fromMillis(minDate * 1000), "Final Mon date");
      var isIssued = await this.issueInvoice(
        userId,
        invoiceId,
        candidateId,
        Timestamp.fromMillis(minDate * 1000)
      );
      if (isIssued) {
        await this.notifyPayer(userId, invoiceId, candidateId);
        return invoiceId;
      } else {
        throw Error("Can't generate Invoice");
      }
    } catch (error) {
      console.log(error, "In Generate Invoice Method.............................................");
      throw error;
    }
  }

  _generateNextBillingData(
    billableCharges: Array<
      firestore.QueryDocumentSnapshot<firestore.DocumentData>
    >,
    chargesData: Array<firestore.QueryDocumentSnapshot<firestore.DocumentData>>
  ): Map<string, any> {
    var data = new Map<string, any>();
    chargesData.forEach((element) => {
      var x = billableCharges.filter(
        (e) => e.data().charge_id == element.id
      )[0];
      var paymentType = element.data().charge_interval;
      var updateData = {
        last_billed_at: Timestamp.now(),
        next_billing_date: Timestamp.now(),
      };

      console.log(paymentType);
      switch (paymentType) {
        case "weekly": {
          updateData.next_billing_date = Timestamp.fromMillis(
            secondsInDay * 7 * 1000
          );
          break;
        }
        case "halfMonthly": {
          updateData.next_billing_date = Timestamp.fromMillis(
            secondsInDay * 15 * 1000
          );
          break;
        }
        case "monthly": {
          var date = new Date();
          date.setMonth(date.getMonth() + 1);
          console.log(date);
          console.log(Timestamp.fromDate(date));
          updateData.next_billing_date = Timestamp.fromDate(date);
          break;
        }
        case "threeMonths": {
          var date = new Date();
          date.setMonth(date.getMonth() + 3);
          updateData.next_billing_date = Timestamp.fromDate(date);
          break;
        }
        case "halfYearly": {
          var date = new Date();
          date.setMonth(date.getMonth() + 6);
          updateData.next_billing_date = Timestamp.fromDate(date);
          break;
        }
        case "annual": {
          var date = new Date();
          date.setFullYear(date.getFullYear() + 1);
          updateData.next_billing_date = Timestamp.fromDate(date);
          break;
        }
        case "biAnnual": {
          var date = new Date();
          date.setFullYear(date.getFullYear() + 2);
          updateData.next_billing_date = Timestamp.fromDate(date);
          break;
        }
      }
      data.set(x.id, updateData);
    });
    return data;
  }

  async issueInvoice(
    userId: string,
    invoiceId: string,
    candidateId: string,
    nextBillingDate: Timestamp
  ): Promise<boolean> {
    try {
      var data = {
        payerId: candidateId,
        issuedAt: Timestamp.now(),
        invoiceStatus: "issued",
        status: "active",
      };
      await this.invoiceService.updateInvoice(userId, invoiceId, data);
      /// Update issued at and next billing date
      await this.candidateService.updateCandidateBillingDate(
        candidateId,
        userId,
       nextBillingDate,
        invoiceId
      );
      return true;
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  async notifyPayer(
    userId: string,
    invoiceId: string,
    candidateId: string
  ): Promise<boolean> {
    try {
      var data = {
        invoiceStatus: "pending",
        lastNotifiedAt: Timestamp.now()
      };
      /// Update last notified at
      await this.candidateService.updateCandidateNotifyDate(
        candidateId,
        userId,
        Timestamp.now()
      );
      await this.invoiceService.updateInvoice(userId, invoiceId, data);
      return true;
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  private _generateInvoiceData(charges: Array<firestore.DocumentData>) {
    var totalSum = 0;
    var items = Array<any>();
    charges.forEach((element) => {
      totalSum = totalSum + element.charge_amount;
      var item = {
        chargeName: element.charge_name,
        chargeDescription: element.charge_description_key,
        chargeAmount: element.charge_amount,
        chargedAt: Timestamp.now(),
      };
      items.push(item);
    });
    return {
      totalAmount: totalSum,
      invoiceStatus: "created",
      dueDate: Timestamp.fromMillis(Date.now() + 259200000),
      status: "disabled",
      invoiceItems: items,
      createdAt: Timestamp.now()
    };
  }
}
