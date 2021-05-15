import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterissuesapp/injections.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/issues/bloc/filter_form_bloc/filter_form_bloc.dart';
import 'package:flutterissuesapp/issues/bloc/issues_bloc.dart';
import 'package:flutterissuesapp/issues/views/widget/infinite_scroll_widget.dart';
import 'package:flutterissuesapp/theme/cubit/theme_cubit.dart';
import 'package:flutterissuesapp/l10n/l10n.dart';
import 'package:flutterissuesapp/utils/utils.dart';
import 'package:github_api_repository/github_api_repository.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.issueAppBarTitle),
        actions: [
          Switch(
            value: context.select((ThemeCubit cubit) => cubit.state) ==
                ThemeData.dark(),
            onChanged: (value) => !value
                ? context.read<ThemeCubit>().setLightMode()
                : context.read<ThemeCubit>().setDarkMode(),
          ),
        ],
      ),
      //backgroundColor: Colors.white,
      body: BlocListener<FilterFormBloc, FilterFormState>(
          listener: (context, state) {
            state.onSave.fold(
                () => null,
                (data) => context
                    .read<IssuesBloc>()
                    .add(IssuesEvent.setFiltersAsked(data)));
          },
          child: const IssuesView()),
    );
  }
}

class IssuesView extends StatelessWidget {
  const IssuesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<IssuesBloc, IssuesState>(builder: (context, state) {
      if (state is IsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is IssuesSuccess) {
        final issues = state.issues;

        return GestureDetector(
          onTap: () {
            final currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kDefaultPadding),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.filterInputLabel,
                  hintText: l10n.filterInputHint,
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: const OutlineInputBorder(),
                ),
                onChanged: (value) => context
                    .read<FilterFormBloc>()
                    .add(FilterFormEvent.onFilterChanged(value)),
                onSaved: (_) => context
                    .read<FilterFormBloc>()
                    .add(const FilterFormEvent.enterPressed()),
                onFieldSubmitted: (_) => context
                    .read<FilterFormBloc>()
                    .add(const FilterFormEvent.enterPressed()),
              ),
            ),
            Expanded(
              child: BlocProvider(
                create: (_) => getIt<FetchMoreBloc>(),
                child: InfiniteScrollWidget(
                  issues: issues as List<Edge>,
                ),
              ),
            ),
          ]),
        );
      } else {
        print(state);
        return Center(child: Text(l10n.genericError));
      }
    });
  }
}
