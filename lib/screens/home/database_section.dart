import 'package:android_app/constants/constants.dart';
import 'package:android_app/models/dhikr.dart';
import 'package:android_app/provider/database_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DatabaseSection extends StatelessWidget {
  const DatabaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dbProvider = context.watch<DatabaseProvider>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last saves dhikrs'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 60,
              height: 2,
              color: blue,
              margin: const EdgeInsets.only(top: 2, bottom: 20),
            ),
            Expanded(
              child: FutureBuilder(
                future: context.read<DatabaseProvider>().openDhikrBox(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else {
                    final box = context.read<DatabaseProvider>().box;

                    return ListView.builder(
                      itemCount: dbProvider.box.length,
                      itemBuilder: (context, index) {
                        //Инвертация индекса
                        index = dbProvider.box.length - 1 - index;

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greyLight,
                          ),
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  box.getAt(index)?.counter.toString() ?? '',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 3,
                                color: Colors.white,
                                margin: const EdgeInsets.only(right: 20),
                              ),
                              Expanded(
                                child: Text(
                                  box.getAt(index)?.title ?? '',
                                  style: const TextStyle(fontSize: 12, height: 1.2),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  DateFormat('dd.MM.yyyy')
                                      .format(box.getAt(index)?.date ?? DateTime.now()),
                                  style: TextStyle(fontSize: 10, color: grey),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final controller = TextEditingController();

                                      return CupertinoAlertDialog(
                                        title: Text('Edit Dhikr'.tr()),
                                        content: Column(
                                          children: [
                                            const SizedBox(height: 20),
                                            Text(
                                              '${'Counter:'.tr()} ${box.getAt(index)?.counter}',
                                            ),
                                            const SizedBox(height: 10),
                                            CupertinoTextField(
                                              controller: controller,
                                              placeholder: box.getAt(index)?.title,
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    dbProvider.removeDhikr(index);
                                                    context.pop();
                                                  },
                                                  child: Text(
                                                    'Delete'.tr(),
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),

                                                FilledButton(
                                                  onPressed: () {
                                                    dbProvider.updateDhikr(
                                                      index,
                                                      Dhikr(
                                                        box.getAt(index)?.counter ?? 0,
                                                        controller.text,
                                                        DateTime.now(),
                                                      ),
                                                    );
                                                    context.pop();
                                                  },
                                                  child: Text(
                                                    'Save'.tr(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: greyLight,
                                  ),
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset('assets/icons/dots.svg'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
