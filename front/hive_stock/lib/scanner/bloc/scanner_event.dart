part of 'scanner_bloc.dart';

sealed class ScannerEvent {}

class ScannerFectchIncommingEvent extends ScannerEvent {
  final int id;
  ScannerFectchIncommingEvent({required this.id});
}

class ScannerFectchOutgoingEvent extends ScannerEvent {
  final int id;
  ScannerFectchOutgoingEvent({required this.id});
}
