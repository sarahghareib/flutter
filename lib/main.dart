import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CounterScreen(),
    NumberSliderScreen(),
    RestaurantGridScreen(),
    AdditionScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 3 Application'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.blueAccent, // Set a distinct color for the background
        selectedItemColor: Colors.white,    // Set the color for the selected item
        unselectedItemColor: Colors.black54, // Set the color for unselected items
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.linear_scale),
            label: 'Slider',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 20),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class NumberSliderScreen extends StatefulWidget {
  @override
  _NumberSliderScreenState createState() => _NumberSliderScreenState();
}

class _NumberSliderScreenState extends State<NumberSliderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _numberData = [
    'https://freepngimg.com/thumb/numbers/7-2-1-number-png.png',
    'https://freepngimg.com/download/numbers/2-2-2-number-png.png',
    'https://freepngimg.com/thumb/numbers/5-2-3-number-png-thumb.png',
    'https://freepngimg.com/thumb/numbers/1-2-4-number-png-thumb.png',
  ];

  void _nextPage() {
    if (_currentPage < _numberData.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _numberData.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.network(
                  _numberData[index],
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('Failed to load image'));
                  },
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.amber,
              onPressed: _previousPage,
            ),
            SizedBox(width: 20),
            Text(
              '${_currentPage + 1} / ${_numberData.length}', // Display current page and total pages
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              color: Colors.amber,
              onPressed: _nextPage,
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class RestaurantGridScreen extends StatelessWidget {
  final List<Map<String, String>> restaurants = [
    {
      'name': 'Italian',
      'description': 'Classic Italian dishes',
      'imageUrl': 'https://w7.pngwing.com/pngs/56/985/png-transparent-pizza-margherita-sushi-pizza-pizza-delivery-pizza-thumbnail.png',
    },
    {
      'name': 'Sushi',
      'description': 'Fresh sushi and rolls',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWfyj7N4unMWB-6dKzw5fCOzwvZllF2gyE3Q&s',
    },
    {
      'name': 'Burger',
      'description': 'Juicy burgers and fries',
      'imageUrl': 'https://t4.ftcdn.net/jpg/05/85/29/13/360_F_585291338_0J8Q8vYbKDCu8yqqwAO8PsQZ4ESP2zd8.jpg',
    },
    {
      'name': 'Tacos',
      'description': 'Authentic Mexican tacos',
      'imageUrl': 'https://img.freepik.com/free-photo/delicious-taco-studio_23-2150799519.jpg',
    },
    {
      'name': 'Vegan',
      'description': 'Healthy vegan options',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBp0ETAaKFNTv8OAnXF7aFGnSIXKszhe-Z8Q&s',
    },
    {
      'name': 'French Bakery',
      'description': 'Delicious pastries and coffee',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNlw-SV4Hs3iqWbDwWv3IIjM49BcxMeb-jLA&s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: restaurants.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 3, // Adjusted aspect ratio
              ),
              itemBuilder: (context, index) {
                return RestaurantCard(
                  name: restaurants[index]['name']!,
                  description: restaurants[index]['description']!,
                  imageUrl: restaurants[index]['imageUrl']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  RestaurantCard({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}

class AdditionScreen extends StatefulWidget {
  @override
  _AdditionScreenState createState() => _AdditionScreenState();
}

class _AdditionScreenState extends State<AdditionScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  int? _sum;

  void _calculateSum() {
    final int? num1 = int.tryParse(_controller1.text);
    final int? num2 = int.tryParse(_controller2.text);

    if (num1 != null && num2 != null) {
      setState(() {
        _sum = num1 + num2;
      });
    } else {
      setState(() {
        _sum = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter first number'),
          ),
          TextField(
            controller: _controller2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter second number'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateSum,
            child: Text('Calculate Sum'),
          ),
          SizedBox(height: 20),
          if (_sum != null)
            Text(
              'Sum: $_sum',
              style: TextStyle(fontSize: 24),
            ),
        ],
      ),
    );
  }
}

