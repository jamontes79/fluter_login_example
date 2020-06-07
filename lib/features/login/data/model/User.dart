import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final int id;
  final String user;

  User({
    @required this.id,
    @required this.user,
  });

  @override
  List<Object> get props => [id, user];
}
