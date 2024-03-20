import 'package:agendamiento_canchas/presentation/providers/reserva_providers.dart';
import 'package:agendamiento_canchas/presentation/screens/home/widgets/reserva_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reservas Tennis",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          final dateController =
              ref.watch(agregarRevervasListProvider.notifier).dateController;
          final usernameController =
              ref.watch(agregarRevervasListProvider.notifier).username;
          final list = ref.watch(canchaListProvider);

          QuickAlert.show(
            context: context,
            type: QuickAlertType.custom,
            barrierDismissible: true,
            confirmBtnText: 'Guardar',
            confirmBtnColor: Colors.green,
            customAsset: 'assets/images/tennis.jpeg',
            widget: Column(
              children: [
                TextFormField(
                  onTap: () async {
                    DateTime? dateTime =
                        await showOmniDateTimePicker(context: context);
                    dateController.text = dateTime.toString();
                  },
                  controller: dateController,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'Ingresa fecha de reserva',
                    prefixIcon: Icon(
                      Icons.calendar_today,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  // onChanged: (value) => message = value,
                ),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'Nombre de usuario',
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      hoverColor: Colors.green,
                      focusColor: Colors.green),

                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  // onChanged: (value) => message = value,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: ref.watch(nombreCanchaProvider).toString(),
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.green,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    // setState(() {
                    //   dropdownValue = value!;
                    // });
                    ref.watch(nombreCanchaProvider.notifier).getNombre(value!);
                    print(ref.watch(nombreCanchaProvider).toString());
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Icon(FontAwesomeIcons.baseball),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value),
                            ),
                          ],
                        ));
                  }).toList(),
                ),
              ],
            ),
            onConfirmBtnTap: () async {
              final data =
                  ref.watch(agregarRevervasListProvider.notifier).addReserva();

              // if (message.length < 5) {
              // await QuickAlert.show(
              //   context: context,
              //   type: QuickAlertType.error,
              //   text: 'Please input something',
              // );
              // return;
              // // }
              // Navigator.pop(context);
              // // if (mounted) {
              // QuickAlert.show(
              //   context: context,
              //   type: QuickAlertType.success,
              //   text: "Phone number '' has been saved!.",
              // );
              // // }
            },
          );
          // Add your onPressed code here!
        },
        label: const Text(
          'Reservar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ReservaWidget(),
    );
  }
}
