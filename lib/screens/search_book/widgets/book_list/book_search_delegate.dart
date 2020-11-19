import 'package:flutter/material.dart';

import 'package:libgen/blocs/book_bloc.dart';
import 'package:libgen/blocs/hive_bloc.dart';
import 'package:libgen/domain/filters_model.dart';
import 'package:libgen/domain/suggestion.dart';
import 'package:libgen/screens/search_book/widgets/book_list/suggestions_builder.dart';
import 'results_builder.dart';
import 'show_filter_dialog.dart';

class BookSearchDelegate extends SearchDelegate {
  @override
  final String searchFieldLabel = "Title, author or ISBN";

  FiltersModel filters = FiltersModel();

  BookBloc bookBloc;
  HiveBloc<Suggestion> hiveBloc;

  BookSearchDelegate({@required this.bookBloc, @required this.hiveBloc});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: Icon(Icons.filter_list),
        onPressed: () async {
          filters = await showFilterDialog(
            context: context,
            currentQuery: query,
            currentFilters: filters,
            bookBloc: bookBloc,
          );
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Suggestion> _suggestions = [];
    _suggestions.addAll(hiveBloc.repository.box.values);

    return SuggestionsBuilder(
      hiveBloc: hiveBloc,
      onSelected: (Suggestion suggestion) {
        query = suggestion.query;
        showResults(context);
      },
      suggestions: _suggestions,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length < 4) {
      return Container();
    }

    return ResultsBuilder(
      query: query,
      filters: filters,
      bookBloc: bookBloc,
      hiveBloc: hiveBloc,
    );
  }
}
