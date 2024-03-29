import 'dart:developer';

import 'package:agendamiento_canchas/presentation/providers/reserva_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localstorage/localstorage.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ReservaWidget extends ConsumerWidget {
  Map<String, dynamic>? reserva;
  ReservaWidget({super.key, this.reserva});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocalStorage storage = new LocalStorage('reservas.json');

    final size = MediaQuery.of(context).size;
    final list = ref.watch(revervasListProvider.notifier).getList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Container(
        child: ListTile(
            title: Text(
              reserva!["cancha"],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reserva!['date']),
                Text(reserva!["username"]),
                SizedBox(
                  height: 5,
                ),
                Icon(FontAwesomeIcons.cloudRain),
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                reserva!["cloud"] + "%",
                style: TextStyle(fontSize: size.width * 0.04),
              ),
            )),
        height: size.height * 0.14,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 248, 248),
            borderRadius: BorderRadius.all(Radius.circular(18))),
      ),
    );
  }
}
