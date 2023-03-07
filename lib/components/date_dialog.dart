import 'package:Prismaa/components/get_persian_date.dart';
import 'package:flutter/material.dart';


Future<void> openGetDateDialog(StateSetter setState2, BuildContext context, TextEditingController _controller) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
            child: GetPersianDate(dateChangeListener: (String date) {
              setState2(() {
                _controller.text = date;
              });
            })
        ),
      );
    },
  );
}
