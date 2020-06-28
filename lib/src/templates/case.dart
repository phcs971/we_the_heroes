class Case {
  String id, ownerId, heroId, title, description, locale;
  CaseStatus status;
  int hp;

  Case({
    this.id,
    this.ownerId,
    this.description,
    this.heroId,
    this.hp,
    this.status,
    this.title,
    this.locale,
  });

  Case.fromMap(map, this.id) {
    this.ownerId = map['ownerId'];
    this.heroId = map['heroId'];
    this.title = map['title'];
    this.description = map['description'];
    this.hp = map['hp'];
    this.status = CaseStatus.values[map['status']];
    this.locale = map['locale'];
  }

  toMap() => {
        id: {
          'ownerId': ownerId,
          'heroId': heroId,
          'title': title,
          'description': description,
          'hp': hp,
          'status': status.index,
          'locale': locale,
        }
      };
}

enum CaseStatus { TO_DO, IN_PROGRESS, COMPLETED, FINISHED }
