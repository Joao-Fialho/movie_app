import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/formatted_date.dart';

void main() {
  test('the previous date must be formatted to Brazilian date format', () {
    final String dataTest = FormattedDate.dateFormatter('1980-06-30');
    expect(dataTest, '30/06/1980');
  });

  test('should return ' ' if there is no "-" inside the string', () {
    final String dataTest = FormattedDate.dateFormatter('1980*06*30');
    expect(dataTest, 'Formato entrado errado');
  });
}
