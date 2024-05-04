import 'package:flutter/material.dart';

class SearchBarHome extends StatefulWidget {
  const SearchBarHome({super.key});

  @override
  State<SearchBarHome> createState() => _SearchBarHomeState();
}

class _SearchBarHomeState extends State<SearchBarHome> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          // controller: _searchController,
          onChanged: (value) {},
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
