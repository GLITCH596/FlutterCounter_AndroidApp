import 'package:android_app/provider/top_section_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final topSectionProvider = context.watch<TopSectionProvider>();

    final activity = topSectionProvider.activity;
    final toggleActivity = topSectionProvider.toggleActivity;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(

                    child: GestureDetector(
                      onTap: () => toggleActivity(true),

                      child: Container(
                        decoration: BoxDecoration(
                          color: activity ? blue : Colors.white,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        height: 30,
                        alignment: Alignment.center,
                        child: Text('Activity'.tr(),
                          style: TextStyle(
                            color: activity ? Colors.white : grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(

                    child: GestureDetector(
                      onTap: () => toggleActivity(false),

                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: activity ? Colors.white : blue,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        child: Text('Saved'.tr(),
                          style: TextStyle(
                            color: activity ? grey : Colors.white,
                            fontSize: 12,
                          ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigation 1.0
              //  - простая, для простых приложений
              //  - можно настроить именование в MaterialApp > routes
              // Navigation 2.0 (go_router)
              //  - умная система, позволяющая не создавать "петлю"
              context.go('/settings');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 54,
              height: 38,
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/icons/menu.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
