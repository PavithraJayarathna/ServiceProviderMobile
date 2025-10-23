import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ServiceItem {
  final String type;
  final double amount;
  final double tax;
  final double discount;

  ServiceItem({
    required this.type,
    required this.amount,
    required this.tax,
    required this.discount,
  });
}

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  static const route = "/create_invoice";

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final invoiceNoController = TextEditingController(text: "INV - 005");
  final invoiceDateController = TextEditingController(text: "01/15/1990");
  final dueDateController = TextEditingController(text: "01/20/1990");
  final clientNameController = TextEditingController();
  final petNameController = TextEditingController();

  List<ServiceItem> services = [];
  double totalAmount = 0.0;

  void _calculateTotal() {
    double total = 0.0;
    for (var s in services) {
      double afterDiscount = s.amount - (s.amount * s.discount / 100);
      double afterTax = afterDiscount + (afterDiscount * s.tax / 100);
      total += afterTax;
    }
    setState(() {
      totalAmount = total;
    });
  }

  void _showAddServiceDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultFee = prefs.getString('default_fee') ?? "0";
    final defaultTax = prefs.getString('default_tax') ?? "0";
    final defaultDiscount = prefs.getString('default_discount') ?? "0";

    final typeController = TextEditingController();
    final amountController = TextEditingController(text: defaultFee);
    final taxController = TextEditingController(text: defaultTax);
    final discountController = TextEditingController(text: defaultDiscount);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Service"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(label: "Service Type", controller: typeController),
            const SizedBox(height: 8),
            CustomTextField(
              label: "Amount (\$)",
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: "Tax (%)",
              controller: taxController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: "Discount (%)",
              controller: discountController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final type = typeController.text.trim();
              final amount = double.tryParse(amountController.text) ?? 0;
              final tax = double.tryParse(taxController.text) ?? 0;
              final discount = double.tryParse(discountController.text) ?? 0;

              if (type.isEmpty || amount <= 0) return;

              setState(() {
                services.add(ServiceItem(
                  type: type,
                  amount: amount,
                  tax: tax,
                  discount: discount,
                ));
              });
              _calculateTotal();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(
        title: "Create Invoice",
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔶 Title
            Text(
              "Create Invoice",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),

            // ============================
            // Invoice Details Section
            // ============================
            _buildSectionCard(
              title: "Invoice details",
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Invoice Number",
                        controller: invoiceNoController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        label: "Invoice Date",
                        controller: invoiceDateController,
                        prefixIcon: Icons.calendar_today,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: "Due Date",
                  controller: dueDateController,
                  prefixIcon: Icons.calendar_today,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: "Client Name",
                  controller: clientNameController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: "Pet Name",
                  controller: petNameController,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ============================
            // Service Details Section
            // ============================
            _buildSectionCard(
              title: "Service Details",
              actionButton: TextButton(
                onPressed: _showAddServiceDialog,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "+ Add Service",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              children: [
                // 🔹 Added Services List
                if (services.isEmpty)
                  const Text("No services added yet.",
                      style: TextStyle(color: AppColors.textLight))
                else
                  Column(
                    children: services.map((s) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s.type,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(
                                      "Amount: \$${s.amount.toStringAsFixed(2)} | Tax: ${s.tax}% | Discount: ${s.discount}%"),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  services.remove(s);
                                });
                                _calculateTotal();
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 20),
                // 🔹 Total Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        "\$ ${totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ============================
            // Bottom Buttons
            // ============================
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Generate Invoice",
                    onPressed: () {},
                    isPrimary: true,
                    backgroundColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    onPressed: () => Navigator.pop(context),
                    isPrimary: false,
                    backgroundColor: AppColors.bg,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🧩 Helper for reusable card sections
  Widget _buildSectionCard({
    required String title,
    Widget? actionButton,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (actionButton != null) actionButton,
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
