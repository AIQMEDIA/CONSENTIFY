import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:consentify/model/agreement.dart';

final _lightColors = [
  Colors.white,
  Colors.white70,
  Colors.white,
  Colors.white70,
  Colors.white,
  Colors.white70
];

class AgreementCardWidget extends StatelessWidget {
  AgreementCardWidget({
    Key key,
    @required this.agreement,
    @required this.index,
  }) : super(key: key);

  final Agreement agreement;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(agreement.agreementTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.black38),
            ),
            SizedBox(height: 4),
            Text(
              agreement.consentAsker,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
