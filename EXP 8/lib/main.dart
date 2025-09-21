import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Custom color palette based on the design's yellow/tan color.
const MaterialColor customYellow = MaterialColor(0xFFF5EAC0, <int, Color>{
  50: Color(0xFFFBF9EE),
  100: Color(0xFFF8F5E5),
  200: Color(0xFFF5EFDC),
  300: Color(0xFFF3EAD3),
  400: Color(0xFFF1E4CB),
  500: Color(0xFFF5EAC0),
  600: Color(0xFFDED3AB),
  700: Color(0xFFC7BD96),
  800: Color(0xFFB0A780),
  900: Color(0xFF99916B),
});

// Data models for the menu items.
class MenuItem {
  final String name;
  final String price;
  final String imageUrl;

  MenuItem({required this.name, required this.price, required this.imageUrl});
}

// Data for the menu items.
final Map<String, List<MenuItem>> menuData = {
  'Home': [
    MenuItem(
      name: 'Caramel Coffee Latte',
      price: '₹99',
      imageUrl:
          'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
    ),
    MenuItem(
      name: 'Vanilla Coffee Latte',
      price: '₹99',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40337926_2-starbucks-coffee-vanilla-latte-tall.jpg',
    ),
    MenuItem(
      name: 'Orange Juice',
      price: '₹50',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40233329_2-fresho-orange-imported-juice-cold-pressed.jpg',
    ),
  ],
  'Coffee': [
    MenuItem(
      name: 'Cappuccino coffee',
      price: '₹99',
      imageUrl:
          'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
    ),
    MenuItem(
      name: 'Americano',
      price: '₹99',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40337923_2-starbucks-coffee-americano-short.jpg',
    ),
    MenuItem(
      name: 'Cold Coffee Mocha',
      price: '₹159',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40161806_1-kings-coffee-premium-cold-coffee-mocha-super-smooth.jpg',
    ),
    MenuItem(
      name: 'Espresso shot',
      price: '₹99',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40233401_1-fresho-fresh-hot-coffee.jpg',
    ),
    MenuItem(
      name: 'Iced coffee',
      price: '₹99',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40233401_1-fresho-fresh-hot-coffee.jpg',
    ),
    MenuItem(
      name: 'Cold Mocha Frappuccino',
      price: '₹139',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40345320_1-starbucks-coffee-belgium-chocolate-cream-frappuccino-tall.jpg',
    ),
  ],
  'Juices': [
    MenuItem(
      name: 'Orange Juice',
      price: '₹50',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40233329_2-fresho-orange-imported-juice-cold-pressed.jpg',
    ),
    MenuItem(
      name: 'Mango Juice',
      price: '₹60',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40115018_7-raw-pressery-mango-100-natural-cold-pressed-juice.jpg',
    ),
    MenuItem(
      name: 'Strawberry Juice',
      price: '₹60',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40309021_1-vinut-strawberry-juice-with-pulp.jpg',
    ),
    MenuItem(
      name: 'Blueberry Juice',
      price: '₹60',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40293029_1-puramate-blueberry-crush-for-perfect-drink-100-vegetarian.jpg',
    ),
  ],
  'Cold drinks': [
    MenuItem(
      name: '7 UP',
      price: '₹70',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40094178_9-7-up-soft-drink.jpg',
    ),
    MenuItem(
      name: 'Pepsi',
      price: '₹70',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40094179_9-pepsi-soft-drink.jpg',
    ),
    MenuItem(
      name: 'Limca',
      price: '₹75',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40313626_1-limca-soft-drink-lime-lemon-flavoured.jpg',
    ),
    MenuItem(
      name: 'Mountain Dew',
      price: '₹70',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40185457_6-mountain-dew-soft-drink.jpg',
    ),
  ],
  'Snacks': [
    MenuItem(
      name: 'Red Sauce Pasta',
      price: '₹250',
      imageUrl:
          'https://images.pexels.com/photos/1437267/pexels-photo-1437267.jpeg',
    ),
    MenuItem(
      name: 'Veggie Crispy',
      price: '₹170',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40280154_1-safal-crispy-veggie-bites-frozen-curried-vegetables-ready-to-cook.jpg',
    ),
    MenuItem(
      name: 'French Fries',
      price: '₹150',
      imageUrl:
          'https://images.pexels.com/photos/115740/pexels-photo-115740.jpeg',
    ),
    MenuItem(
      name: 'Spring Rolls',
      price: '₹190',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40018662_7-switz-spring-rolls-sheets-8x-8.jpg',
    ),
  ],
  'IceCream': [
    MenuItem(
      name: 'Tutti Frutti',
      price: '₹20',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40344416_1-amul-tutti-frutti-gold-ice-cream.jpg',
    ),
    MenuItem(
      name: 'Vanilla',
      price: '₹20',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40005429_3-amul-real-ice-cream-vanilla-magic.jpg',
    ),
    MenuItem(
      name: 'Chocolate',
      price: '₹20',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/40323657_2-amul-gold-chocochips-chocolate-ice-cream.jpg',
    ),
    MenuItem(
      name: 'Pista',
      price: '₹20',
      imageUrl:
          'https://www.bbassets.com/media/uploads/p/l/273383_3-dairy-day-ice-cream-pistachio-nut.jpg',
    ),
  ],
};

