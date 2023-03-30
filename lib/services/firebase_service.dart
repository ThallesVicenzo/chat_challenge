import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> getCollectionSnapshot(
      String path) {
    return instance.collection(path);
  }

  static DocumentReference<Map<String, dynamic>> getDocumentSnapshot(
      String collection, String doc) {
    return instance.collection(collection).doc(doc);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionStream(
      String path,
      {String? orderBy}) {
    final collection = instance.collection(path);
    if (orderBy != null) {
      return collection.orderBy(orderBy).snapshots();
    }
    return collection.snapshots();
  }
}
