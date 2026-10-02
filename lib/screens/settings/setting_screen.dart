import 'package:android_app/provider/counter_provider.dart';
import 'package:android_app/provider/database_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langs = context.supportedLocales;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Setting'.tr())),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              context.go('/');
            },
            title: Text('Go back to Home Page'.tr()),
          ),
          ListTile(
            onTap: () {
              context.read<CounterProvider>().increment();
            },
            title: Text(context.watch<CounterProvider>().counter.toString()),
          ),
          ListTile(
            title: Text('Languages'.tr()),
            trailing: FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Select Language:'.tr()),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(langs.length, (index) {
                          final lang = langs[index].toString();

                          return ListTile(
                            onTap: () {
                              context
                                ..setLocale(langs[index])
                                ..pop()
                                ..go('/');
                            },
                            title: Text(langsMap[lang] ?? 'error'),
                          );
                        }),
                      ),
                    );
                  },
                );
              },
              child: Text(
                langsMap[context.locale.toString()] ?? 'error',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: context.read<DatabaseProvider>().box.listenable(),
            builder: (context, snapshot, _) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.length,
                  itemBuilder: (context, index) {
                    return Text(snapshot.getAt(index)?.title ?? '');
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
