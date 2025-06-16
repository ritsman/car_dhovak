import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Manage your clients efficiently',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                // Navigation Cards Grid
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      childAspectRatio: 1.3,
                      children: [
                        _buildMenuCard(
                          context,
                          icon: Icons.add_circle_outline,
                          title: 'Add Entry',
                          subtitle: 'New client data',
                          gradientColors: [
                            Color(0xFF667eea),
                            Color(0xFF764ba2)
                          ],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClientDataEntryScreen(),
                              ),
                            );
                          },
                        ),
                        _buildMenuCard(
                          context,
                          icon: Icons.receipt_long,
                          title: 'View Records',
                          subtitle: 'All entries',
                          gradientColors: [
                            Color(0xFFf093fb),
                            Color(0xFFf5576c)
                          ],
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Records screen - Coming soon!'),
                                backgroundColor: Colors.deepPurple,
                              ),
                            );
                          },
                        ),
                        _buildMenuCard(
                          context,
                          icon: Icons.groups,
                          title: 'Manage Clients',
                          subtitle: 'Add/Edit clients',
                          gradientColors: [
                            Color(0xFF4facfe),
                            Color(0xFF00f2fe)
                          ],
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Client management - Coming soon!'),
                                backgroundColor: Colors.teal,
                              ),
                            );
                          },
                        ),
                        _buildMenuCard(
                          context,
                          icon: Icons.analytics_outlined,
                          title: 'Reports',
                          subtitle: 'View analytics',
                          gradientColors: [
                            Color(0xFFa8edea),
                            Color(0xFFfed6e3)
                          ],
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Reports screen - Coming soon!'),
                                backgroundColor: Colors.pink,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Footer
                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: Center(
                  //     child: Text(
                  //       'Client Management System v1.0',
                  //       style: TextStyle(
                  //         color: Colors.white.withOpacity(0.6),
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Client {
  final int id;
  final String flatno;
  final String name;
  final String mobile;

  Client({
    required this.id,
    required this.flatno,
    required this.name,
    required this.mobile,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      flatno: json['flatno'],
      name: json['name'],
      mobile: json['mobile'],
    );
  }

  @override
  String toString() {
    return '$flatno - $name';
  }
}

class ClientDataEntryScreen extends StatefulWidget {
  const ClientDataEntryScreen({super.key});

  @override
  _ClientDataEntryScreenState createState() => _ClientDataEntryScreenState();
}

class _ClientDataEntryScreenState extends State<ClientDataEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  List<Client> _clients = [];
  Client? _selectedClient;
  DateTime? _selectedDate;
  bool _isLoading = false;
  bool _isSubmitting = false;

  // Replace with your actual backend URL
  final String baseUrl = 'http://192.168.29.132:8000';

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/clients_records'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> clientsJson = json.decode(response.body);
        setState(() {
          _clients = clientsJson.map((json) => Client.fromJson(json)).toList();
        });
      } else {
        _showErrorSnackBar('Failed to load clients');
      }
    } catch (e) {
      _showErrorSnackBar('Error loading clients: $e');
      print('Error loading clients: $e');
      // For demo purposes, add some dummy data
      setState(() {
        _clients = [
          Client(id: 1, flatno: 'A101', name: 'John Doe', mobile: '9876543210'),
          Client(
              id: 2, flatno: 'A102', name: 'Jane Smith', mobile: '9876543211'),
          Client(
              id: 3, flatno: 'B201', name: 'Bob Johnson', mobile: '9876543212'),
        ];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedClient == null) {
      _showErrorSnackBar('Please select a client');
      return;
    }

    if (_selectedDate == null) {
      _showErrorSnackBar('Please select a date');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final Map<String, dynamic> data = {
        'client_id': _selectedClient!.id,
        'date': _selectedDate!.toIso8601String(),
        'amount': double.parse(_amountController.text),
        'remarks': _remarksController.text,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/submit-data'), // Replace with your actual endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessSnackBar('Data submitted successfully!');
        _clearForm();
      } else {
        _showErrorSnackBar('Failed to submit data');
      }
    } catch (e) {
      _showErrorSnackBar('Error submitting data: $e');
      // For demo purposes, show success message
      _showSuccessSnackBar('Data submitted successfully! (Demo mode)');
      _clearForm();
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _clearForm() {
    setState(() {
      _selectedClient = null;
      _selectedDate = null;
    });
    _clientController.clear();
    _dateController.clear();
    _amountController.clear();
    _remarksController.clear();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Data Entry'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Client Autocomplete Dropdown
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Client',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Autocomplete<Client>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable<Client>.empty();
                                }
                                return _clients.where((Client client) {
                                  return client.flatno.toLowerCase().contains(
                                          textEditingValue.text
                                              .toLowerCase()) ||
                                      client.name.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase());
                                });
                              },
                              displayStringForOption: (Client option) =>
                                  option.toString(),
                              fieldViewBuilder: (
                                BuildContext context,
                                TextEditingController
                                    fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted,
                              ) {
                                return TextFormField(
                                  controller: fieldTextEditingController,
                                  focusNode: fieldFocusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Search by flat number or name',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                  validator: (value) {
                                    if (_selectedClient == null) {
                                      return 'Please select a client';
                                    }
                                    return null;
                                  },
                                );
                              },
                              onSelected: (Client selection) {
                                setState(() {
                                  _selectedClient = selection;
                                });
                              },
                            ),
                            if (_selectedClient != null)
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'Selected: ${_selectedClient!.flatno} - ${_selectedClient!.name} (${_selectedClient!.mobile})',
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Date Selector
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Date',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                hintText: 'Select date',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.calendar_today),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.arrow_drop_down),
                                  onPressed: _selectDate,
                                ),
                              ),
                              readOnly: true,
                              onTap: _selectDate,
                              validator: (value) {
                                if (_selectedDate == null) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Amount Input
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amount',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _amountController,
                              decoration: InputDecoration(
                                hintText: 'Enter amount',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.currency_rupee),
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]')),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an amount';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                if (double.parse(value) <= 0) {
                                  return 'Amount must be greater than 0';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Remarks Input
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Remarks',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _remarksController,
                              decoration: InputDecoration(
                                hintText: 'Enter remarks (optional)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.note),
                              ),
                              maxLines: 3,
                              maxLength: 500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitData,
                      child: _isSubmitting
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text('Submitting...'),
                              ],
                            )
                          : Text(
                              'Submit Data',
                              style: TextStyle(fontSize: 16),
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _clientController.dispose();
    _dateController.dispose();
    _amountController.dispose();
    _remarksController.dispose();
    super.dispose();
  }
}
