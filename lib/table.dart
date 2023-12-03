import 'package:flutter/material.dart';

class Employee {
  String name;
  String email;
  String role;
  bool isSelected;

  Employee(this.name, this.email, this.role, {this.isSelected = false});
}

class EmployeeTable extends StatefulWidget {
  const EmployeeTable({Key? key}) : super(key: key);

  @override
  _EmployeeTableState createState() => _EmployeeTableState();
}

class _EmployeeTableState extends State<EmployeeTable> {
  int _currentPageIndex = 0;
  static const int _employeesPerPage = 10;
  final TextEditingController _searchController = TextEditingController();
  late List<Employee> displayedEmployees;
  String _searchQuery = '';
  bool isSearching = false;

  List<Employee> employees = [
    Employee('Aaron', 'aaron@mailinator.com', 'member'),
    Employee('Anika Shandilya', 'anika@mailinator.com', 'member'),
    Employee('Akshat Sharma', 'akshat@mailinator.com', 'member'),
    Employee('Brenda Johnson', 'brenda@mailinator.com', 'member'),
    Employee('Caleb Williams', 'caleb@mailinator.com', 'member'),
    Employee('Diana Brown', 'diana@mailinator.com', 'member'),
    Employee('Emily Wilson', 'emily@mailinator.com', 'member'),
    Employee('Finnegan Martinez', 'finnegan@mailinator.com', 'member'),
    Employee('Gabriela Garcia', 'gabriela@mailinator.com', 'member'),
    Employee('Harrison Lee', 'harrison@mailinator.com', 'member'),
    Employee('Isabella Adams', 'isabella@mailinator.com', 'member'),
    Employee('Jack Thompson', 'jack@mailinator.com', 'member'),
    Employee('Kaitlyn Davis', 'kaitlyn@mailinator.com', 'member'),
    Employee('Lucas Rodriguez', 'lucas@mailinator.com', 'member'),
    Employee('Mia Wright', 'mia@mailinator.com', 'member'),
    Employee('Nathan Campbell', 'nathan@mailinator.com', 'member'),
    Employee('Olivia Clark', 'olivia@mailinator.com', 'member'),
    Employee('Peyton Martinez', 'peyton@mailinator.com', 'member'),
    Employee('Quinn Hill', 'quinn@mailinator.com', 'member'),
    Employee('Riley Turner', 'riley@mailinator.com', 'member'),
    Employee('Sophia Carter', 'sophia@mailinator.com', 'member'),
    Employee('Tyler Scott', 'tyler@mailinator.com', 'member'),
    Employee('Uma Patel', 'uma@mailinator.com', 'member'),
    Employee('Victor Phillips', 'victor@mailinator.com', 'member'),
    Employee('Willow Evans', 'willow@mailinator.com', 'member'),
    Employee('Xavier Flores', 'xavier@mailinator.com', 'member'),
    Employee('Peyton Martinez', 'peyton@mailinator.com', 'member'),
    Employee('Diana Brown', 'diana@mailinator.com', 'member'),
    Employee('Emily Wilson', 'emily@mailinator.com', 'member'),
    Employee('Quinn Hill', 'quinn@mailinator.com', 'member'),
    // Your employee details here...
  ];

  @override
  void initState() {
    super.initState();
    displayedEmployees = List.from(employees);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        displayedEmployees = List.from(employees);
      } else {
        displayedEmployees = employees
            .where((employee) =>
                employee.name.toLowerCase().contains(query) ||
                employee.email.toLowerCase().contains(query) ||
                employee.role.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  List<Employee> getSelectedEmployees() {
    return employees.where((employee) => employee.isSelected).toList();
  }

  bool isDeleteButtonEnabled() {
    return getSelectedEmployees().isNotEmpty;
  }

  void deleteSelectedEmployees() {
    setState(() {
      employees.removeWhere((employee) => employee.isSelected);
      displayedEmployees = List.from(employees);
    });
  }

  List<Employee> getDisplayedEmployees() {
    final startIndex = _currentPageIndex * _employeesPerPage;
    final endIndex = startIndex + _employeesPerPage;
    return displayedEmployees.sublist(
        startIndex, endIndex.clamp(0, displayedEmployees.length));
  }

  int getTotalPages() {
    return (displayedEmployees.length / _employeesPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final displayedEmployees = getDisplayedEmployees();
    final totalPages = getTotalPages();

    return ListView(
      shrinkWrap: true,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 500,
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search here...',
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                _onSearchChanged();
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
        const SizedBox(height: 25),
        const Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 25,
            child: Text(
              'List of Users:',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 9),
        Column(children: [
          Container(
            height: 2,
            color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.75,
          )
        ]),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 600,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  showBottomBorder: true,
                  dividerThickness: 2,
                  columnSpacing: 24.0,
                  columns: const [
                    DataColumn(
                        label: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Role',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Actions',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                  rows: getDisplayedEmployees().map((employee) {
                    return DataRow(
                      selected: employee.isSelected,
                      onSelectChanged: (newValue) {
                        setState(() {
                          employee.isSelected = newValue!;
                          employees
                              .where((element) => element.email == employee.email)
                              .first
                              .isSelected = newValue;
                        });
                      },
                      cells: [
                        DataCell(
                            SizedBox(width: 250, child: Text(employee.name))),
                        DataCell(
                            SizedBox(width: 250, child: Text(employee.email))),
                        DataCell(
                          SizedBox(width: 100, child: Text(employee.role)),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _editEmployeeDetails(employee);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    displayedEmployees.remove(employee);
                                    employees.remove(employee);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPageIndex = 0;
                });
              },
              icon: const Icon(Icons.first_page),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPageIndex =
                      (_currentPageIndex - 1).clamp(0, totalPages - 1);
                });
              },
              icon: const Icon(Icons.navigate_before),
            ),
            const SizedBox(width: 8),
            Text('Page ${_currentPageIndex + 1} of $totalPages'),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPageIndex =
                      (_currentPageIndex + 1).clamp(0, totalPages - 1);
                });
              },
              icon: const Icon(Icons.navigate_next),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPageIndex = totalPages - 1;
                });
              },
              icon: const Icon(Icons.last_page),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: isDeleteButtonEnabled()
                ? () {
                    deleteSelectedEmployees();
                  }
                : null,
            child: const Text('Delete Selected'),
          ),
        ),
      ],
    );
  }

  void _editEmployeeDetails(Employee employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedName = employee.name;
        String editedEmail = employee.email;
        String editedRole = employee.role;

        return AlertDialog(
          title: const Text('Edit Employee Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  controller: TextEditingController(text: employee.name),
                  onChanged: (value) {
                    editedName = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  controller: TextEditingController(text: employee.email),
                  onChanged: (value) {
                    editedEmail = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Role'),
                  controller: TextEditingController(text: employee.role),
                  onChanged: (value) {
                    editedRole = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  employee.name = editedName;
                  employee.email = editedEmail;
                  employee.role = editedRole;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
