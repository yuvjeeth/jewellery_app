import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jewellery_app/views/admin_portal.dart';

class DeleteItems extends StatefulWidget {
  const DeleteItems({super.key});

  @override
  State<DeleteItems> createState() => _DeleteItemsState();
}

class _DeleteItemsState extends State<DeleteItems> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _jewelleryCollection;

  @override
  void initState() {
    super.initState();
    _jewelleryCollection = _firestore.collection('Jewellery Items');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            const Text('Delete Items'),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPortal(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Back to Admin Portal'),
            ),
          ],
        ),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _jewelleryCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error fetching data');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final data = snapshot.data;

            if (data!.docs.isEmpty) {
              // Display message when no items are present
              return const Text('No items found.');
            }

            return SizedBox(
              width: 500,
              child: ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  final item = data.docs[index];
                  return _buildItemWidget(item);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemWidget(QueryDocumentSnapshot<Object?> item) {
    return SizedBox(
      child: ListTile(
        title: Text(item['Item Name'].toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['Item Description'].toString()),
            const SizedBox(height: 8),
            Image.network(
              item['Item imageLink'].toString(),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            _deleteItem(item.id);
          },
        ),
      ),
    );
  }

  Future<void> _deleteItem(String itemId) async {
    await _jewelleryCollection.doc(itemId).delete();
  }
}
