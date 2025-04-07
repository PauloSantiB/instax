import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  String? picture;

   MyUser({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
  });

  /// Empty user whicj representes an unauthenticated user. para saber si el usuario esta logueadi o no
  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    picture: ''
  );

  // modify MyUser parameters clonar y modificar
  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? picture,
  }) {
    return MyUser(
      id: id ?? this.id, 
      email: email ?? this.email, 
      name: name ?? this.name, 
      picture: picture ?? this.picture
      );
  }
///Verificar si el usuario está vacío o no
  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether th current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;
/// Conversión a entidad de Firestore
    MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
      picture: picture,
    );
  }
///Conversión desde entidad de Firestore: 
///Convierte un objeto MyUserEntity (traído de Firestore) en un MyUser usable por la app.


  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id, 
      email: entity.email, 
      name: entity.name, 
      picture: entity.picture,
      );
  }
///Soporte para comparación con Equatable
  @override
  List<Object?> get props => [id, email, name, picture];

}