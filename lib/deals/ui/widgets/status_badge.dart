import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../model/deal_model.dart';

class StatusBadge extends StatelessWidget {
  final DealStatus status;

  const StatusBadge({super.key, required this.status});

  Color get _color {
    switch (status) {
      case DealStatus.open:
        return AppColors.statusOpen;
      case DealStatus.closed:
        return AppColors.statusClosed;
    }
  }

  String get _label {
    switch (status) {
      case DealStatus.open:
        return 'Open';
      case DealStatus.closed:
        return 'Closed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _color.withOpacity(0.4), width: 1),
      ),
      child: Text(
        _label,
        style: AppTextStyles.label.copyWith(color: _color, fontSize: 10),
      ),
    );
  }
}
