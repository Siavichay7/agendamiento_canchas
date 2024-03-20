import 'dart:convert';

import 'package:agendamiento_canchas/config/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reserva_providers.g.dart';

@Riverpod(keepAlive: true)
class RevervasList extends _$RevervasList {
  // final _prefs = SharedPreferencesData();

  @override
  List<dynamic> build() => [];

  getList() {
    // GET THE FAVORITE LIST OF LOCAL STORAGE
    final _prefs = SharedPreferencesData();
    String reservas = _prefs.reservaList;

    if (_prefs.reservaList != '') {
      final jsonList = jsonDecode(reservas);
      final list = jsonDecode(jsonList);
      // List newsList = list.map((json) => NewsPost.fromMap(json)).toList();
      return (list);
    } else {
      return [];
    }
  }
}

@Riverpod(keepAlive: true)
class AgregarRevervasList extends _$AgregarRevervasList {
  // final _prefs = SharedPreferencesData();
  TextEditingController dateController = new TextEditingController();
  TextEditingController username = new TextEditingController();

  @override
  List<dynamic> build() => [];

  addReserva() {
    print(dateController.text);
    print(username.text);
  }
}

@Riverpod(keepAlive: true)
class CanchaList extends _$CanchaList {
  @override
  List<String> build() => ['Cancha A', 'Cancha B', 'Cancha C'];
}

@Riverpod(keepAlive: true)
class NombreCancha extends _$NombreCancha {
  @override
  String build() => "Cancha A";

  getNombre(String code) async {
    state = code;
    print("ESTADO: $state");
    return state;
  }
}
