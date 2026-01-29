import 'package:first/core/app_imports.dart';

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key});

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),

            /// LEFT PROFILE
            // Row(
            //   children: [
            SizedBox(
              height: 50,
              width: 200, // max width
              child: Image.asset(
                '../../assets/branding/png-nav-logo.png',
                fit: BoxFit.contain,
              ),
            ),
            //   ],
            // ),

            /// RIGHT ACTIONS
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),

            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  void _openDrawerSlowly(BuildContext context) {
    // Add longer delay to make drawer animation appear slower/more deliberate
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        Scaffold.of(context).openEndDrawer();
      }
    });
  }
}

/// Search Page Widget
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  List<String> searchHistory = [
    'BMW M4 Series',
    'Tesla Model 3',
    'Audi A4',
    'Mercedes-Benz',
    'Honda Civic',
    'Toyota Camry',
    'Volvo S90',
    'Bugatti Veyron',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _removeHistory(int index) {
    setState(() {
      searchHistory.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            /// SEARCH BAR AT TOP
            Row(
              children: [
                // Left arrow icon pehle
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ), // <-- yaha cross ko arrow_back me change kiya
                  ),
                ),
                const SizedBox(width: 6),

                // Search bar baad me
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search prodItems...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.textGrey,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.backgroundGreyLight,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.backgroundGreyLight,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Divider(
              color: AppColors.formGrey155, // line color
              thickness: 0.5, // line thickness
            ),
            const SizedBox(height: 8),

            /// SEARCH HISTORY TITLE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Searches',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'clear all',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// SEARCH HISTORY LIST
            Expanded(
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.history,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              searchHistory[index],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _removeHistory(index);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
