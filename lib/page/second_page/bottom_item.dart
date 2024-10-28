import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webcom/page/second_page/item_cubit/item_cubit.dart';
import 'package:webcom/help/app_config.dart' as config;

class BottomItem extends StatelessWidget {
  const BottomItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(config.AppConfig(context).appWidth(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        context.read<ItemCubit>().decrement();
                      }),
                  Text(state.itemCount.toString()),
                  IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        context.read<ItemCubit>().increment();
                      }),
                  const Spacer(),
                  Text('Total: \$${state.totalPrice}'),
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context,state.totalPrice),
                child: const Text('Done'),
              ),
            ],
          ),
        );
      },
    );
  }
}
