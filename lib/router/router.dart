import 'package:flutter/material.dart';
import 'package:flutterissuesapp/issues/issues.dart';
import 'package:flutterissuesapp/issues/views/details/details_page.dart';
import 'package:routemaster/routemaster.dart';

class IssuesRouter {
  static final routes = RouteMap(routes: {
    '/': (_) => const MaterialPage(
          child: IssuesPage(),
        ),
    '/issue/:id': (info) => MaterialPage(
          child:
              DetailsPage(issueNumber: int.parse(info.pathParameters['id']!)),
        ),
  });
  static final routemaster = RoutemasterDelegate(
    routesBuilder: (context) => routes,
  );
}
