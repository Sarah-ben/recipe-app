import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';

import '../../../../main_layout/cubit/app_cubit.dart';

class SearchBar extends StatelessWidget {
  final void Function() onBackPress;
  final void Function() onClearPress;
  final void Function(String) onChanged;
  const SearchBar({
    Key? key,
    required this.onBackPress,
    required this.onClearPress,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      autofocus: true,
      decoration: InputDecoration(
        contentPadding:const EdgeInsets.only(),
        border:const OutlineInputBorder(),
        focusedBorder:const OutlineInputBorder(borderSide: BorderSide(width: 0)),
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search',
        prefixIcon: IconButton(
          iconSize: 19,
          onPressed: onBackPress,
          icon: Icon(Icons.arrow_back_ios,color: AppColors.primaryTextColor(),),
        ),
        suffixIcon: IconButton(
          iconSize: 19,
          onPressed:onClearPress,
          icon: Icon(Icons.close,color: AppColors.primaryTextColor()),
        ),
      ),
    );
  }
}
