import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';
import '../widgets/invoice_card.dart';

class InvoicesListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> invoices;

  const InvoicesListScreen({super.key, required this.invoices});

  @override
  State<InvoicesListScreen> createState() => _InvoicesListScreenState();
}

class _InvoicesListScreenState extends State<InvoicesListScreen> {
  late List<Map<String, dynamic>> allInvoices;
  String selectedFilter = "All";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    allInvoices = List<Map<String, dynamic>>.from(widget.invoices);
  }

  // 🔹 Filtered list
  List<Map<String, dynamic>> get filteredInvoices {
    List<Map<String, dynamic>> list = allInvoices;

    if (selectedFilter == "Paid") {
      list = list.where((i) => i["isPaid"] == true).toList();
    } else if (selectedFilter == "Unpaid") {
      list = list.where((i) => i["isPaid"] == false).toList();
    }

    if (searchQuery.isNotEmpty) {
      list = list
          .where((i) =>
              i["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
              i["owner"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
              i["pet"].toString().toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: TopBar(
        title: "Invoices",
        automaticallyImplyLeading: true,
        onBack: () {
          Navigator.pop(context, allInvoices);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            const SizedBox(height: 16),
            _filterTabs(),
            const SizedBox(height: 16),
            _invoiceList(),
          ],
        ),
      ),
    );
  }

  // 🔍 Search bar
  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Quick Search",
        prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.textLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.textLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      onChanged: (value) {
        setState(() => searchQuery = value);
      },
    );
  }

  // 🟠 Filter Tabs
  Widget _filterTabs() {
    final filters = ["All", "Paid", "Unpaid"];

    return Row(
      children: filters.map((label) {
        final isSelected = selectedFilter == label;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              onPressed: () => setState(() => selectedFilter = label),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isSelected ? AppColors.primary : Colors.transparent,
                foregroundColor:
                    isSelected ? Colors.white : AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        );
      }).toList(),
    );
  }

  // 📜 Invoice list
  Widget _invoiceList() {
    if (filteredInvoices.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            "No invoices found.",
            style: TextStyle(color: AppColors.textMedium, fontSize: 14),
          ),
        ),
      );
    }

    return Column(
      children: filteredInvoices.map((invoice) {
        return Padding(
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
            onMarkPaid: () {
              setState(() {
                invoice["isPaid"] = true;
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
