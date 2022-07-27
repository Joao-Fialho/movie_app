import 'package:flutter/material.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_strings.dart';

class HomeAppBar extends StatefulWidget {
  final void Function(String)? onChanged;
  const HomeAppBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;

    return Container(
      alignment: Alignment.bottomLeft,
      height: size.width * 0.24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu_open_rounded,
            size: size.width * 0.1,
            color: theme.onPrimary,
          ),
          isPressed
              ? SizedBox(
                  height: size.width * 0.1,
                  width: size.width * 0.55,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: size.width * 0.025),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primary,
                          width: size.width * 0.01,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.onPrimary,
                          width: size.width * 0.01,
                        ),
                      ),
                      hintText: AppStrings.searchHintText,
                      hintStyle: TextStyle(
                        color: theme.onPrimary,
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    onChanged: widget.onChanged,
                  ),
                )
              : Container(
                  height: size.width * 0.1,
                ),
          SizedBox(
            // color: Colors.blue,
            width: size.width * 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //
                IconButton(
                  splashRadius: size.width * 0.05,
                  iconSize: size.width * 0.08,
                  onPressed: () {
                    setState(() {
                      isPressed = !isPressed;
                    });
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: theme.onPrimary,
                  ),
                ),

                Icon(
                  Icons.manage_search_rounded,
                  size: size.width * 0.09,
                  color: theme.onPrimary,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
