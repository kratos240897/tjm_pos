import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

class CustomRadio extends HookWidget {
  const CustomRadio({
    required this.label,
    required this.choices,
    required this.onSelected,
    super.key,
  });

  final String label;
  final List<String> choices;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: styles.f12SemiBold(),
        ),
        6.verticalSpace,
        Wrap(
          spacing: 5.w,
          children: List.generate(choices.length, (index) {
            final isSelected = selectedIndex.value == index;
            return ChoiceChip(
              backgroundColor: Colors.grey.shade300,
              selectedColor: Colors.grey.shade100,
              elevation: 2.sp,
              checkmarkColor: orange,
              side: BorderSide(
                  color: isSelected ? orange : Colors.black,
                  width: isSelected ? 0.6.sp : 0.2.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              label: Text(choices[index]),
              selected: isSelected,
              onSelected: (value) {
                if (value) {
                  selectedIndex.value = index;
                  onSelected(index);
                }
              },
            );
          }),
        ),
      ],
    );
  }
}
