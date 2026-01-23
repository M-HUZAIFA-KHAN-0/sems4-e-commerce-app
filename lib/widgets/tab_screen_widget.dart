import 'package:first/core/app_imports.dart';

typedef TabItem = ({String label, Widget content});

class TabScreenWidget extends StatefulWidget {
  final List<TabItem> tabs;
  final Color selectedTabColor;
  final Color unselectedTabColor;
  final Widget Function()? emptyStateBuilder;
  final double tabHeight;
  final TextStyle? selectedTabStyle;
  final TextStyle? unselectedTabStyle;

  const TabScreenWidget({
    super.key,
    required this.tabs,
    this.selectedTabColor = AppColors.primaryBlue,
    this.unselectedTabColor = AppColors.formGrey,
    this.emptyStateBuilder,
    this.tabHeight = 48,
    this.selectedTabStyle,
    this.unselectedTabStyle,
  });

  @override
  State<TabScreenWidget> createState() => _TabScreenWidgetState();
}

class _TabScreenWidgetState extends State<TabScreenWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.backgroundWhite,
          height: widget.tabHeight,
          child: TabBar(
            controller: _tabController,
            tabs: [for (final tab in widget.tabs) Tab(text: tab.label)],
            labelColor: widget.selectedTabColor,
            unselectedLabelColor: widget.unselectedTabColor,
            labelStyle: widget.selectedTabStyle,
            unselectedLabelStyle: widget.unselectedTabStyle,
            indicatorColor: widget.selectedTabColor,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [for (final tab in widget.tabs) tab.content],
          ),
        ),
      ],
    );
  }
}
