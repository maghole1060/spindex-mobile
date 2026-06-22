import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SOSButton extends StatefulWidget {
  const SOSButton({Key? key}) : super(key: key);

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _triggerSOS() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          '🚨 إشارة SOS',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: const Text(
          'تم إرسال إشارة الطوارئ! سيتم الاتصال بالإسعاف والمرور خلال ثوان.',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _triggerSOS,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE74C3C),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            elevation: 8,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.exclamationTriangle, color: Colors.white, size: 18),
              SizedBox(width: 12),
              Text(
                'زر طوارئ SOS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(width: 12),
              FaIcon(FontAwesomeIcons.phone, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
