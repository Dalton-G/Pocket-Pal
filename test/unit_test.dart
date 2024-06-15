import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_pal/src/providers/admin/nav/admin_navbar_provider.dart';

void main() {
  group('Testing AdminNavbarProvider', () {
    test('initial selected index is 0', () {
      final provider = AdminNavbarProvider();
      expect(provider.selectedIndex, 0);
    });

    test('setSelectedIndex updates the selected index and notifies listeners',
        () {
      final provider = AdminNavbarProvider();
      bool notified = false;

      // Add a listener to detect when notifyListeners is called
      provider.addListener(() {
        notified = true;
      });

      provider.setSelectedIndex(1);

      // Verify the selected index is updated
      expect(provider.selectedIndex, 1);
      // Verify that listeners were notified
      expect(notified, true);
    });
  });
}
