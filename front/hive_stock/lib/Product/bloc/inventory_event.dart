part of 'inventory_bloc.dart';

sealed class InventoryEvent {}

final class InventoryFetched extends InventoryEvent {}

final class InventoryStatsFetched extends InventoryEvent {}
