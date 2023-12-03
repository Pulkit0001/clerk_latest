import 'package:clerk/app/data/models/group_data_model.dart';
import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/utils/custom_exception_handler.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GroupsService {
  final Session session;
  final FirebaseFirestore firestore;

  GroupsService(this.session, this.firestore);

  Future<String> createGroup({required Group groupData}) async {
    try {
      var id = session.currentUser!.uid;
      CollectionReference groups = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(GROUPS_COLLECTION);

      var res = await groups.add(groupData.toJson());

      return res.id;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<String> getCurrentGroup() async {
    try {
      var id = session.currentUser!.uid;
      CollectionReference groups = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(GROUPS_COLLECTION);

      // final currentTime = DateFormat('HH:mm ').format(DateTime.now());
      var res = await groups
          // .where('startTime', isGreaterThanOrEqualTo: currentTime)
          .get();
      return res.docs.isEmpty ? "" : res.docs.first.id;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<List<Group>> getGroups({List<String>? groupsId}) async {
    try {
      var id = session.currentUser!.uid;
      final groups = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(GROUPS_COLLECTION);

      final res = (await groups.get());
      Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> groupDocs;

      if (groupsId != null) {
        groupDocs = res.docs.where((element) =>
            groupsId.contains(element.id) &&
            element.data()['group_status'] == 'active');
      } else {
        groupDocs = res.docs
            .where((element) => element.data()['group_status'] == 'active');
        groupDocs = res.docs;
      }

      List<Group> groupList = groupDocs.map((e) {
        var x = e.data();
        x.addAll({"group_id": e.id});
        return Group.fromJson(x);
      }).toList();

      return groupList;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<bool> updateGroup(Group group) async {
    try {
      var id = session.currentUser!.uid;
      var groupDoc = await firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(GROUPS_COLLECTION)
          .doc(group.id)
          .get();

      if (groupDoc.exists) {
        await groupDoc.reference.update(group.toJson());
      }
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }

  Future<bool> deleteGroup(String groupId) async {
    try {
      var id = session.currentUser!.uid;
      var groupDoc = await firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(GROUPS_COLLECTION)
          .doc(groupId)
          .get();

      if (groupDoc.exists) {
        await groupDoc.reference.update({'group_status': 'disabled'});
      }
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }
}
