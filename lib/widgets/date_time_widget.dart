import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/app_style.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget(
      {super.key,
      required this.titleText,
      required this.valueText,
      required this.iconSection,
        required this.onTap});

  final String titleText;
  final String valueText;
  final IconData iconSection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: Appstyle.headingOne,
          ),
          const Gap(6),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                 onTap();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(iconSection),
                      const Gap(12),
                      Text(valueText),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
