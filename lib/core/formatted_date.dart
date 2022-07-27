import 'app_strings.dart';

class FormattedDate {
  static String dateFormatter(releaseDate) {
    String newReleaseDate = '';
    if (releaseDate.contains('-')) {
      newReleaseDate = releaseDate
          .split('-')
          .reversed
          .toString()
          .replaceAll(RegExp(r'(\, )'), '/')
          .replaceAll(RegExp(r'([()])'), '');
    } else {
      newReleaseDate = AppStrings.formattedErrorText;
    }
    return newReleaseDate;
  }
}
