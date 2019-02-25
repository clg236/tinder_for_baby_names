import 'package:flutter/material.dart';
import 'Names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'favs.dart' as favs;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Who is Blue?!'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => favs.Favs()),
              );
            }
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  // TODO: get actual snapshot from Cloud Firestore
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('names').snapshots(),
    builder: (context, snapshot) {
      if(!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.documents);
    }
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {

  final record = Names.fromSnapshot(data);
  final int alreadySaved = record.fav;
  if(record.fav == null) {
    record.reference.updateData({'fav' : 0});
  }

  _updateFavs() {
    if(alreadySaved < 1) {
      record.reference.updateData({'fav' : record.fav + 1});
    } else if(alreadySaved > 0) {
      record.reference.updateData({'fav' : record.fav - 1});

    }
  }

  return Padding(
    key: ValueKey(record.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      child: ListTile(
        title: Text(record.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          <Widget>[
            IconButton(
                icon: Icon(
                  (alreadySaved > 0) ? Icons.favorite : Icons.favorite_border,
                  color: (alreadySaved > 0) ? Colors.blue : null,
                ),
                onPressed: () => _updateFavs(),
            ),
            ]),
        onTap: () => _updateFavs(),
      ),
    ),
  );
}


