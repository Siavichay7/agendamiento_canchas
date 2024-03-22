import 'dart:convert';
import 'dart:developer';

import 'package:agendamiento_canchas/config/models/create_reserva_model.dart';
import 'package:agendamiento_canchas/config/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reserva_providers.g.dart';

@Riverpod(keepAlive: true)
class RevervasList extends _$RevervasList {
  final _prefs = SharedPreferencesData();
  TextEditingController dateController = new TextEditingController();
  TextEditingController username = new TextEditingController();
  @override
  List<dynamic> build() => [];

  List<dynamic> getList() {
    // Obtener la lista de reservas del almacenamiento local
    String reservas = _prefs.reservaList;

    if (reservas != null && reservas.isNotEmpty) {
      // Decodificar la cadena JSON
      List<dynamic> list = jsonDecode(reservas);

      // Ordenar la lista por fecha de mayor a menor
      list.sort((a, b) {
        DateTime fechaA = DateTime.parse(a['date']);
        DateTime fechaB = DateTime.parse(b['date']);
        return fechaB.compareTo(fechaA); // Cambio de fechaB.compareTo(fechaA)
      });
      return list;
    } else {
      return [];
    }
  }

  bool addReserva() {
    List<dynamic> listSaved = getList();
    var cancha = ref.watch(nombreCanchaProvider);
    var cloud = ref.watch(weatherProvider);
    var fechaReserva = dateController
        .text; // Suponiendo que esto devuelve la fecha en formato de cadena (e.g., "2024-03-21")

    // Obtener todas las reservas para el día específico
    List<dynamic> reservasParaFecha =
        listSaved.where((reserva) => reserva['date'] == fechaReserva).toList();

    // Contar cuántas veces se ha reservado la cancha para la fecha específica
    int reservasParaCancha = reservasParaFecha
        .where((reserva) => reserva['cancha'] == cancha)
        .length;

    if (reservasParaCancha < 3) {
      print(fechaReserva);
      print(username.text);
      print(cancha);
      if (fechaReserva == '' || username.text == '' || cancha == '') {
        // Crear el objeto JSON
        print('Los campos son obligatorios');

        return false; // Guardar la lista de reservas como cadena JSON
      } else {
        Map<String, dynamic> create = {
          "date": fechaReserva,
          "username": username.text,
          "cancha": cancha,
          "cloud": cloud
        };

        listSaved.add(create);
        state = listSaved;
        inspect(state);
        _prefs.reservaList = jsonEncode(state);
        dateController.text = '';
        username.text = '';
        return true;
      }
    } else {
      // Ya se ha alcanzado el límite de reservas para esta cancha en este día
      print('No se puede agregar más reservas para esta cancha en esta fecha');
      return false;
    }
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

  setNombre(String code) async {
    state = code;
    print("ESTADO: $state");
  }
}

@Riverpod(keepAlive: true)
class Weather extends _$Weather {
  @override
  String build() => "";

  setWeather(String code) async {
    state = code;
    print("ESTADO: $state");
  }
}
