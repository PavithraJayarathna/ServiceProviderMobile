import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';
import '../widgets/invoice_card.dart';

// ===============================
// 🧾 Invoice Model
// ===============================
class Invoice {
  final String id;
  final String date;
  final String pet;
  final String owner;
  final String service;
  final String payment;
  final String amount;
  final String tax;
  final String total;
  bool isPaid; // ✅ mutable now

  Invoice({
    required this.id,
    required this.date,
    required this.pet,
    required this.owner,
    required this.service,
    required this.payment,
    required this.amount,
    required this.tax,
    required this.total,
    required this.isPaid,
  });

  // 🟢 Factory constructor (for converting Map → Invoice)
  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map["id"] ?? "",
      date: map["date"] ?? "",
      pet: map["pet"] ?? "",
      owner: map["owner"] ?? "",
      service: map["service"] ?? "",
      payment: map["payment"] ?? "",
      amount: map["amount"] ?? "0",
      tax: map["tax"] ?? "0",
      total: map["total"] ?? "0",
      isPaid: map["isPaid"] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "pet": pet,
        "owner": owner,
        "service": service,
        "payment": payment,
        "amount": amount,
        "tax": tax,
        "total": total,
        "isPaid": isPaid,
      };
}

// ===============================
// 🧮 MAIN SCREEN
// ===============================
class InvoicesListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> invoices; // ✅ receives from BillingPaymentScreen

  const InvoicesListScreen({super.key, required this.invoices});

  static const route = "/invoices_list";

  @override
  State<InvoicesListScreen> createState() => _InvoicesListScreenState();
}

class _InvoicesListScreenState extends State<InvoicesListScreen> {
  String _selectedFilter = "All";
  late List<Invoice> _invoices;

  @override
  void initState() {
    super.initState();
    // convert map list → Invoice list
    _invoices = widget.invoices.map((e) => Invoice.fromMap(e)).toList();
  }

  List<Invoice> get _filteredInvoices {
    if (_selectedFilter == "All") return _invoices;
    if (_selectedFilter == "Paid") {
      return _invoices.where((i) => i.isPaid).toList();
    }
    return _invoices.where((i) => !i.isPaid).toList();
  }

  // 🔹 Mark as paid
  void _markAsPaid(String id) {
    setState(() {
      final index = _invoices.indexWhere((inv) => inv.id == id);
      if (index != -1) {
        _invoices[index].isPaid = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: TopBar(
        title: "Invoices",
        automaticallyImplyLeading: true,
        onBack: () {
          // 🟢 When user goes back, return updated invoices to BillingPaymentScreen
          Navigator.pop(context, _invoices.map((e) => e.toMap()).toList());
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

  // 🔍 Search Bar
  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Quick Search",
        prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
        setState(() {
          // optional search filter
        });
      },
    );
  }

  // 🟠 Filter Tabs
  Widget _filterTabs() {
    return Row(
      children: [
        _filterButton("All"),
        _filterButton("Paid"),
        _filterButton("Unpaid"),
      ],
    );
  }

  Widget _filterButton(String label) {
    final bool isSelected = _selectedFilter == label;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () {
            setState(() => _selectedFilter = label);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isSelected ? AppColors.primary : Colors.transparent,
            foregroundColor: isSelected ? Colors.white : AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child:
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  // 📜 Invoice List
  Widget _invoiceList() {
    if (_filteredInvoices.isEmpty) {
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
      children: _filteredInvoices
          .map(
            (invoice) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InvoiceCard(
                invoiceId: invoice.id,
                date: invoice.date,
                petName: invoice.pet,
                ownerName: invoice.owner,
                service: invoice.service,
                payment: invoice.payment,
                amount: invoice.amount,
                tax: invoice.tax,
                total: invoice.total,
                isPaid: invoice.isPaid,
                onMarkPaid: () {
                  _markAsPaid(invoice.id);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
