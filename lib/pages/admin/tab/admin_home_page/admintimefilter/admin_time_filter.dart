import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admintimefilter/admin_time_filter_card.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminTimeFilter extends StatefulWidget {
  const AdminTimeFilter({super.key});

  @override
  State<AdminTimeFilter> createState() => _AdminTimeFilterState();
}

class _AdminTimeFilterState extends State<AdminTimeFilter> {
  String? _selectedTime;
  final List<String> times = ['00.15', '00.30', '01.00', '01.30', '2.00'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear)),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Select the required time',
                  style:
                      TextStyle(fontFamily: AppTheme.fonts.jost, fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.colors.appGreyColor)),
                child: DropdownButton<String>(
                  dropdownColor: AppTheme.colors.shadecolor,
                  focusColor: AppTheme.colors.appGreyColor,
                  value: _selectedTime,
                  hint: const Text('Select Time'),
                  items: times.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text('$value hour'),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTime = newValue;
                    });
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('recipes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }

                    List<Map<String, dynamic>> items = snapshot.data!.docs
                        .map((e) => {
                              'id': e.id,
                              'name': e['name'],
                              'image': e['recipeImage'],
                              'time': e['timeRequired'],
                            })
                        .toList();

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> item = items[index];
                        if (_selectedTime == null ||
                            double.parse(item['time']) <=
                                double.parse(_selectedTime!)) {
                          return RecipeCard(data: item);
                        }
                        return Container();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

