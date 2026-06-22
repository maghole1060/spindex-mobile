import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_state.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final services = [
      {'name': 'بطارية', 'icon': FontAwesomeIcons.carBattery},
      {'name': 'بنزين', 'icon': FontAwesomeIcons.gasPump},
      {'name': 'كاوتش', 'icon': FontAwesomeIcons.tireFlat},
      {'name': 'سحب', 'icon': FontAwesomeIcons.truck},
      {'name': 'فتح', 'icon': FontAwesomeIcons.car},
      {'name': 'شحن', 'icon': FontAwesomeIcons.bolt},
    ];

    return Consumer<AppState>(
      builder: (context, appState, _) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          final isSelected = appState.selectedService == service['name'];

          return GestureDetector(
            onTap: () {
              appState.selectService(service['name'] as String);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '✓ تم اختيار: ${service['name']} - ${appState.servicePrices[service['name']]}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'Cairo'),
                  ),
                  duration: const Duration(seconds: 2),
                  backgroundColor: const Color(0xFF0F3B4F),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0F3B4F) : const Color(0xFFF9FAFC),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isSelected ? const Color(0xFF0F3B4F) : const Color(0xFFEEF2F8),
                  width: 2,
                ),
                boxShadow: isSelected
                    ? [
                        const BoxShadow(
                          color: Color.fromARGB(30, 15, 59, 79),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    service['icon'] as IconData,
                    color: isSelected ? Colors.white : const Color(0xFF0F3B4F),
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service['name'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF1A2C3E),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
