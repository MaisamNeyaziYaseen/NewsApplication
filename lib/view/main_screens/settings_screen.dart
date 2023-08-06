import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_application/view/components/settings_option_holder.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff023B5B),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            SettingsOptionsHolder(
                option: "Number of Items", value: "value", onTap: () {}),
            SettingsOptionsHolder(
                option: "Order By", value: "value", onTap: () {}),
            SettingsOptionsHolder(
                option: "From Date",
                value: "value",
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.parse("1990-01-01"),
                      lastDate: DateTime.now());
                }),
            SettingsOptionsHolder(
                option: "To Date",
                value: "value",
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.parse("1990-01-01"),
                      lastDate: DateTime.now());
                }),
          ],
        ));
  }
}
