import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:libgen/blocs/book_bloc.dart';
import 'package:libgen/blocs/events/theme_events.dart';
import 'package:libgen/blocs/hive_bloc.dart';
import 'package:libgen/blocs/theme_bloc.dart';
import 'package:libgen/domain/suggestion.dart';
import 'package:libgen/global/theme/themes.dart';
import 'widgets/book_list/book_search_delegate.dart';

class SearchBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: Theme.of(context).brightness == Brightness.light
                    ? AssetImage('assets/images/logo_light.png')
                    : AssetImage('assets/images/logo_dark.png'),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Search by title, author or ISBN',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Icon(
                              Icons.search,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: BookSearchDelegate(
                            bookBloc: BlocProvider.of<BookBloc>(context),
                            hiveBloc: BlocProvider.of<HiveBloc<Suggestion>>(
                              context,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.brightness_4,
            size: 30,
            color: Theme.of(context).buttonColor,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            child: Text("Light Mode"),
                            onPressed: () {
                              BlocProvider.of<ThemeBloc>(context).add(
                                ChangeTheme(AppTheme.BlueLight),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            child: Text("Dark Mode"),
                            onPressed: () {
                              BlocProvider.of<ThemeBloc>(context).add(
                                ChangeTheme(AppTheme.BlueDark),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
