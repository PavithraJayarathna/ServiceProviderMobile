import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';
import '../widgets/custom_button.dart';
import '../widgets/invoice_card.dart';
import '../Billing & Payments/billing_setting_screen.dart';
import '../Billing & Payments/generate_invoice_screen.dart';
import '../Billing & Payments/invoices_list_screen.dart'; // connected screen

class BillingPaymentScreen extends StatefulWidget {
  const BillingPaymentScreen({super.key});

  @override
  State<BillingPaymentScreen> createState() => _BillingPaymentScreenState();
}

class _BillingPaymentScreenState extends State<BillingPaymentScreen> {
  // 🧾 Dynamic invoice list
  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV - 001",
      "date": "2025-01-01",
      "pet": "Max",
      "owner": "John Smith",
      "service": "General Checkup",
      "payment": "Credit Card",
      "amount": "75.00",
      "tax": "5.00",
      "total": "80.00",
      "isPaid": false,
    },
    {
      "id": "INV - 002",
      "date": "2025-01-01",
      "pet": "Bella",
      "owner": "Jane Doe",
      "service": "Vaccination",
      "payment": "Cash",
      "amount": "50.00",
      "tax": "5.00",
      "total": "55.00",
      "isPaid": true,
    },
  ];

  // 🟢 Count paid invoices
  String get invoicesPaidCount =>
      invoices.where((i) => i["isPaid"] == true).length.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(
        title: "Billing & Payments",
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSection(context),
            const SizedBox(height: 24),
            _invoiceSettingTabs(context),
            const SizedBox(height: 24),
            _recentInvoiceSection(context),
          ],
        ),
      ),
    );
  }

  // 🔸 Header Section
  Widget _headerSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Billing & Payments",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 160,
              child: CustomButton(
                text: "Generate Invoice",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateInvoiceScreen(),
                    ),
                  );
                },
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Manage invoices, payments and billing settings",
          style: TextStyle(
            color: AppColors.textMedium,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Expanded(
              child: _StatCard(
                title: "Total Revenue",
                value: "50K LKR",
                subtitle: "This month",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: "Paid Invoices",
                value: "", // temporarily empty, filled below
                subtitle: "Out of Total",
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 🔸 Tabs for Invoice / Settings
  Widget _invoiceSettingTabs(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: "Invoices",
            onPressed: () {},
            backgroundColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            text: "Setting",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            isPrimary: false,
          ),
        ),
      ],
    );
  }

  // 🔸 Recent Invoices
  Widget _recentInvoiceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Invoices",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () async {
                // 🟢 Navigate and await updated list
                final updatedList = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoicesListScreen(
                      invoices: invoices,
                    ),
                  ),
                );

                // 🟢 If user marks paid → update
                if (updatedList != null && mounted) {
                  setState(() {
                    invoices = List<Map<String, dynamic>>.from(updatedList);
                  });
                }
              },
              child: const Text(
                "View All",
                style: TextStyle(
                  color: AppColors.textMedium,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 🟣 Show 2 most recent invoices
        for (var invoice in invoices.take(2))
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InvoiceCard(
              invoiceId: invoice["id"],
              date: invoice["date"],
              petName: invoice["pet"],
              ownerName: invoice["owner"],
              service: invoice["service"],
              payment: invoice["payment"],
              amount: invoice["amount"],
              tax: invoice["tax"],
              total: invoice["total"],
              isPaid: invoice["isPaid"],
            ),
          ),
      ],
    );
  }
}

// ===============================
// 🟡 STAT CARD WIDGET
// ===============================
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.bg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(color: AppColors.textMedium, fontSize: 14)),
          const SizedBox(height: 8),
          Text(value.isEmpty ? "-" : value,
              style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle,
              style:
                  const TextStyle(color: AppColors.textMedium, fontSize: 12)),
        ],
      ),
    );
  }
}
