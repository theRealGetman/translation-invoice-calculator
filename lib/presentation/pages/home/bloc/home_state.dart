part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState({
    this.items = const [],
    this.totalPrice = 0,
  });

  final List<WorkItem> items;
  final double totalPrice;

  @override
  List<Object> get props => [items, totalPrice];
}

final class HomeInitial extends HomeState {}

final class HomeNewItem extends HomeState {
  const HomeNewItem({
    required super.items,
    required super.totalPrice,
  });
}

final class HomeUpdated extends HomeState {
  const HomeUpdated({
    required super.items,
    required super.totalPrice,
  });
}
