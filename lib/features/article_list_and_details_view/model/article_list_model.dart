
//Currently, this model(Result) only stores what is visible on the screen; the rest is ignored.
import 'dart:convert';

ArticleListModel articleModelFromJson(String str) =>
    ArticleListModel.fromJson(json.decode(str));

String articleModelToJson(ArticleListModel data) => json.encode(data.toJson());

class ArticleListModel {
  String status;
  String copyright;
  int numResults;
  List<Result> results;

  ArticleListModel({
    required this.status,
    required this.copyright,
    required this.numResults,
    required this.results,
  });

  factory ArticleListModel.fromJson(Map<String, dynamic> json) =>
      ArticleListModel(
        status: json["status"],
        copyright: json["copyright"],
        numResults: json["num_results"],
        results: List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "copyright": copyright,
    "num_results": numResults,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  // String uri;
  // String url;
  // int id;
  // int assetId;
  // String source;
  DateTime publishedDate;
  // DateTime updated;
  String section;
  // String subsection;
  // String nytdsection;
  // String adxKeywords;
  // dynamic column;
  String byline;
  // String type;
  String title;
  String resultAbstract;
  // List<String> desFacet;
  // List<String> orgFacet;
  // List<String> perFacet;
  // List<String> geoFacet;
  List<Media> media;
  // int etaId;

  Result({
    // required this.uri,
    // required this.url,
    // required this.id,
    // required this.assetId,
    // required this.source,
    required this.publishedDate,
    // required this.updated,
    required this.section,
    // required this.subsection,
    //  required this.nytdsection,
    //  required this.adxKeywords,
    //  required this.column,
    required this.byline,
    //   required this.type,
    required this.title,
    required this.resultAbstract,
    // required this.desFacet,
    // required this.orgFacet,
    // required this.perFacet,
    // required this.geoFacet,
    required this.media,
    // required this.etaId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    // uri: json["uri"],
    // url: json["url"],
    // id: json["id"],
    // assetId: json["asset_id"],
    // source: json["source"],
    publishedDate: DateTime.parse(json["published_date"]),
    // updated: DateTime.parse(json["updated"]),
    section: json["section"],
    // subsection: json["subsection"],
    // nytdsection: json["nytdsection"],
    // adxKeywords: json["adx_keywords"],
    // column: json["column"],
    byline: json["byline"],
    // type: json["type"],
    title: json["title"],
    resultAbstract: json["abstract"],
    // desFacet: List<String>.from(json["des_facet"].map((x) => x)),
    // orgFacet: List<String>.from(json["org_facet"].map((x) => x)),
    // perFacet: List<String>.from(json["per_facet"].map((x) => x)),
    // geoFacet: List<String>.from(json["geo_facet"].map((x) => x)),
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
    //  etaId: json["eta_id"],
  );

  Map<String, dynamic> toJson() => {
    // "uri": uri,
    // "url": url,
    // "id": id,
    // "asset_id": assetId,
    // "source": source,
    "published_date":
        "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
    //  "updated": updated.toIso8601String(),
    "section": section,
    // "subsection": subsection,
    // "nytdsection": nytdsection,
    // "adx_keywords": adxKeywords,
    // "column": column,
    "byline": byline,
    //   "type": type,
    "title": title,
    "abstract": resultAbstract,
    // "des_facet": List<dynamic>.from(desFacet.map((x) => x)),
    // "org_facet": List<dynamic>.from(orgFacet.map((x) => x)),
    // "per_facet": List<dynamic>.from(perFacet.map((x) => x)),
    // "geo_facet": List<dynamic>.from(geoFacet.map((x) => x)),
    // "media": List<dynamic>.from(media.map((x) => x.toJson())),
    //  "eta_id": etaId,
  };

  // Helper methods
  String get thumbnailUrl {
    if (media.isNotEmpty && media.first.mediaMetadata.isNotEmpty) {
      return media.first.mediaMetadata.first.url;
    }
    return '';
  }

  String get mediumImageUrl {
    if (media.isNotEmpty && media.first.mediaMetadata.length > 1) {
      return media.first.mediaMetadata[1].url;
    }
    return thumbnailUrl;
  }

  String get largeImageUrl {
    if (media.isNotEmpty && media.first.mediaMetadata.length > 2) {
      return media.first.mediaMetadata[2].url;
    }
    return mediumImageUrl;
  }
}

class Media {
  // String type;
  // String subtype;
   String caption;
  // String copyright;
  // int approvedForSyndication;
  List<MediaMetadatum> mediaMetadata;

  Media({
    // required this.type,
    // required this.subtype,
     required this.caption,
    // required this.copyright,
    // required this.approvedForSyndication,
    required this.mediaMetadata,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    // type: json["type"],
    // subtype: json["subtype"],
     caption: json["caption"],
    // copyright: json["copyright"],
    // approvedForSyndication: json["approved_for_syndication"],
    mediaMetadata: List<MediaMetadatum>.from(
      json["media-metadata"].map((x) => MediaMetadatum.fromJson(x)),
    ),
  );



  // bool get isApprovedForSyndication => approvedForSyndication == 1;
}

class MediaMetadatum {
  String url;
 // Format format;
  // int height;
  // int width;

  MediaMetadatum({
    required this.url,
  //  required this.format,
    // required this.height,
    // required this.width,
  });

  factory MediaMetadatum.fromJson(Map<String, dynamic> json) => MediaMetadatum(
    url: json["url"],
  //  format: formatValues.map[json["format"]]!,
    // height: json["height"],
    // width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  //  "format": formatValues.reverse[format],
    // "height": height,
    // "width": width,
  };
}

// enum Format { mediumThreeByTwo210, mediumThreeByTwo440, standartThumbnail }

// final formatValues = EnumValues({
//   "mediumThreeByTwo210": Format.mediumThreeByTwo210,
//   "mediumThreeByTwo440": Format.mediumThreeByTwo440,
//   "Standard Thumbnail": Format.standartThumbnail,
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
