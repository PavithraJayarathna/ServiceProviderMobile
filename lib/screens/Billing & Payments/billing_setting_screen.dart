import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const route = "/settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _feeController = TextEditingController(text: "75");
  final _taxController = TextEditingController(text: "6");
  final _discountController = TextEditingController(text: "75");

  bool creditCard = true;
  bool cashPayment = true;
  bool bankTransfer = false;
  bool digitalWallets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(
        title: "Settings",
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fee Setting Section
            Text(
              "Fee Setting",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomTextField(
                    label: "Default Consultation Fees (\$)",
                    keyboardType: TextInputType.number,
                    controller: _feeController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Tax Rate (%)",
                    keyboardType: TextInputType.number,
                    controller: _taxController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Default Discount (%)",
                    keyboardType: TextInputType.number,
                    controller: _discountController,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Save Setting",
                    onPressed: () {},
                    isPrimary: true,
                    backgroundColor: AppColors.primary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Payment Methods Section
            Text(
              "Payment Methods",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildPaymentTile(
                    icon: Icons.credit_card,
                    title: "Credit/Debit Cards",
                    value: creditCard,
                    onChanged: (val) => setState(() => creditCard = val),
                  ),
                  _buildPaymentTile(
                    icon: Icons.payments,
                    title: "Cash Payment",
                    value: cashPayment,
                    onChanged: (val) => setState(() => cashPayment = val),
                  ),
                  _buildPaymentTile(
                    icon: Icons.account_balance,
                    title: "Bank Transfer",
                    value: bankTransfer,
                    onChanged: (val) => setState(() => bankTransfer = val),
                  ),
                  _buildPaymentTile(
                    icon: Icons.wallet_giftcard,
                    title: "Digital Wallets",
                    value: digitalWallets,
                    onChanged: (val) => setState(() => digitalWallets = val),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: "Update Payment Methods",
                    onPressed: () {},
                    isPrimary: false,
                    backgroundColor: AppColors.bg,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textDark),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textDark,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
