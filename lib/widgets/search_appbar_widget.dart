import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final VoidCallback onSubmitted;

  const SearchAppBar({
    super.key,
    required this.textEditingController,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.black45,
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: textEditingController,
        decoration: const InputDecoration(
          hintText: '검색어를 입력하세요',
        ),
        onChanged: onChanged,
        onEditingComplete: onSubmitted,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
