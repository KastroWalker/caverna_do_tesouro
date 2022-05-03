import 'package:flutter/material.dart';

class FinancialOperationCard extends StatelessWidget {
  final String title;
  final Color cardColor;
  final String value;

  const FinancialOperationCard(
      {Key? key,
      required this.title,
      required this.cardColor,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffdfdfdf)),
        // color: const Color(0xfff8f8f8),
        color: cardColor,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text('R\$ $value', style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}