import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_calculator/domain/domain.dart';
import 'package:invoice_calculator/domain/models/work_item.dart';
import 'package:invoice_calculator/presentation/pages/home/bloc/home_cubit.dart';
import 'package:invoice_calculator/presentation/utils/utils.dart';

class HomeTable extends StatefulWidget {
  const HomeTable({super.key});

  @override
  State<HomeTable> createState() => _HomeTableState();
}

class _HomeTableState extends State<HomeTable> {
  final Map<int, FocusNode> _durationFocusNodes = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeNewItem) {
          _createDurationFocusNodes(state.items);
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            showBottomBorder: true,
            empty: Center(
              child: OutlinedButton(
                onPressed: context.read<HomeCubit>().addNewItem,
                child: const Text('Add first item'),
              ),
            ),
            columns: const [
              DataColumn2(
                label: Text('#'),
                fixedWidth: 48,
              ),
              DataColumn2(
                label: Text('Episode'),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Type'),
              ),
              DataColumn2(
                label: Text('Duration (min)'),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text('Price'),
                numeric: true,
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text(''),
                fixedWidth: 64,
              ),
            ],
            rows: buildRows(state.items)
              ..add(_addNewRow)
              ..add(buildSummaryRow(state.totalPrice)),
          ),
        );
      },
    );
  }

  List<DataRow2> buildRows(List<WorkItem> items) => items.indexed.map((e) {
        final int number = e.$1 + 1;
        final item = e.$2;
        return DataRow2(
          cells: [
            DataCell(
              Text('$number'),
            ),
            DataCell(
              TextField(
                controller: TextEditingController(text: item.title),
                decoration: const InputDecoration.collapsed(hintText: 'Title'),
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  context.read<HomeCubit>().updateTitle(item.id, text);
                },
                onSubmitted: (text) {
                  context.read<HomeCubit>().recount();
                },
              ),
            ),
            DataCell(
              DropdownButton<WorkType>(
                value: item.type,
                items: WorkType.values
                    .map(
                      (type) => DropdownMenuItem<WorkType>(
                        value: type,
                        child: Text(type.title),
                      ),
                    )
                    .toList(),
                onChanged: (WorkType? value) {
                  context
                      .read<HomeCubit>()
                      .updateType(item.id, value ?? WorkType.origination);
                },
              ),
            ),
            DataCell(
              TextField(
                controller:
                    TextEditingController(text: item.duration?.toStringAsFixed(2)),
                focusNode: _durationFocusNodes[item.id],
                decoration: const InputDecoration.collapsed(hintText: 'Duration in min'),
                textInputAction: TextInputAction.done,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                onChanged: (text) {
                  context.read<HomeCubit>().updateDuration(item.id, text);
                },
                onSubmitted: (text) {
                  context.read<HomeCubit>().recount();
                },
              ),
            ),
            DataCell(
              SelectableText('\$${item.price?.toStringAsFixed(2) ?? 0}'),
            ),
            DataCell(
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _showDeleteDialog(context, item);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList();

  DataRow2 buildSummaryRow(double totalPrice) => DataRow2(
        cells: [
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
          DataCell(
            SelectableText('Total: \$${totalPrice.toStringAsFixed(2)}'),
          ),
          DataCell.empty,
        ],
      );

  DataRow2 get _addNewRow => DataRow2(
        onTap: () {
          context.read<HomeCubit>().addNewItem();
        },
        cells: const [
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
        ],
      );

  void _showDeleteDialog(BuildContext ctx, WorkItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete item'),
          content: const Text('Are you sure you want delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                textAlign: TextAlign.end,
              ),
            ),
            TextButton(
              onPressed: () {
                ctx.read<HomeCubit>().deleteItem(item);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        );
      },
    );
  }

  void _createDurationFocusNodes(List<WorkItem> items) {
    for (final item in items) {
      if (_durationFocusNodes.containsKey(item.id)) {
        continue;
      }
      final node = FocusNode();
      node.addListener(() {
        _onDurationFocusChanged(item.id);
      });
      _durationFocusNodes[item.id] = node;
    }
  }

  void _onDurationFocusChanged(int id) {
    if (!(_durationFocusNodes[id]?.hasFocus ?? false)) {
      context.read<HomeCubit>().recount();
    }
  }

  void _disposeFocusNodes() {
    for (var node in _durationFocusNodes.values) {
      node.dispose();
    }
  }

  @override
  void dispose() {
    _disposeFocusNodes();
    super.dispose();
  }
}
