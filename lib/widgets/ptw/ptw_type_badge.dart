import 'package:flutter/material.dart';
import '../../models/ptw/ptw_model.dart';

class PtwTypeBadge extends StatelessWidget {
  final PtwType type;

  const PtwTypeBadge({super.key, required this.type});

  Color _color() {
    switch (type) {
      case PtwType.powerBlockOHE:
        return Colors.red.shade700;
      case PtwType.trackPossession:
        return Colors.orange.shade800;
      case PtwType.signalingTelecom:
        return Colors.blue.shade700;
      case PtwType.civilViaduct:
        return Colors.teal.shade700;
      case PtwType.stationMEP:
        return Colors.purple.shade700;
    }
  }

  IconData _icon() {
    switch (type) {
      case PtwType.powerBlockOHE:
        return Icons.electric_bolt_rounded;
      case PtwType.trackPossession:
        return Icons.train_rounded;
      case PtwType.signalingTelecom:
        return Icons.sensors_rounded;
      case PtwType.civilViaduct:
        return Icons.foundation_rounded;
      case PtwType.stationMEP:
        return Icons.build_circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _color();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon(), size: 12, color: c),
          const SizedBox(width: 4),
          Text(
            type.code,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: c,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
