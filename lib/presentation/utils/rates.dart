final class Rate {
  const Rate({
    required this.startDuration,
    required this.endDuration,
    required this.originationRate,
    required this.qcRate,
  });

  final int startDuration;
  final int endDuration;
  final double originationRate;
  final double qcRate;
}

const rates = [
  Rate(startDuration: 0, endDuration: 15, originationRate: 42.9, qcRate: 10.24),
  Rate(startDuration: 15, endDuration: 25, originationRate: 71.5, qcRate: 17.33),
  Rate(startDuration: 25, endDuration: 35, originationRate: 85.8, qcRate: 20.48),
  Rate(startDuration: 35, endDuration: 50, originationRate: 128.7, qcRate: 30.72),
  Rate(startDuration: 50, endDuration: 65, originationRate: 171.6, qcRate: 40.95),
  Rate(startDuration: 65, endDuration: 85, originationRate: 228.8, qcRate: 54.60),
  Rate(startDuration: 85, endDuration: 105, originationRate: 286, qcRate: 68.25),
  Rate(startDuration: 105, endDuration: 125, originationRate: 343.2, qcRate: 81.90),
];
