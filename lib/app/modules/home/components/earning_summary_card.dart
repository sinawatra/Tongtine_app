
import 'package:flutter/material.dart';
import 'package:homework_app/app/common/style/style.dart';

class EarningSummaryCard extends StatelessWidget {
  const EarningSummaryCard({
    super.key,
    this.width = 192,
    this.height = 77,
    this.backgroundColor = const Color(0xFFEBFAFF),
    this.title = 'Commission Earned',
    required this.amountText,
    this.trailing,
  });

  final double width;
  final double height;
  final Color backgroundColor;

  final String title;
  final String amountText;

  /// Optional trailing decoration/icon (top-right). Example: Image/SVG/Icon widget.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // main content
          Positioned.fill(
            child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160,
                    height: 16,
                    child: Text(
                      title,
                      style: localizedTextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        amountText,
                        style: localizedTextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // trailing (top-right)
          if (trailing != null)
            Positioned(
              left: 108,
              top: -8,
              width: 100,
              height: 100,
              child: IgnorePointer(
                child: trailing!,
              ),
            ),
        ],
      ),
    );
  }
}
