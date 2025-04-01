// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/onboarding_simple_widgetbook.dart' as _i2;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookComponent(
    name: 'OSOnboardingScreen',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Default',
        builder: _i2.buildSimpleOSOnboardingScreenUseCase,
      ),
      _i1.WidgetbookUseCase(
        name: 'With Round Button',
        builder: _i2.buildSimpleWithProgressButton,
      ),
    ],
  ),
];
