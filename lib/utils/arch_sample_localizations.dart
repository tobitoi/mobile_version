import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class ArchSampleLocalizations {
  ArchSampleLocalizations(this.locale);

  final Locale locale;

  static Future<ArchSampleLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return ArchSampleLocalizations(locale);
    });
  }

  static ArchSampleLocalizations of(BuildContext context) {
    return Localizations.of<ArchSampleLocalizations>(
        context, ArchSampleLocalizations);
  }

  String get todos => Intl.message(
        'Todos',
        name: 'todos',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'Show Active',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'Show Completed',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get newItemNameHint => Intl.message(
        'Item Name',
        name: 'newItemNameHint',
        args: [],
        locale: locale.toString(),
      );
  String get newSerialNumberHint => Intl.message(
        'Serial Number',
        name: 'newSerialNumberHint',
        args: [],
        locale: locale.toString(),
      );
  String get newIpAddressHint => Intl.message(
        'Ip Address',
        name: 'newIpAddressHint',
        args: [],
        locale: locale.toString(),
      );
  String get newCategoryHint => Intl.message(
        'Category',
        name: 'newCategoryHint',
        args: [],
        locale: locale.toString(),
      );
  String get newStatusHint => Intl.message(
        'Status',
        name: 'newStatusHint',
        args: [],
        locale: locale.toString(),
      );
  String get newLocationHint => Intl.message(
        'Location',
        name: 'newLocationHint',
        args: [],
        locale: locale.toString(),
      );
  String get newDOPHint => Intl.message(
        'Date Of Procurement',
        name: 'newDOPHint',
        args: [],
        locale: locale.toString(),
      );
  String get newDescHint => Intl.message(
        'Description',
        name: 'newDescHint',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get addItems => Intl.message(
        'Add Items',
        name: 'addItems',
        args: [],
        locale: locale.toString(),
      );

  String get editItem => Intl.message(
        'Edit Item',
        name: 'editItem',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterTodos => Intl.message(
        'Filter Todos',
        name: 'filterTodos',
        args: [],
        locale: locale.toString(),
      );

  String get deleteTodo => Intl.message(
        'Delete Todo',
        name: 'deleteTodo',
        args: [],
        locale: locale.toString(),
      );

  String get todoDetails => Intl.message(
        'Todo Details',
        name: 'todoDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptyItemNameError => Intl.message(
        'Please enter item name',
        name: 'emptyItemNameError',
        args: [],
        locale: locale.toString(),
      );

  String get emptySerialError => Intl.message(
        'Please enter serial number',
        name: 'emptySerialError',
        args: [],
        locale: locale.toString(),
      );
  String get emptyIpAddressError => Intl.message(
        'Please enter ip address',
        name: 'emptyIpAddressError',
        args: [],
        locale: locale.toString(),
      );
  String get emptyCategoryError => Intl.message(
        'Please choose category',
        name: 'emptyCategoryError',
        args: [],
        locale: locale.toString(),
      );
  String get emptyStatusError => Intl.message(
        'Please choose status',
        name: 'emptyStatusError',
        args: [],
        locale: locale.toString(),
      );
  String get emptLocationError => Intl.message(
        'Please enter location',
        name: 'emptLocationError',
        args: [],
        locale: locale.toString(),
      );
  String get emptDOPError => Intl.message(
        'Please enter Date of Prcurement',
        name: 'emptDOPError',
        args: [],
        locale: locale.toString(),
      );
  String get emptDescError => Intl.message(
        'Please enter Description',
        name: 'emptDescError',
        args: [],
        locale: locale.toString(),
      );
  String get notesHint => Intl.message(
        'Additional Notes...',
        name: 'notesHint',
        args: [],
        locale: locale.toString(),
      );

  String get completedTodos => Intl.message(
        'Completed Todos',
        name: 'completedTodos',
        args: [],
        locale: locale.toString(),
      );

  String get activeTodos => Intl.message(
        'Active Todos',
        name: 'activeTodos',
        args: [],
        locale: locale.toString(),
      );

  String todoDeleted(String task) => Intl.message(
        'Deleted "$task"',
        name: 'todoDeleted',
        args: [task],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteTodoConfirmation => Intl.message(
        'Delete this todo?',
        name: 'deleteTodoConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );
}

class ArchSampleLocalizationsDelegate
    extends LocalizationsDelegate<ArchSampleLocalizations> {
  @override
  Future<ArchSampleLocalizations> load(Locale locale) =>
      ArchSampleLocalizations.load(locale);

  @override
  bool shouldReload(ArchSampleLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");
}
