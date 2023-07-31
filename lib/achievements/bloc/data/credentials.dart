import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Credentials extends Equatable {
  factory Credentials.empty() {
    return const Credentials('', '');
  }

  final String steamId;
  final String steamApiKey;

  const Credentials(this.steamId, this.steamApiKey);

  bool get isEmpty => steamApiKey.isEmpty || steamId.isEmpty;

  @override
  List<Object> get props => [steamId, steamApiKey];
}
