import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsOptionsHolder extends ConsumerWidget {
  String option;
  String value;
  Function() onTap;

  SettingsOptionsHolder(
      {required this.option, required this.value, required this.onTap});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: ListTile(
            title: Text(option),
            subtitle: Text(value),
          ),
        ),
        Divider()
      ],
    );
  }
}
