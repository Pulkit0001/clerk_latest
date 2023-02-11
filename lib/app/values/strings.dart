


const String defaultErrorTitle = "OOPS!";
const String defaultErrorBody = "Some error is happening. Please contact us to our support email help.modcons@gmail.com";
const String ACTION_TYPE = "Some error is happening. Please contact us to our support email help.modcons@gmail.com";


const String ADD_CANDIDATE = "add candidate";
const String EDIT_CANDIDATE = "edit candidate";




const String ADD_GROUP = "add group";
const String EDIT_GROUP = "edit group";
const String VIEW_GROUP = "view group";



const String USERS_COLLECTION = "users";
const String CANDIDATES_COLLECTION = "candidates";
const String GROUPS_COLLECTION = "groups";
const String CHARGES_COLLECTION = "charges";
const String INVOICES_COLLECTION = "invoices";


const String candidate_id_key = "candidate_id";
const String candidate_age_key = "candidate_age";
const String candidate_name_key = "candidate_name";
const String candidate_group_key = "candidate_group";
const String candidate_email_key = "candidate_email";
const String candidate_charges_key = "candidate_charges";
const String candidate_contact_key = "candidate_contact";
const String candidate_address_key = "candidate_address";
const String candidate_payments_key = "candidate_payments";
const String candidate_profile_pic_key = "candidate_profile_pic";
const String candidate_optional_contact_key = "candidate_optional_contact";
const String candidate_status_key = "candidate_status";
const dummyCandidateData =  {
  "candidate_id": "dnfjnsdjnfjknfjke",
  "candidate_age": 24,
  "candidate_name": "Pulkit",
  "candidate_group": "dnfjnsdjsfsdf",
  "candidate_email": "pulkit@gmail.com",
  "candidate_charges": ["dnfsdnjsdl", "fjdsfndnfjn"],
  "candidate_contact": "+91 7988643817",
  "candidate_address": "nsb sbfhsb s afbahsbf",
  "candidate_payments": ["sdgsdlgsdj", "msdkmfkmsdkmk", "mfksmdkmf"],
  "candidate_profile_pic": "smdkgmksdsdkmkdk s",
  "candidate_optional_contact": "+91 7988643817",
  "candidate_status": "active",
};


const String group_id_key = "group_id";
const String group_name_key = "group_name";
const String group_charges_key = "group_charges";
const String group_end_time_key = "group_end_time";
const String group_start_time_key = "group_start_time";
const String group_candidates_key = "group_candidates";
const String group_status_key = "group_status";

const dummyGroupData =  {
  "group_id": "dnfjnsdjnfjknfjke",
  "group_name": "Pulkit",
  "group_charges": ["dnfsdnjsdl", "fjdsfndnfjn"],
  "group_start_time": "06: 00 AM",
  "group_end_time": "08: 00 AM",
  "group_candidates": ["sdgsdlgsdj", "msdkmfkmsdkmk", "mfksmdkmf"],
  "group_status": "active",
};

const String charge_id_key = "charge_id";
const String charge_name_key = "charge_name";
const String charge_amount_key = "charge_amount";
const String charge_interval_key = "charge_interval";
const String charge_type_key = "charge_payment_type";
const String charge_description_key = "charge_description_key";
const String charge_status_key = "charge_status";

const dummyChargeData =  {
  "charge_id": "dnfjnsdjnfjknfjke",
  "charge_name": "Pulkit",
  "charge_amount": 500.45,
  "charge_interval": "msknjfns",
  "charge_payment_type": "kasknjf",
  "charge_description_key": "sjbdhfbhs",
  "charge_status": "active",
};

const String ADD_CHARGE = "add charge";
const String EDITCHARGE = "edit charge";
