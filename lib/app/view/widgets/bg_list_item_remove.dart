import 'package:flutter/material.dart';

class BGListItemRemove extends StatelessWidget {
  const BGListItemRemove({Key? key}) : super(key: key);
  static const IconData delete = IconData(0xe1b9, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
