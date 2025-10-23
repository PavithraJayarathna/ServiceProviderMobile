import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'custom_button.dart';

class InvoiceCard extends StatelessWidget {
  final String invoiceId;
  final String date;
  final String petName;
  final String ownerName;
  final String service;
  final String payment;
  final String amount;
  final String tax;
  final String total;
  final bool isPaid;
  final VoidCallback? onMarkPaid;

  const InvoiceCard({
    super.key,
    required this.invoiceId,
    required this.date,
    required this.petName,
    required this.ownerName,
    required this.service,
    required this.payment,
    required this.amount,
    required this.tax,
    required this.total,
    required this.isPaid,
    this.onMarkPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                invoiceId,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPaid ? AppColors.success : AppColors.danger,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isPaid ? "Paid" : "Unpaid",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(date, style: const TextStyle(color: AppColors.textMedium)),
          const SizedBox(height: 12),

          _infoRow("Pet", petName),
          _infoRow("Owner", ownerName),
          _infoRow("Service", service),
          _infoRow("Payment", payment),
          const Divider(),
          _infoRow("Amount", "\$$amount"),
          _infoRow("Tax", "\$$tax"),
          _infoRow("Total", "\$$total"),

          const SizedBox(height: 12),
          Row(
            children: [
              if (!isPaid)
                Expanded(
                  child: CustomButton(
                    text: "Mark Paid",
                    onPressed: onMarkPaid ?? () {},
                    backgroundColor: AppColors.success,
                    textColor: Colors.black,
                  ),
                ),
              if (!isPaid) const SizedBox(width: 8),
              Expanded(
  child: CustomButton(
    text: "PDF",
    icon: Icons.download, 
    onPressed: () {
      // PDF download logic එක මෙතන
    },
    isPrimary: false,
  ),
),

              const SizedBox(width: 8),
              Expanded(
                child: CustomButton(
                  text: "Share",
                  onPressed: () {},
                  isPrimary: false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textMedium)),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
