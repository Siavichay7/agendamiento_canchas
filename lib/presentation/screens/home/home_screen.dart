import 'package:agendamiento_canchas/presentation/screens/home/widgets/reserva_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
