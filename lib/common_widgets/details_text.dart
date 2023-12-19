import 'package:flutter/material.dart';

class DetailsText extends StatelessWidget {
  const DetailsText({
    required this.name,
    required this.value,
    super.key,
  });

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              '$name : ',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
