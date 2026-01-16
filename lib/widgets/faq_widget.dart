import 'package:flutter/material.dart';

// class FAQs {
//   final String? title;
//   final String? description;

//   FAQs({this.title = "FAQ's", this.description});
// }

/// Model for FAQ Item
class FAQItem {
  final String id;
  final String question;
  final String answer;

  FAQItem({required this.id, required this.question, required this.answer});
}

/// FAQ Widget with Expandable Items
class FAQWidget extends StatefulWidget {
  final List<FAQItem> faqs;
  final String? title;

  const FAQWidget({super.key, required this.faqs, this.title});

  @override
  State<FAQWidget> createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  late Map<String, bool> _expandedState;

  @override
  void initState() {
    super.initState();
    // Initialize all items as collapsed
    _expandedState = {for (var faq in widget.faqs) faq.id: false};
  }

  void _toggleExpanded(String id) {
    setState(() {
      _expandedState[id] = !_expandedState[id]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FAQ Title (Only if provided from parent)
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        // FAQ Items List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.faqs.length,
          itemBuilder: (context, index) {
            final faq = widget.faqs[index];
            final isExpanded = _expandedState[faq.id] ?? false;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Question Section (Always Visible)
                  GestureDetector(
                    onTap: () => _toggleExpanded(faq.id),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              faq.question,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Expand/Collapse Icon
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Icon(
                                isExpanded ? Icons.remove : Icons.add,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Answer Section (Visible when Expanded)
                  if (isExpanded)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        faq.answer,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
