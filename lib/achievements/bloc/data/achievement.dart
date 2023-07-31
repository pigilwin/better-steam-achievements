import 'package:flutter/material.dart';

@immutable
class Achievement {
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
}

typedef Achievements = List<Achievement>;
