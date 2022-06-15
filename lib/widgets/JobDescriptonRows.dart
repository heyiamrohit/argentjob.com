import 'package:flutter/material.dart';

class JobDescRows extends StatelessWidget {
  final IconData icon;
  final String postedBy;
  JobDescRows(this.icon, this.postedBy);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            size: 16,
          ),
        ),
        SizedBox(width: 5),
        Text(
          postedBy,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}