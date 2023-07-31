import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Achievement extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool completed;
  final int unlockTime;

  const Achievement(
    this.id,
    this.name,
    this.description,
    this.completed,
    this.unlockTime,
  );

  @override
  List<Object> get props => [
        id,
        name,
        description,
        completed,
        unlockTime,
      ];
}

typedef Achievements = List<Achievement>;
