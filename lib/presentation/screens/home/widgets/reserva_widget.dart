import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReservaWidget extends ConsumerWidget {
  const ReservaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          title: Text(
            "CANCHA A",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        height: size.height * 0.15,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
    );
  }
}
