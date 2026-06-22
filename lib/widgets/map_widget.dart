import 'package:flutter/material.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F9),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE0E7F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Color(0xFF0F3B4F),
              size: 48,
            ),
            const SizedBox(height: 12),
            const Text(
              'خريطة موقعك الحالي',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F3B4F),
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'القاهرة - مصر',
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF1A2C3E).withOpacity(0.6),
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
