// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class NoteModel {
  final int id;
  final String title;
  final String content;
  final DateTime dateTime;
  final Color color;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.dateTime,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'date_time': dateTime.millisecondsSinceEpoch,
      'color': color.value,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date_time'] as int),
      color: Color(map['color'] as int),
    );
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? dateTime,
    Color? color,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
      color: color ?? this.color,
    );
  }
}
