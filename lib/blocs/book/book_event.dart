part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();
}

final class LoadBook extends BookEvent {
  @override
  List<Object?> get props => [];
}

