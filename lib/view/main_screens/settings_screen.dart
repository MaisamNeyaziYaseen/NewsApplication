import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_application/controller/news_controller.dart';
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
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text("Number of Items"),
                    subtitle: DropdownButton<int>(
                      value: ref.watch(newsProvider).getPageSize,
                      items: <int>[10, 20, 30, 40, 50]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            '$value',
                          ),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        ref.watch(newsProvider).setPageSize(newValue ?? 10);
                        ref.watch(newsProvider).getPagingController.refresh();
                      },
                    ),
                  ),
                ),
                Divider()
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text("Order By"),
                    subtitle: DropdownButton<String>(
                      value: ref.watch(newsProvider).getorderBy,
                      items: <String>['newest', 'oldest', 'relevence']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        ref
                            .watch(newsProvider)
                            .setOrderBy(newValue ?? "newest");
                        ref.watch(newsProvider).getPagingController.refresh();
                      },
                    ),
                  ),
                ),
                Divider()
              ],
            ),
            SettingsOptionsHolder(
                option: "From Date",
                value: ref.watch(newsProvider).getFromDate.substring(0, 10),
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.parse(ref.watch(newsProvider).getFromDate),
                      firstDate: DateTime.parse("1990-01-01"),
                      lastDate: DateTime.now());
                  if (newDate != null) {
                    ref.watch(newsProvider).setFromDate(newDate.toString());
                  }
                }),
            SettingsOptionsHolder(
                option: "To Date",
                value: ref.watch(newsProvider).getToDate.substring(0, 10),
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.parse(ref.watch(newsProvider).getFromDate),
                      firstDate: DateTime.parse("1990-01-01"),
                      lastDate: DateTime.now());
                  if (newDate != null) {
                    ref.watch(newsProvider).setToDate(newDate.toString());
                    ref.watch(newsProvider).getPagingController.refresh();
                  }
                }),
          ],
        ));
  }
}
