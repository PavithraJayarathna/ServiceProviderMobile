import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> notifications = [
    {
      'icon': 'notifications',
      'title': 'New Booking Alert',
      'time': 'Today | 09:24 AM',
      'description':
          'Pet owner Sarah booked an appointment for grooming on Oct 26, 2025.',
      'isNew': 'true',
    },
    {
      'icon': 'event',
      'title': 'Appointment Reminder',
      'time': 'Today | 14:43 PM',
      'description': 'Your consultation with Max for check-up in 1 hour.',
      'isNew': 'true',
    },
    {
      'icon': 'warning',
      'title': 'Emergency Booking Request',
      'time': '2 days ago | 10:29 AM',
      'description':
          'Urgent consultation requested for Luna due to sudden illness.',
      'isNew': 'false',
    },
    {
      'icon': 'account_balance',
      'title': 'Bank Account Connected!',
      'time': '5 days ago | 16:52 PM',
      'description':
          'You have linked your account with a local bank. You can withdraw whenever you want.',
      'isNew': 'false',
    },
    {
      'icon': 'alarm',
      'title': 'You Have New Reminder',
      'time': '6 days ago | 15:38 PM',
      'description':
          'Your credit card has been successfully linked with Coino. Enjoy our services.',
      'isNew': 'false',
    },
  ];

  List<Map<String, String>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = notifications;
    _searchController.addListener(_filterNotifications);
  }

  void _filterNotifications() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredList = notifications.where((item) {
        final title = item['title']!.toLowerCase();
        final desc = item['description']!.toLowerCase();
        return title.contains(query) || desc.contains(query);
      }).toList();
    });
  }

  void _markAsRead(int index) {
    setState(() {
      filteredList[index]['isNew'] = 'false';
      // Also update main list to keep sync
      final mainIndex = notifications.indexWhere(
          (n) => n['title'] == filteredList[index]['title']);
      if (mainIndex != -1) notifications[mainIndex]['isNew'] = 'false';
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(title: "Notifications"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔎 Search Bar
            TextField(
              controller: _searchController,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: "Search by title or type",
                hintStyle: const TextStyle(color: AppColors.textLight),
                filled: true,
                fillColor: AppColors.primaryLight,
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            // 🔔 Filtered Notification List
            Expanded(
              child: filteredList.isEmpty
                  ? const Center(
                      child: Text(
                        "No notifications found.",
                        style: TextStyle(color: AppColors.textMedium),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.bg,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.secondary
                                            .withOpacity(0.4),
                                        child: Icon(
                                          _getIconData(item['icon']!),
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item['title']!,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                ),
                                                if (item['isNew'] == 'true')
                                                  GestureDetector(
                                                    onTap: () =>
                                                        _markAsRead(index),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .secondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: const Text(
                                                        "New",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              item['time']!,
                                              style: const TextStyle(
                                                color: AppColors.secondary,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    item['description']!,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != filteredList.length - 1)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 1,
                                color: AppColors.primary,
                              ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'notifications':
        return Icons.notifications_active;
      case 'event':
        return Icons.event;
      case 'warning':
        return Icons.warning_amber_rounded;
      case 'account_balance':
        return Icons.account_balance_wallet;
      case 'alarm':
        return Icons.alarm;
      default:
        return Icons.notifications;
    }
  }
}
