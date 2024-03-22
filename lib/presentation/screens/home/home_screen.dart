import 'package:agendamiento_canchas/config/services/weather_service.dart';
import 'package:agendamiento_canchas/presentation/providers/reserva_providers.dart';
import 'package:agendamiento_canchas/presentation/screens/home/widgets/reserva_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var reservaProvider = ref.watch(revervasListProvider);
    if (reservaProvider.length == 0) {
      reservaProvider = ref.watch(revervasListProvider.notifier).getList();
    }
    final size = MediaQuery.of(context).size;

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
                ref.watch(revervasListProvider.notifier).dateController;
            final usernameController =
                ref.watch(revervasListProvider.notifier).username;
            var list = ref.watch(canchaListProvider);

            var cancha = ref.read(nombreCanchaProvider);
            cancha = list.first;
            print("CANCHA: $cancha");
            QuickAlert.show(
              context: context,
              type: QuickAlertType.custom,
              barrierDismissible: true,
              confirmBtnText: 'Guardar',
              confirmBtnColor: Colors.green,
              customAsset: 'assets/images/tennis.jpeg',
              widget: Consumer(builder: (context, refe, child) {
                return Column(children: [
                  TextFormField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? dateTime =
                          await showOmniDateTimePicker(context: context);
                      dateController.text = dateTime.toString();
                      // Convertir a objeto DateTime
                      DateTime dateTime2 = DateTime.parse(dateTime.toString());

                      // Formatear la fecha en el nuevo formato
                      String fechaFormateada =
                          DateFormat('yyyy-MM-dd').format(dateTime2);
                      var cloud = getWeather(fechaFormateada);
                      cloud.then((value) => refe
                          .read(weatherProvider.notifier)
                          .setWeather(value));
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(FontAwesomeIcons.cloudRain),
                        Text(
                          refe.watch(weatherProvider) + '%',
                          style: TextStyle(fontSize: size.width * 0.04),
                        ),
                      ],
                    ),
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
                    value: refe.watch(nombreCanchaProvider),
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.green,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      refe
                          .read(nombreCanchaProvider.notifier)
                          .setNombre(value!);
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Icon(FontAwesomeIcons.baseball),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            ],
                          ));
                    }).toList(),
                  )
                ]);
              }),
              onConfirmBtnTap: () async {
                Navigator.pop(context);
                final result =
                    ref.read(revervasListProvider.notifier).addReserva();
                if (!!result) {
                  QuickAlert.show(
                    title: 'Éxito',
                    context: context,
                    type: QuickAlertType.success,
                    text: 'Reserva realizada!',
                    onConfirmBtnTap: () {
                      Navigator.pop(context);
                      print("ss");
                      print(
                          ref.refresh(revervasListProvider.notifier).getList());
                    },
                  );
                } else {
                  QuickAlert.show(
                    title: 'Advertencia',
                    context: context,
                    type: QuickAlertType.warning,
                    text:
                        'No se puede agregar más reservas para esta cancha en esta fecha y los campos son obligatorios',
                  );
                }
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
        body: RefreshIndicator(
          onRefresh: () async => ref.refresh(revervasListProvider),
          child: ListView.builder(
            itemCount: reservaProvider.length,
            itemBuilder: (BuildContext context, int index) {
              return ReservaWidget(reserva: reservaProvider[index]);
            },
          ),
        ));
  }
}
