import 'package:realm/realm.dart';

part 'category_realm_entity.realm.dart';

@RealmModel()
class _CategoryRealmEntity {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late int? iconCodePoint; //Để lưu icon trong flutter. Icons
  late String? backgroundColorHex; //Color hex string
  late String? iconColorHex; //Color hex string
}
