import 'dart:convert';

class Reserva {
  String? date;
  String? username;
  String? cancha;

  Reserva({
    this.date,
    this.username,
    this.cancha,
  });

  Reserva copyWith({
    String? date,
    String? username,
    String? cancha,
  }) =>
      Reserva(
        date: date ?? this.date,
        username: username ?? this.username,
        cancha: cancha ?? this.cancha,
      );

  factory Reserva.fromRawJson(String str) => Reserva.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        date: json["date"],
        username: json["username"],
        cancha: json["cancha"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "username": username,
        "cancha": cancha,
      };
}
