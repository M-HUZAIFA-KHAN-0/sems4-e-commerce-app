import 'package:first/core/app_imports.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  // Sample FAQ Data - Can be fetched from API or passed from parent
  late List<FAQItem> _faqs;

  @override
  void initState() {
    super.initState();
    _initializeFAQs();
  }

  void _initializeFAQs() {
    _faqs = [
      FAQItem(
        id: '1',
        question: 'What is UI/UX Design?',
        answer:
            'UI/UX Design is the process of creating user-friendly interfaces and experiences for digital products. UI (User Interface) focuses on the visual design and layout, while UX (User Experience) focuses on how the product feels and functions to users.',
      ),
      FAQItem(
        id: '2',
        question: 'Why is accessibility important in UI/UX?',
        answer:
            'Accessibility is important because it ensures that all users, including those with disabilities, can access and use digital products effectively. This includes people with visual, hearing, motor, and cognitive impairments.',
      ),
      FAQItem(
        id: '3',
        question: 'What\'s difference wireframing and prototyping?',
        answer:
            'Wireframing is a low-fidelity representation of a product\'s layout and structure, showing the basic elements and their placement. Prototyping is a high-fidelity, interactive representation that simulates how the product will actually work and feel to users.',
      ),
      FAQItem(
        id: '4',
        question: 'Should I learn UI/UX Design?',
        answer:
            'Yes, learning UI/UX Design is valuable if you\'re interested in creating user-centered digital products. It\'s a rewarding career path that combines creativity with problem-solving and requires understanding of user behavior and psychology.',
      ),
      FAQItem(
        id: '5',
        question: 'How do you conduct user research?',
        answer:
            'We employ various methods like user interviews, surveys, usability testing, observing user goals, behaviors, research, focus groups, and heatmap studies. These methods help us understand user needs and pain points to inform design decisions.',
      ),
      FAQItem(
        id: '6',
        question: 'Is there a trial available?',
        answer:
            'Yes, we offer a free trial period so you can explore our services and see if they meet your needs. You can sign up on our website to start your trial without requiring a credit card.',
      ),
      FAQItem(
        id: '7',
        question: 'How do I get started?',
        answer:
            'Getting started is simple! Sign up for an account on our website, complete your profile, and follow the onboarding guide. Our support team is always available to help you with any questions during the setup process.',
      ),
      FAQItem(
        id: '8',
        question: 'If I need any help, where can I find it?',
        answer:
            'You can find help through multiple channels: our comprehensive help documentation, email support, live chat support, or community forum. We typically respond to inquiries within 24 hours.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textBlack87,
            size: 20,
          ),
        ),
        title: const Text(
          'FAQs',
          style: TextStyle(
            color: AppColors.textBlack87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(child: FAQWidget(faqs: _faqs)),
    );
  }
}
