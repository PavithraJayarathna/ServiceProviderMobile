import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';
import '../widgets/custom_button.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  // Search Controller
  final TextEditingController _searchController = TextEditingController();

  // Original reviews list
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "Sarah",
      "date": "April 5 | 14:43 PM",
      "rating": 5,
      "review":
          "Dr. Emily was incredibly gentle and knowledgeable with Buster during his annual check-up. He usually gets anxious at the vet, but she made him feel so comfortable.",
      "reply":
          "Thank you, Sarah for your kind words! We are delighted to hear Buster had a positive experience. His comfort is always our top priority.",
      "liked": false,
    },
    {
      "name": "David",
      "date": "April 6 | 09:12 AM",
      "rating": 4,
      "review":
          "Great service! The doctor was kind and attentive. Waiting time could be improved a bit, though.",
      "liked": false,
    },
    {
      "name": "Alice",
      "date": "April 7 | 11:20 AM",
      "rating": 5,
      "review":
          "Excellent experience! The staff was friendly and professional.",
      "liked": false,
    },
  ];

  // Filtered reviews for search
  List<Map<String, dynamic>> filteredReviews = [];

  @override
  void initState() {
    super.initState();
    _updateFilteredReviews();

    // Listen to search changes
    _searchController.addListener(_updateFilteredReviews);
  }

  void _updateFilteredReviews() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredReviews = reviews
          .where((review) =>
              review["name"].toLowerCase().contains(query) ||
              review["review"].toLowerCase().contains(query))
          .toList()
        ..sort((a, b) {
          // Reply නොකරපු review top
          if (a["reply"] == null && b["reply"] != null) return -1;
          if (a["reply"] != null && b["reply"] == null) return 1;
          return 0;
        });
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
      appBar: const TopBar(title: "Review & Ratings"),
      body: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 8),
          Expanded(
            child: filteredReviews.isEmpty
                ? const Center(
                    child: Text(
                      "No reviews found.",
                      style: TextStyle(color: AppColors.textDark, fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredReviews.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final r = filteredReviews[index];
                      return _buildReviewCard(
                        name: r["name"],
                        date: r["date"],
                        rating: r["rating"],
                        review: r["review"],
                        reply: r["reply"],
                        liked: r["liked"] ?? false,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
          controller: _searchController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            hintText: "Search reviews...",
            hintStyle: const TextStyle(color: AppColors.textLight),
            filled: true,
            fillColor: AppColors.bg,
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
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required String name,
    required String date,
    required int rating,
    required String review,
    String? reply,
    bool liked = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.secondary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  rating,
                  (index) =>
                      const Icon(Icons.star, color: AppColors.primary, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            review,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 14,
            ),
          ),
          if (reply != null) ...[
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                text: "Your Reply: ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primary,
                  fontSize: 14,
                  height: 1.8,
                ),
                children: [
                  TextSpan(
                    text: reply,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.borderTransparent,
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Edit Reply",
                    onPressed: () {
                      _showReplyDialog(name, isEdit: true);
                    },
                    isPrimary: false,
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: Icon(
                    liked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      final index =
                          filteredReviews.indexWhere((r) => r["name"] == name);
                      if (index != -1) filteredReviews[index]["liked"] = !liked;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    liked ? Icons.thumb_down_outlined : Icons.thumb_down,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      final index =
                          filteredReviews.indexWhere((r) => r["name"] == name);
                      if (index != -1) filteredReviews[index]["liked"] = false;
                    });
                  },
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 12),
            CustomButton(
              text: "Reply to Review",
              onPressed: () {
                _showReplyDialog(name);
              },
              isPrimary: true,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_outlined),
                  color: AppColors.primary,
                  onPressed: () {
                    setState(() {
                      final index =
                          filteredReviews.indexWhere((r) => r["name"] == name);
                      if (index != -1) filteredReviews[index]["liked"] = true;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.thumb_down),
                  color: AppColors.primary,
                  onPressed: () {
                    setState(() {
                      final index =
                          filteredReviews.indexWhere((r) => r["name"] == name);
                      if (index != -1) filteredReviews[index]["liked"] = false;
                    });
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showReplyDialog(String reviewerName, {bool isEdit = false}) {
    final TextEditingController _replyController = TextEditingController();
    if (isEdit) {
      final index = filteredReviews.indexWhere((r) => r["name"] == reviewerName);
      if (index != -1) {
        _replyController.text = filteredReviews[index]["reply"] ?? "";
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              isEdit ? "Edit Reply to $reviewerName" : "Reply to $reviewerName"),
          content: TextField(
            controller: _replyController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: "Type your reply here...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final index =
                      filteredReviews.indexWhere((r) => r["name"] == reviewerName);
                  if (index != -1) {
                    filteredReviews[index]["reply"] = _replyController.text;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
