enum WorkType {
  origination,
  qc;

  String get title => switch (this) {
        WorkType.origination => 'Origination',
        WorkType.qc => 'QC',
      };
}
