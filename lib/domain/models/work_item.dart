import 'package:equatable/equatable.dart';
import 'package:invoice_calculator/domain/models/work_type.dart';
import 'package:invoice_calculator/presentation/utils/utils.dart';

class WorkItem extends Equatable {
  const WorkItem({
    required this.id,
    this.title,
    this.duration,
    this.type = WorkType.origination,
    this.price,
  });

  final int id;
  final String? title;
  final double? duration;
  final WorkType type;
  final double? price;

  bool get isEmpty => title.isBlank && duration == null;

  @override
  List<Object?> get props => [
        id,
        title,
        duration,
        type,
        price,
      ];

  WorkItem copyWith({
    int? id,
    String? title,
    double? duration,
    WorkType? type,
    double? price,
  }) {
    return WorkItem(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      price: price ?? this.price,
    );
  }
}
