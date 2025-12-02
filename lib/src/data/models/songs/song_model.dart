// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  String? songId;
  String? artitst;
  String? title;
  String? duration;
  DateTime? releaseDate;
  String? thumbanil;
  String? songAudio;
  String? order;
  bool? isFavorite = false;
  SongModel({
    this.songId,
    this.artitst,
    this.title,
    this.duration,
    this.releaseDate,
    this.thumbanil,
    this.songAudio,
    this.order,
  });

  SongModel.fromJson(Map<String, dynamic> json) {
    songId = json["id"];
    artitst = json["artist"];
    title = json["title"];
    duration = json["duration"];
    releaseDate = (json["releaseDate"] as Timestamp).toDate();
    thumbanil = json["thumbnail"];
    songAudio = json["song_audio"];
    order = json["order"];
  }
}
