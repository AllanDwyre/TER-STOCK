import 'package:flutter/material.dart';

class TextThemeUtils {
  //TODO : make a utils func that refactor this :
  // Theme.of(context).textTheme.displaySmall!.copyWith(color : Theme.of(context).colorScheme.onPrimary)

  TextStyle newMethod(
    BuildContext context,
    TextStyle d,
  ) {
    // ? the only way is to use map, and declare all the options ???
    return Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Theme.of(context).colorScheme.secondary);
  }
}
