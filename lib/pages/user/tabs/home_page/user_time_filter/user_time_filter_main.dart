import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_time_filter/user_time_filter_card.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserTimeFilterMain extends StatefulWidget {
  const UserTimeFilterMain({super.key});

  @override
  State<UserTimeFilterMain> createState() => _UserTimeFilterMainState();
}

class _UserTimeFilterMainState extends State<UserTimeFilterMain> {
  String? _selectedTime;
  final List<String> times = ['00.15', '00.30', '01.00', '01.30', '02.00','+02.00'];

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
                        List<Map<String, dynamic>> filteredItems =[];
                        if(_selectedTime=='+02.00'){
                          filteredItems =items.where((item) {
                        return _selectedTime == null ||double.parse(item['time']) >=
                                double.parse(_selectedTime!);
                       }).toList();
                        }else{
                          filteredItems =items.where((item) {
                        return _selectedTime == null ||double.parse(item['time']) <=
                                double.parse(_selectedTime!);
                       }).toList();
                        }
                        
            return filteredItems.isEmpty?Center(
                  child: Text(
                    'No Data Found',
                    style: TextStyle(
                      fontFamily: AppTheme.fonts.jost,
                    ),
                  ),
                )
                :ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> item = filteredItems[index];
                          return UserRecipeCard(data: item);
                      }
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

