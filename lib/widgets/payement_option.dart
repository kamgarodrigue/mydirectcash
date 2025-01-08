import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/fonts.dart';

class PayementModeOption extends StatefulWidget {
  PayementModeOption({super.key, required this.icon, required this.title});
  Icon icon;
  String title;

  @override
  _PayementModeOptionState createState() => _PayementModeOptionState();
}

class _PayementModeOptionState extends State<PayementModeOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      height: 35,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.icon,
                const SizedBox(
                  width: 5,
                ),
                Text(widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: content_font,
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
