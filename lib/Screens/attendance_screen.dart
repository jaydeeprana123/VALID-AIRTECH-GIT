import 'dart:developer';

import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AttendanceScreen extends StatelessWidget {
  final List<Map<String, String>> attendanceData = [
    {'date': '01/07/2024', 'status': 'P', 'overtime': 'NA'},
    {'date': '02/07/2024', 'status': 'P', 'overtime': 'NA'},
    {'date': '03/07/2024', 'status': 'P', 'overtime': 'NA'},
    {'date': '04/07/2024', 'status': 'P', 'overtime': 'NA'},
    {'date': '05/07/2024', 'status': 'P', 'overtime': 'NA'},
    {'date': '06/07/2024', 'status': 'P', 'overtime': 'NA'},
    {'date': '07/07/2024', 'status': 'O', 'overtime': 'NA'},
    {'date': '08/07/2024', 'status': 'P', 'overtime': 'NA'},
    {'date': '09/07/2024', 'status': 'P', 'overtime': 'NA'},
    {'date': '10/07/2024', 'status': 'NA', 'overtime': 'NA'},
    {'date': '11/07/2024', 'status': 'NA', 'overtime': 'NA'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Monthly Attendance',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green,
            width: double.infinity,
            child: const Center(
              child: Text(
                'July-2024',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(

              child: DataTable(

                headingRowColor: MaterialStateProperty.all(Colors.green),
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          'Attendance\nDate',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Attendance\nStatus\n(In Shift)',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Over Time\nStatus\n(In Shift)',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
                rows: attendanceData
                    .map(
                      (entry) => DataRow(
                    cells: [
                      DataCell(Text(entry['date']!), ),
                      DataCell(Text(entry['status']!)),
                      DataCell(Text(entry['overtime']!)),
                    ],
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: ''),
        ],
      ),
    );
  }
}
