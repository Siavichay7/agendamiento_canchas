import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ReservaWidget extends ConsumerWidget {
  const ReservaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Container(
        child: ListTile(
            title: Text(
              "CANCHA A",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2024/02/11'),
                Text("XSIAVICHAY"),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.cloudRain),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("13%"),
                    )
                  ],
                ),
              ],
            ),
            trailing: Column(
              children: [
                IconButton(
                    onPressed: () {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          title: 'Eliminar',
                          text: 'Deseas eliminar la reserva?',
                          confirmBtnText: 'Si',
                          cancelBtnText: 'No',
                          barrierDismissible: true,
                          confirmBtnColor: Colors.green,
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Se ha eliminado exitosamente la reserva!',
                            );
                            print("object");
                          });
                    },
                    icon: Icon(FontAwesomeIcons.trash)),
              ],
            )),
        height: size.height * 0.14,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 248, 248),
            borderRadius: BorderRadius.all(Radius.circular(18))),
      ),
    );
  }
}
