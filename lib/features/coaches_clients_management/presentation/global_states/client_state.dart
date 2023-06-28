import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class Clientstate {
  List<User> clients;
  Clientstate({
    this.clients = const [],
  });

  Clientstate copyWith({List<User>? clients}) {
    return Clientstate(
      clients: clients ?? this.clients,
    );
  }
}
