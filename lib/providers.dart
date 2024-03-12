import 'package:provider/provider.dart';
import './src/providers/patient_navbar_selection_provider.dart';

class Providers {
  Providers._();
  static final providers = [
    ChangeNotifierProvider<PatientNavBarSelectionProvider>(
      create: (_) => PatientNavBarSelectionProvider(),
    ),
  ].toList();
}
