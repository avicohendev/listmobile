// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  final FirebaseFirestore _firestore;

  Repository(this._firestore) : assert(_firestore != null);

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection(
      String collectionName) async {
    final docRef = await _firestore.collection(collectionName).get();
    return docRef.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCollectionWithEqualCondition(String collectionName,
          String conditionFieldName, conditionFieldValue) async {
    final docRef = await _firestore
        .collection(collectionName)
        .where(conditionFieldName, isEqualTo: conditionFieldValue)
        .get();
    return docRef.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCollectionWithInCondition(String collectionName,
          String conditionFieldName, conditionFieldValue) async {
    final docRef = await _firestore
        .collection(collectionName)
        .where(conditionFieldName, arrayContains: conditionFieldValue)
        .where("active", isEqualTo: true)
        .get();
    return docRef.docs;
  }

  Future<DocumentReference<Map<String, dynamic>>> setData(
      String collectionPath, Map<String, dynamic> data) async {
    return await _firestore.collection(collectionPath).add(data);
  }

  Future<void> updateField(
      {required String collectionPath,
      required String doc,
      required Map<String, dynamic> newValue}) async {
    _firestore
        .collection(collectionPath)
        .doc(doc)
        .set(newValue)
        .onError((error, stackTrace) => print(error.toString()));
  }
}
/*
final washingtonRef = db.collection("cites").doc("DC");
washingtonRef.update({"capital": true}).then(
    (value) => print("DocumentSnapshot successfully updated!"),
    onError: (e) => print("Error updating document $e"));
*/
