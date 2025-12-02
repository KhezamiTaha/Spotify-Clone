// ignore_for_file: public_member_api_docs, sort_constructors_first

class SongEntity {
   String? songId;
  String? artitst;
  String? title;
  String? duration;
  DateTime? releaseDate;
  String? thumbanil;
  String? songAudio;
  String? order;
  bool? isFavorite = false;
  SongEntity({
    this.songId,
    this.artitst,
    this.title,
    this.duration,
    this.releaseDate,
    this.thumbanil,
    this.songAudio,
    this.order,
  });
}
