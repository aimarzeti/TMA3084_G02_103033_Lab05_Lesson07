import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Car {
  final String make;
  final String model;
  final int price;

  Car({required this.make, required this.model, required this.price});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 05 - Part 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        scaffoldBackgroundColor: Colors.pink.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const CarDataTableScreen(),
    );
  }
}

class CarDataTableScreen extends StatefulWidget {
  const CarDataTableScreen({super.key});

  @override
  State<CarDataTableScreen> createState() => _CarDataTableScreenState();
}

class _CarDataTableScreenState extends State<CarDataTableScreen> {
  int? _sortColumnIndex;
  bool _isAscending = true;

  final List<Car> _cars = [
    Car(make: 'Toyota', model: 'Camry', price: 145000),
    Car(make: 'Honda', model: 'Civic', price: 132000),
    Car(make: 'Perodua', model: 'Myvi', price: 54000),
    Car(make: 'Proton', model: 'X50', price: 98000),
    Car(make: 'Mazda', model: 'CX-5', price: 158000),
  ];

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;

      if (columnIndex == 0) {
        _cars.sort(
          (a, b) =>
              ascending ? a.make.compareTo(b.make) : b.make.compareTo(a.make),
        );
      } else if (columnIndex == 1) {
        _cars.sort(
          (a, b) => ascending
              ? a.model.compareTo(b.model)
              : b.model.compareTo(a.model),
        );
      } else if (columnIndex == 2) {
        _cars.sort(
          (a, b) => ascending
              ? a.price.compareTo(b.price)
              : b.price.compareTo(a.price),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sortable Car DataTable')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.pink.shade200, width: 1.5),
            ),
            child: DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _isAscending,
              headingRowColor: WidgetStateProperty.all(Colors.pink.shade100),
              columns: [
                DataColumn(
                  label: Text(
                    'Car Make',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade900,
                    ),
                  ),
                  onSort: _onSort,
                ),
                DataColumn(
                  label: Text(
                    'Model',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade900,
                    ),
                  ),
                  onSort: _onSort,
                ),
                DataColumn(
                  label: Text(
                    'Price (RM)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade900,
                    ),
                  ),
                  numeric: true,
                  onSort: _onSort,
                ),
              ],
              rows: List<DataRow>.generate(_cars.length, (index) {
                final car = _cars[index];
                return DataRow(
                  color: WidgetStateProperty.all(
                    index.isEven ? Colors.white : Colors.pink.shade50,
                  ),
                  cells: [
                    DataCell(
                      Text(
                        car.make,
                        style: TextStyle(color: Colors.pink.shade900),
                      ),
                    ),
                    DataCell(
                      Text(
                        car.model,
                        style: TextStyle(color: Colors.pink.shade900),
                      ),
                    ),
                    DataCell(
                      Text(
                        car.price.toString(),
                        style: TextStyle(color: Colors.pink.shade900),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
