
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_sop/features/search/presentation/provider/search_provider.dart';



class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchprovider, child) {
        return Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: searchprovider.searchController,
              onChanged: (value) {
            
                 if (value.isNotEmpty) {
                    searchprovider.clearData();
                    searchprovider.getSearchUsers();
                  } else {
                    searchprovider.clearData();
                  }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search by name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}