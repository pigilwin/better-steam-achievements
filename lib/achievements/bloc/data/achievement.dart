import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Achievement extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool completed;
  final int unlockTime;
  final String iconUrl;
  final String grayIconUrl;
  final bool hidden;

  const Achievement(
    this.id,
    this.name,
    this.description,
    this.completed,
    this.unlockTime,
    this.iconUrl,
    this.grayIconUrl,
    this.hidden,
  );

  @override
  List<Object> get props => [
        id,
        name,
        description,
        completed,
        unlockTime,
        iconUrl,
        grayIconUrl,
        hidden,
      ];
}

typedef Achievements = List<Achievement>;