// Main application class.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CafeNow',
      theme: ThemeData(
        primarySwatch: customYellow,
        scaffoldBackgroundColor: customYellow.shade50,
      ),
      home: const MainScreen(),
    );
  }
}

// The main screen with the bottom navigation bar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const MenuPage(),
    const FavoritesPage(),
    const ProfilePage(),
    const CartPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Menu';
      case 2:
        return 'Favorites';
      case 3:
        return 'Profile';
      case 4:
        return 'Cart';
      default:
        return 'CafeNow';
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFF5EAC0)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Welcome, Raj!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildDrawerItem(Icons.shopping_bag, 'Orders', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Orders page
                }),
                _buildDrawerItem(Icons.favorite, 'Wishlist', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Wishlist page
                }),
                _buildDrawerItem(Icons.card_giftcard, 'Coupons', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Coupons page
                }),
                _buildDrawerItem(Icons.help_outline, 'Help', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Help page
                }),
                _buildDrawerItem(Icons.language, 'Language Settings', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Language Settings page
                }),
                _buildDrawerItem(Icons.edit, 'Edit Profile', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Edit Profile page
                }),
                _buildDrawerItem(Icons.rate_review, 'Reviews', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Reviews page
                }),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16.0,
            ),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Add logout functionality here
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Text(
          _getPageTitle(_selectedIndex),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}

// Home page widget.
final List<MenuItem> moreForYouProducts = [
  MenuItem(
    name: 'Chocolate Cake',
    price: '₹120',
    imageUrl:
        'https://www.bbassets.com/media/uploads/p/l/40192538_2-the-finishing-touch-chocolate-fudge-cake.jpg',
  ),
  MenuItem(
    name: 'Green Tea',
    price: '₹60',
    imageUrl:
        'https://images.pexels.com/photos/1417945/pexels-photo-1417945.jpeg',
  ),
  MenuItem(
    name: 'Blueberry Muffin',
    price: '₹80',
    imageUrl:
        'https://www.bbassets.com/media/uploads/p/l/40203425_1-fresho-signature-blueberry-muffin-choco-chip-muffin.jpg',
  ),
  MenuItem(
    name: 'Veg Sandwich',
    price: '₹70',
    imageUrl: 'https://www.bigbasket.com/media/uploads/recipe/w-l/1522_1.jpg',
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Example home page content, you can customize this as needed.
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text(
            'Welcome to CafeNow!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Featured Items',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ...menuData['Home']!.map((item) => _buildMenuItem(item)).toList(),
          const SizedBox(height: 20),
          _buildSectionTitle('More for you'),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
            children: moreForYouProducts
                .map((item) => _buildMenuGridItem(item))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.price,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: customYellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGridItem(MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                item.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.price, style: TextStyle(color: Colors.grey[600])),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: customYellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Menu page widget with tab navigation.
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  final List<String> categories = const [
    'Coffee',
    'Juices',
    'Cold drinks',
    'Snacks',
    'IceCream',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('CafeNow', style: TextStyle(color: Colors.black)),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            tabs: categories.map((cat) => Tab(text: cat)).toList(),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) {
            return CategoryPage(category: category);
          }).toList(),
        ),
      ),
    );
  }
}

// Widget to display a list of items for a specific category.
class CategoryPage extends StatelessWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> items = menuData[category] ?? [];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.price, style: TextStyle(color: Colors.grey[600])),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: customYellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Placeholder widgets for other pages.
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Favorites Page Content',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Profile Page Content',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Your cart is empty!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Add items to your cart to proceed.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for items...',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
