import 'package:flutter/material.dart';

InputDecoration kTextFieldDecoration(BuildContext context) {
  return InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Theme.of(context).textTheme.headline3?.color),
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: (Theme.of(context).iconTheme.color)!),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: (Theme.of(context).iconTheme.color)!),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(width: 1.5, color: (Theme.of(context).iconTheme.color)!),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    ),
  );
}
