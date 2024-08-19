import 'package:flutter/material.dart';

class FertigationBulletedDataWidget extends StatelessWidget {
  const FertigationBulletedDataWidget({
    required this.title,
    required this.value,
    required this.isTopElement,
    required this.isBottomElement,
    super.key,
  });

  final String title;
  final String value;
  final bool isTopElement;
  final bool isBottomElement;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            isTopElement
                ? const SizedBox(
                    height: 4,
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 4,
                      width: 10,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
            SizedBox(
              width: 10,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                maxRadius: 4,
              ),
            ),
            !isBottomElement
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 12,
                      width: 10,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 4,
                  ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 35,
          child: Text.rich(
            TextSpan(
              text: title,
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
