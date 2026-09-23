import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'ghibli_models.g.dart';

List<Ghibli> ghibliFromJson(String str) => List<Ghibli>.from(json.decode(str).map((x) => Ghibli.fromJson(x)));

String ghibliToJson(List<Ghibli> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Ghibli {
    @JsonKey(name: "id")
    final String? id;
    @JsonKey(name: "title")
    final String? title;
    @JsonKey(name: "original_title")
    final String? originalTitle;
    @JsonKey(name: "original_title_romanised")
    final String? originalTitleRomanised;
    @JsonKey(name: "image")
    final String? image;
    @JsonKey(name: "movie_banner")
    final String? movieBanner;
    @JsonKey(name: "description")
    final String? description;
    @JsonKey(name: "director")
    final String? director;
    @JsonKey(name: "producer")
    final String? producer;
    @JsonKey(name: "release_date")
    final String? releaseDate;
    @JsonKey(name: "running_time")
    final String? runningTime;
    @JsonKey(name: "rt_score")
    final String? rtScore;
    @JsonKey(name: "people")
    final List<String>? people;
    @JsonKey(name: "species")
    final List<String>? species;
    @JsonKey(name: "locations")
    final List<String>? locations;
    @JsonKey(name: "vehicles")
    final List<String>? vehicles;
    @JsonKey(name: "url")
    final String? url;

    Ghibli({
        this.id,
        this.title,
        this.originalTitle,
        this.originalTitleRomanised,
        this.image,
        this.movieBanner,
        this.description,
        this.director,
        this.producer,
        this.releaseDate,
        this.runningTime,
        this.rtScore,
        this.people,
        this.species,
        this.locations,
        this.vehicles,
        this.url,
    });

    factory Ghibli.fromJson(Map<String, dynamic> json) => _$GhibliFromJson(json);

    Map<String, dynamic> toJson() => _$GhibliToJson(this);

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'title': title,
        'original_title': originalTitle,
        'original_title_romanised': originalTitleRomanised,
        'image': image,
        'movie_banner': movieBanner,
        'description': description,
        'director': director,
        'producer': producer,
        'release_date': releaseDate,
        'running_time': runningTime,
        'rt_score': rtScore,
        'people': people != null ? json.encode(people) : null,
        'species': species != null ? json.encode(species) : null,
        'locations': locations != null ? json.encode(locations) : null,
        'vehicles': vehicles != null ? json.encode(vehicles) : null,
        'url': url,
      };
    }

    factory Ghibli.fromMap(Map<String, dynamic> map) {
      return Ghibli(
        id: map['id'] as String?,
        title: map['title'] as String?,
        originalTitle: map['original_title'] as String?,
        originalTitleRomanised: map['original_title_romanised'] as String?,
        image: map['image'] as String?,
        movieBanner: map['movie_banner'] as String?,
        description: map['description'] as String?,
        director: map['director'] as String?,
        producer: map['producer'] as String?,
        releaseDate: map['release_date'] as String?,
        runningTime: map['running_time'] as String?,
        rtScore: map['rt_score'] as String?,
        people: map['people'] != null
            ? List<String>.from(json.decode(map['people'] as String))
            : null,
        species: map['species'] != null
            ? List<String>.from(json.decode(map['species'] as String))
            : null,
        locations: map['locations'] != null
            ? List<String>.from(json.decode(map['locations'] as String))
            : null,
        vehicles: map['vehicles'] != null
            ? List<String>.from(json.decode(map['vehicles'] as String))
            : null,
        url: map['url'] as String?,
      );
    }
}
