part of 'scanner_bloc.dart';

sealed class ScannerEvent {}

class ScannerFectchEvent extends ScannerEvent {
  final ScanResponse response;
  ScannerFectchEvent({required this.response});
}
