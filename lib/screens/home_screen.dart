import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_state.dart';
import '../widgets/header_widget.dart';
import '../widgets/sos_button.dart';
import '../widgets/services_grid.dart';
import '../widgets/map_widget.dart';
import '../widgets/tracking_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 14),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0xFF1E2F3A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _requestAssistance() {
    final appState = context.read<AppState>();
    if (appState.requestActive) {
      _showToast('⚠️ يوجد طلب قيد التنفيذ بالفعل');
      return;
    }
    appState.setRequestActive(true);
    _showToast('📢 تم إرسال طلب ${appState.selectedService} إلى أقرب فني...');
    
    Future.delayed(const Duration(seconds: 1), () {
      if (appState.requestActive) {
        appState.assignTechnician();
        _showToast('👨‍🔧 تم تحديد الفني: ${appState.technicianName}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppState>(
        builder: (context, appState, _) => Column(
          children: [
            const HeaderWidget(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SOSButton(),
                      const SizedBox(height: 24),
                      _buildSectionTitle('اختر نوع المساعدة', Icons.tools),
                      const SizedBox(height: 12),
                      const ServicesGrid(),
                      const SizedBox(height: 24),
                      _buildSectionTitle('موقعك الحالي', Icons.location_on),
                      const SizedBox(height: 12),
                      const MapWidget(),
                      const SizedBox(height: 20),
                      _buildRequestButton(),
                      const SizedBox(height: 12),
                      if (appState.requestActive) const TrackingPanel(),
                      const SizedBox(height: 16),
                      _buildSectionTitle('آخر طلب سابق', Icons.history),
                      const SizedBox(height: 12),
                      _buildLastRequest(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0F3B4F), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A2C3E),
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildRequestButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _requestAssistance,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE67E22),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          elevation: 8,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.car, color: Colors.white, size: 18),
            SizedBox(width: 12),
            Text(
              'اطلب مساعدة الآن',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastRequest() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0F3F8)),
      ),
      child: const Row(
        children: [
          FaIcon(FontAwesomeIcons.wrench, color: Color(0xFF0F3B4F), size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'بطارية | 120 ج.م | الأحد 10:30 | تقييم 5 نجوم',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Cairo',
                color: Color(0xFF1A2C3E),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
