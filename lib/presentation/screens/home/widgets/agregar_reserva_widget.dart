import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

final customAlert = buildButton(
  onTap: () {
    var message = '';
  },
  title: 'Custom',
  text: 'Custom Widget Alert',
  leadingImage: 'assets/custom.gif',
);

Card buildButton({
  required onTap,
  required title,
  required text,
  required leadingImage,
}) {
  return Card(
    shape: const StadiumBorder(),
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    clipBehavior: Clip.antiAlias,
    elevation: 1,
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          leadingImage,
        ),
      ),
      title: Text(title ?? ""),
      subtitle: Text(text ?? ""),
      trailing: const Icon(
        Icons.keyboard_arrow_right_rounded,
      ),
    ),
  );
}
