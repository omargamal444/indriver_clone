import 'package:flutter/material.dart';

class SearchResultWidget extends StatelessWidget {
  final String searchedLocationName;
  final void Function()? onTap;

  const SearchResultWidget({super.key, required this.searchedLocationName,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.8),
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.width * .15,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(Icons.location_on_sharp,
                        color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          searchedLocationName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ));
  }
}
