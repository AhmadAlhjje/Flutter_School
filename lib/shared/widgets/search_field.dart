import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Lists shorter than this need no search box.
const minItemsForSearch = 4;

/// A compact "search by name" box above a list; the list filters as the student types.
class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.hint, required this.onChanged});

  final String hint;
  final ValueChanged<String> onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changed(String value) {
    setState(() {});
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _changed,
      textInputAction: TextInputAction.search,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: widget.hint,
        isDense: true,
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.secondary),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  _controller.clear();
                  _changed('');
                },
              ),
      ),
    );
  }
}
