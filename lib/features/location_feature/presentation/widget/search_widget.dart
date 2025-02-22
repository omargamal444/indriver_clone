import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
final String? hintText;
final void Function(String)?onChanged;
const SearchWidget({super.key, required this.hintText,this.onChanged});
  @override
  Widget build(BuildContext context) {
    return  TextField(
      onSubmitted: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText:hintText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      );
    }
  }

