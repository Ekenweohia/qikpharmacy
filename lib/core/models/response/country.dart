import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final int? id;
  final String? name;
  final String? emoji;
  final String? emojiU;
  final List<State>? state;

  const Country({this.id, this.name, this.emoji, this.emojiU, this.state});

  @override
  List<Object?> get props => [id, name, emoji, emojiU, state];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'emojiU': emojiU,
      'state': state?.map((x) => x.toJson()).toList(),
    };
  }

  factory Country.fromJson(Map<String, dynamic> map) {
    return Country(
      id: map['id']?.toInt(),
      name: map['name'],
      emoji: map['emoji'],
      emojiU: map['emojiU'],
      state: map['state'] != null
          ? List<State>.from(map['state']?.map((x) => State.fromJson(x)))
          : null,
    );
  }
}

class State extends Equatable {
  final int? id;
  final String? name;
  final int? countryId;
  final List<City>? city;

  const State({this.id, this.name, this.countryId, this.city});

  @override
  List<Object?> get props => [id, name, countryId, city];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
      'city': city?.map((x) => x.toJson()).toList(),
    };
  }

  factory State.fromJson(Map<String, dynamic> map) {
    return State(
      id: map['id']?.toInt(),
      name: map['name'],
      countryId: map['country_id']?.toInt(),
      city: map['city'] != null
          ? List<City>.from(map['city']?.map((x) => City.fromJson(x)))
          : null,
    );
  }
}

class City extends Equatable {
  final int? id;
  final String? name;
  final int? stateId;

  const City({this.id, this.name, this.stateId});

  @override
  List<Object?> get props => [id, name, stateId];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': stateId,
    };
  }

  factory City.fromJson(Map<String, dynamic> map) {
    return City(
      id: map['id']?.toInt(),
      name: map['name'],
      stateId: map['state_id']?.toInt(),
    );
  }
}
