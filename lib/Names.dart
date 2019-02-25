import 'package:cloud_firestore/cloud_firestore.dart';

class Names {
  final String name;
  final int fav;
  final DocumentReference reference;
  final String birthyear;
  final String count;
  final String ethnicity;
  final String gender;
  final String rank;

  Names.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['brth_yr'] != null),
        assert(map['cnt'] != null),
        assert(map['ethcty'] != null),
        assert(map['gndr'] != null),
        assert(map['nm'] != null),
        assert(map['rnk'] != null),
        assert(map['fav'] != true),
        name = map['nm'],
        count = map['cnt'],
        birthyear = map['brth_yr'],
        ethnicity = map['ethcty'],
        gender = map['gndr'],
        rank = map['rnk'],
        fav = map['fav'];

  Names.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$fav>";
}
