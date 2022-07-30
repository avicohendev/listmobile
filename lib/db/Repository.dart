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
      getCollectionWithCondition(String collectionName,
          String conditionFieldName, conditionFieldValue) async {
    final docRef = await _firestore
        .collection(collectionName)
        .where(conditionFieldName, isEqualTo: conditionFieldValue)
        .get();
    return docRef.docs;
  }

  Future<DocumentReference<Map<String, dynamic>>> setData(
      String collectionPath, Map<String, dynamic> data) async {
    return await _firestore.collection(collectionPath).add(data);
  }
}
