import 'package:android_app/constants/constants.dart';
import 'package:android_app/models/dhikr.dart';
import 'package:android_app/provider/counter_provider.dart';
import 'package:android_app/provider/database_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/top_section_provider.dart';

/*
main > material app > home (+ логика) > sections (+ логика)
                                \/
                                \/

main > material app > home > section
                    > логика
 */

// Stateless - неизменяемость
//             жизненный цикл: создался класс > build нарисовал то что мы видим
// Stateful - изменяемость
//             жизненный цикл:
//             0) createState - создалось состояние виджета, которое предпологает динамичность/изменяемость
//             1) initState - срабатывает сторого 1 раз во время отрисовки виджета
//                            нужен для запуска/инициации некоторых процессов
//                            или функций, которые предпологают срабатываение гарантированно один раз во время отрисовки
//             3) setState - обновить экран reBuild
//             4) dispose - когда виджет удаляется из стека виджетов, сработает гарантированно один раз
class CounterSection extends StatelessWidget {
  const CounterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = context.read<CounterProvider>();

    return Visibility(
      visible: context.watch<TopSectionProvider>().activity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),

              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => counterProvider.decrement(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: blueLight,
                      ),
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/icons/dec.svg'),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => counterProvider.increment(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: blue,
                      ),
                      width: 154,
                      height: 154,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const CurrentCounter(),
                          Text(
                            'Dhikr'.tr(),
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => counterProvider.zeroing(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: blueLight,
                      ),
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/icons/zeroinc.svg'),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final controller = TextEditingController();

                    return CupertinoAlertDialog(
                      title: Text('Save Dhikr'.tr()),
                      content: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text('${'Counter:'.tr()} ${counterProvider.counter}'),
                          const SizedBox(height: 10),
                          CupertinoTextField(
                            controller: controller,
                            placeholder: 'Enter title'.tr(),
                          ),
                          const SizedBox(height: 20),
                          FilledButton(
                            onPressed: () {
                              context.read<DatabaseProvider>().addDhikr(
                                Dhikr(
                                  counterProvider.counter,
                                  controller.text,
                                  DateTime.now(),
                                ),
                              );
                              context.pop();
                              controller.dispose();
                            },
                            child: Text(
                              'Saved'.tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                height: 45,
                alignment: Alignment.center,
                child: Text(
                  'Save Dhikr'.tr(),
                  style: TextStyle(color: blue, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentCounter extends StatelessWidget {
  const CurrentCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = context.watch<CounterProvider>();

    return Text(
      '${counterProvider.counter}',
      style: TextStyle(
        fontSize: 48,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    );
  }
}
