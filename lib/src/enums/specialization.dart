enum Specialization {
  ClinicalSocialWorker,
  MarriageAndFamilyTherapy,
  MentalHealthCounselor,
  ProfessionalCounselor,
  Psychologist
}

extension SpecializationExtension on Specialization {
  String get displayName {
    switch (this) {
      case Specialization.ClinicalSocialWorker:
        return 'Clinical Social Worker';
      case Specialization.MarriageAndFamilyTherapy:
        return 'Marriage & Family Therapist';
      case Specialization.MentalHealthCounselor:
        return 'Mental Health Counselor';
      case Specialization.ProfessionalCounselor:
        return 'Professional Counselor';
      case Specialization.Psychologist:
        return 'Psychologist';
      default:
        return '';
    }
  }
}
