import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webcom/help/box_style.dart';
import 'package:webcom/help/route_arugument.dart';
import 'package:webcom/page/second_page/bottom_item.dart';
import 'package:webcom/page/second_page/cubit/second_screen_cubit.dart';
import 'package:webcom/help/app_config.dart' as config;
import 'package:webcom/page/second_page/item_cubit/item_cubit.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, this.routeArguments});

  final RouteArguments? routeArguments;

  static Route route({RouteArguments? routeArguments}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (context) {
              return SecondScreenCubit();
            },
            child: SecondScreen(
              routeArguments: routeArguments!,
            )));
  }

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondScreenCubit, SecondScreenState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Second Screen'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding:
                      EdgeInsets.all(config.AppConfig(context).appWidth(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${widget.routeArguments!.name}'),
                      Text('Age: ${widget.routeArguments!.age}'),
                      Text('Gender: ${widget.routeArguments!.gender}'),
                      Text('Occupation: ${widget.routeArguments!.occupation}'),
                      CommonContainer(
                          height: 30,
                          borderColor: Colors.transparent,
                          child: Image.file(
                            File(widget.routeArguments!.profilePhoto!),
                            fit: BoxFit.cover,
                          )),
                      state.totalPrice.isNotEmpty && state.totalPrice != 'null'
                          ? Column(
                              children: [
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(2),
                                ),
                                Text('Total Price: ${state.totalPrice}')
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(10),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BlocProvider(
                                      create: (context) {
                                        return ItemCubit();
                                      },
                                      child: const BottomItem());
                                },
                              ).then((value) {
                                context
                                    .read<SecondScreenCubit>()
                                    .onShowTotalPrice(value: value.toString());
                              });
                            },
                            child: const Text('Add item')),
                      )
                    ],
                  )),
            ));
      },
    );
  }
}
