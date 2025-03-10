import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_app/core/criteria/where_criteria.dart';

class FirebaseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> index(String collectionName, {WhereCriteria? where}) async {
    try {
      Query<Map<String, dynamic>> collection;
      if (where == null) {
        collection = _firestore.collection(collectionName);
      } else {
        collection = _firestore.collection(collectionName).where(
          where.field,
          arrayContains: where.arrayContains,
          arrayContainsAny: where.arrayContainsAny,
          isEqualTo: where.isEqualTo,
          isGreaterThan: where.isGreaterThan,
          isGreaterThanOrEqualTo: where.isGreaterThanOrEqualTo,
          isLessThan: where.isLessThan,
          isLessThanOrEqualTo: where.isLessThanOrEqualTo,
          isNotEqualTo: where.isNotEqualTo,
          isNull: where.isNull,
          whereIn: where.whereIn,
          whereNotIn: where.whereNotIn,
        ).where(where.anotherField.toString(), arrayContains: where.anotherIsEqualTo);
      }
      
      return (await collection.get()).docs;
    } catch (e) {
      throw Exception(e);
    }
  }
  

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> show(String collectionName, String docId, {WhereCriteria? where, String idKey = 'id'}) async {
    try {
      Query<Map<String, dynamic>> collection = _firestore.collection(collectionName).where(
        idKey,
        isEqualTo: docId,
      );
      return (await collection.get()).docs.first;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DocumentReference<Map<String, dynamic>>?> store(String collectionName, Map<String, dynamic> data, {String? id}) async {
    try {
      final DocumentReference<Map<String, dynamic>> doc;
      if (id == null) {
        doc = await _firestore.collection(collectionName).add(data);
        await doc.update({'id': doc.id});
      } else {
        doc = await _firestore.collection(collectionName).doc(id).set(data).then(
          (_) => _firestore.collection(collectionName).doc(id)
        );
      }
      return doc;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> update(String collectionName, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).doc(docId).update(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}