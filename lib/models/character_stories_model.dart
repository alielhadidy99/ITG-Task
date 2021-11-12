class CharacterStoriesModel {
  CharacterStoriesModel({
    this.code,
    this.status,
    this.copyright,
    this.attributionText,
    this.attributionHtml,
    this.etag,
    this.data,
  });

  int? code;
  String? status;
  String? copyright;
  String? attributionText;
  String? attributionHtml;
  String? etag;
  Data? data;

  factory CharacterStoriesModel.fromJson(Map<String, dynamic> json) =>
      CharacterStoriesModel(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.offset,
    this.limit,
    this.total,
    this.count,
    this.results,
  });

  int? offset;
  int? limit;
  int? total;
  int? count;
  List<CharacterStoriesResult>? results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<CharacterStoriesResult>.from(
            json["results"].map((x) => CharacterStoriesResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class CharacterStoriesResult {
  CharacterStoriesResult({
    this.id,
    this.title,
    this.description,
    this.resourceUri,
    this.type,
    this.modified,
    this.thumbnail,
    this.creators,
    this.characters,
    this.series,
    this.comics,
    this.events,
    this.originalIssue,
  });

  int? id;
  String? title;
  String? description;
  String? resourceUri;
  String? type;
  String? modified;
  dynamic thumbnail;
  Creators? creators;
  Characters? characters;
  Characters? series;
  Characters? comics;
  Creators? events;
  OriginalIssue? originalIssue;

  factory CharacterStoriesResult.fromJson(Map<String, dynamic> json) =>
      CharacterStoriesResult(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        resourceUri: json["resourceURI"],
        type: json["type"],
        modified: json["modified"],
        thumbnail: json["thumbnail"],
        creators: Creators.fromJson(json["creators"]),
        characters: Characters.fromJson(json["characters"]),
        series: Characters.fromJson(json["series"]),
        comics: Characters.fromJson(json["comics"]),
        events: Creators.fromJson(json["events"]),
        originalIssue: OriginalIssue.fromJson(json["originalIssue"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "resourceURI": resourceUri,
        "type": type,
        "modified": modified,
        "thumbnail": thumbnail,
        "creators": creators!.toJson(),
        "characters": characters!.toJson(),
        "series": series!.toJson(),
        "comics": comics!.toJson(),
        "events": events!.toJson(),
        "originalIssue": originalIssue!.toJson(),
      };
}

class Characters {
  Characters({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  int? available;
  String? collectionUri;
  List<OriginalIssue>? items;
  int? returned;

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<OriginalIssue>.from(
            json["items"].map((x) => OriginalIssue.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "returned": returned,
      };
}

class OriginalIssue {
  OriginalIssue({
    this.resourceUri,
    this.name,
  });

  String? resourceUri;
  String? name;

  factory OriginalIssue.fromJson(Map<String, dynamic> json) => OriginalIssue(
        resourceUri: json["resourceURI"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
      };
}

class Creators {
  Creators({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  int? available;
  String? collectionUri;
  List<dynamic>? items;
  int? returned;

  factory Creators.fromJson(Map<String, dynamic> json) => Creators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<dynamic>.from(json["items"].map((x) => x)),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items!.map((x) => x)),
        "returned": returned,
      };
}
