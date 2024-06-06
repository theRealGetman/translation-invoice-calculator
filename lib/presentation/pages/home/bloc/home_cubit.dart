import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_calculator/domain/domain.dart';
import 'package:invoice_calculator/domain/models/work_item.dart';
import 'package:invoice_calculator/presentation/utils/rates.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<WorkItem> _items = [];

  double get _totalPrice {
    return _items.fold(0, (previousValue, item) => previousValue + (item.price ?? 0));
  }

  Future<void> addNewItem() async {
    if (_items.isEmpty) {
      _items = List.of(_items)..add(const WorkItem(id: 1));
    } else {
      final id = _items.last.id + 1;
      _items = List.of(_items)..add(WorkItem(id: id));
    }
    emit(
      HomeNewItem(
        items: _items,
        totalPrice: _totalPrice,
      ),
    );
  }

  Future<void> deleteItem(WorkItem item) async {
    _items.removeWhere((el) => el.id == item.id);
    emit(
      HomeUpdated(
        items: _items,
        totalPrice: _totalPrice,
      ),
    );
  }

  Future<void> recount() async {
    _items = _items.map((item) {
      if (item.duration == null) {
        return item;
      }
      final maxDuration = rates
          .reduce((value, element) =>
              value.endDuration > element.endDuration ? value : element)
          .endDuration
          .toDouble();
      final duration = item.duration!;
      final price = _getDurations(duration, maxDuration)
          .map((e) => _getPrice(e, item.type))
          .fold(0.0, (previousValue, element) => previousValue + element);

      return item.copyWith(price: price);
    }).toList();

    emit(
      HomeUpdated(
        items: _items,
        totalPrice: _totalPrice,
      ),
    );
  }

  List<double> _getDurations(double duration, double maxDuration) {
    if (duration > maxDuration) {
      final fullChunks = duration ~/ maxDuration;
      final lastChunk = duration % maxDuration;
      final durations = List.generate(fullChunks, (_) => maxDuration);
      if (lastChunk != 0) {
        durations.add(lastChunk);
      }
      return durations;
    } else {
      return [duration];
    }
  }

  double _getPrice(double duration, WorkType type) {
    final rate = rates.firstWhere((element) =>
        element.startDuration <= duration && duration <= element.endDuration);

    return switch (type) {
      WorkType.origination => rate.originationRate,
      WorkType.qc => rate.qcRate,
    };
  }

  void updateTitle(int id, String title) {
    var index = _items.indexWhere((element) => element.id == id);
    final item = _items[index];
    _items[index] = item.copyWith(title: title);
  }

  void updateDuration(int id, String duration) {
    var index = _items.indexWhere((element) => element.id == id);
    final item = _items[index];
    _items[index] = item.copyWith(
      duration: double.tryParse(duration.replaceAll(',', '.')),
    );
  }

  void updateType(int id, WorkType type) {
    var index = _items.indexWhere((element) => element.id == id);
    final item = _items[index];
    _items[index] = item.copyWith(type: type);

    recount();
  }
}
