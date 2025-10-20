import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';
import '../widgets/custom_button.dart';
import '../appointments/appointment_details_screen.dart';
import '../appointments/appointment_past_details_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  static const route = "/appointments";

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(title: "Appointments"),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
    controller: _tabController,
    isScrollable: false, // 👈 ත්‍රිත්ව width එකක් (equal size)
    indicatorSize: TabBarIndicatorSize.tab, // 👈 indicator එකත් tab එකට match වෙනවා
    indicator: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(12),
    ),
               indicatorColor: Colors.transparent, // 👈 මේකෙන් underline එක අතුරුදන් වෙනවා
    dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.primary,
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              tabs: const [
                Tab(text: "Requests"),
                Tab(text: "Upcoming"),
                Tab(text: "Past"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAppointmentList(context, showActions: true),
                _buildAppointmentList(context),
                _buildAppointmentList(context, isPast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentList(BuildContext context,
      {bool showActions = false, bool isPast = false}) {
    return Column(
      children: [
        if (isPast)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                 color: AppColors.bg, 
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          hintText: "Search past appointments...",
          hintStyle: const TextStyle(color: AppColors.textLight),
          filled: true,
          fillColor: AppColors.bg, // 👈 background color එක
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildAppointmentCard(context, showActions, isPast);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(
      BuildContext context, bool showActions, bool isPast) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.pets, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Buddy",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: AppColors.primary),
                  ),
                  Text("Annual Checkup",
                      style: TextStyle(color: AppColors.primary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "👩 Sarah Johnson\n📞 077-0000000\n🕙 10:00AM - 10:30AM\n📍 Happy Paws Veterinary Clinic, Colombo",
            style: TextStyle(color: AppColors.primary, height: 1.8),
          ),
          const SizedBox(height: 8),
          const Text(
            "Sudden limping after a walk. Seems to be favoring his left front paw.",
            style: TextStyle(color: AppColors.primary, height: 1.8),
          ),
          const SizedBox(height: 12),
          if (showActions)
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Accept",
                    onPressed: () {},
                    isPrimary: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomButton(
                    text: "Decline",
                    onPressed: () {},
                    isPrimary: false,
                  ),
                ),
              ],
            )
          else
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                text: "View Details",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => isPast
                          ? const AppointmentPastDetailsScreen()
                          : const AppointmentDetailsScreen(),
                    ),
                  );
                },
                isPrimary: false,
                backgroundColor: AppColors.primaryLight,
              ),
            ),
        ],
      ),
    );
  }
}
