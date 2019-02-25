import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Names.dart';

class Favs extends StatefulWidget {
  @override
  _FavsState createState() => _FavsState();
}

class _FavsState extends State<Favs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
      ),
      body: _buildFavsBody(context),
    );
  }
}

Widget _buildFavsBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('names').where("fav", isEqualTo: 2).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();

        return _buildFavsList(context, snapshot.data.documents);
      }
  );
}

Widget _buildFavsList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildFavsListItem(context, data)).toList(),
  );
}

Widget _buildFavsListItem(BuildContext context, DocumentSnapshot data) {
  final record = Names.fromSnapshot(data);

  _updateFavs() {
      record.reference.updateData({'fav' : 0});
  }


  return Padding(
    key: ValueKey(record.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      child: ListTile(
        title: Text(record.name),
        trailing: Icon(
            Icons.favorite, color: Colors.blue,
        ),
        onTap: () => _updateFavs(),
      ),
    ),
  );
}