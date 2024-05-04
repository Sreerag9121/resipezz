import 'package:flutter/material.dart';

class AdminSearch extends StatefulWidget {
  const AdminSearch({super.key});

  @override
  State<AdminSearch> createState() => _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          // controller: _searchController,
          onChanged: (value) {

          },
          decoration: InputDecoration(
              hintText: 'search...',
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              prefixIcon: IconButton(
                  onPressed: () async {}, icon: const Icon(Icons.search)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
        ),
      ),
    );
  }
}
