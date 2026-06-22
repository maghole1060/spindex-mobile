import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_state.dart';

class TrackingPanel extends StatefulWidget {
  const TrackingPanel({Key? key}) : super(key: key);

  @override
  State<TrackingPanel> createState() => _TrackingPanelState();
}

class _TrackingPanelState extends State<TrackingPanel> {
  int _selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();

  void _submitRating(AppState appState) {
    if (_selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار تقييم بالنجوم', style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Color(0xFFE74C3C),
        ),
      );
      return;
    }
    appState.completeRequest();
    _selectedRating = 0;
    _commentController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '⭐ شكراً لتقييمك $_selectedRating نجوم',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: const Color(0xFF2ECC71),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: const Color(0xFFEEF2F8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F3B4F),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.userTie,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الفني: ${appState.technicianName}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      Text(
                        '⏱️ وقت الوصول: ${appState.eta} دقائق',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE67E22),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(
              color: Colors.grey.shade200,
              thickness: 1,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('📞 جار الاتصال بالفني...', style: TextStyle(fontFamily: 'Cairo')),
                          backgroundColor: Color(0xFF2ECC71),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    icon: const FaIcon(FontAwesomeIcons.phone, size: 16, color: Colors.white),
                    label: const Text(
                      'مكالمة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('💬 تم فتح الدردشة', style: TextStyle(fontFamily: 'Cairo')),
                          backgroundColor: Color(0xFF3498DB),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3498DB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    icon: const FaIcon(FontAwesomeIcons.comments, size: 16, color: Colors.white),
                    label: const Text(
                      'دردشة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF5E8),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '💰 السعر المقدر:',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    appState.servicePrices[appState.selectedService] ?? '120 ج.م',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE67E22),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'طرق الدفع',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPaymentOption('cash', '💵 كاش', appState),
                  const SizedBox(width: 10),
                  _buildPaymentOption('vodafone', '📱 فودافون كاش', appState),
                  const SizedBox(width: 10),
                  _buildPaymentOption('card', '💳 كارت', appState),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'تقييم الخدمة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () => setState(() => _selectedRating = i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FaIcon(
                        _selectedRating >= i ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                        color: const Color(0xFFFFB347),
                        size: 24,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'رأيك يساعدنا لتحسين الجودة...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Cairo',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color(0xFFDDD)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color(0xFF0F3B4F), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _submitRating(appState),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F3B4F),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                ),
                child: const Text(
                  'إرسال التقييم',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String payType, String label, AppState appState) {
    final isSelected = appState.selectedPayment == payType;
    return GestureDetector(
      onTap: () => appState.setPayment(payType),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F3B4F) : const Color(0xFFEEF2FA),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F3B4F) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF0F3B4F),
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}
