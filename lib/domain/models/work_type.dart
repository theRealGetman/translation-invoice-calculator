enum WorkType {
  translation,
  qc;

  String get title => switch (this) {
        WorkType.translation => 'Translation',
        WorkType.qc => 'QC',
      };
}
