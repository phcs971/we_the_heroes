class Profile {
  String id, name, email;
  int hp;

  Profile({this.id, this.name, this.hp});

  Profile.fromMap(map, this.id) {
    this.name = map['name'];
    this.hp = map['hp'];
  }

  toMap() => {
        id: {
          'name': name,
          'hp': hp,
        }
      };
}
