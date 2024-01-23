import '../enums/query_type.dart';

class LyfCdnConfig {
  LyfCdnConfig._();
  static const String uriProdScheme = "https";
  static const String uriTestScheme = "http";

  static const String cdnProdHost = "cdn-lyf.herokuapp.com";
  static const String cdnTestHost = "10.81.8.118";
  // static const String cdnTestHost = "192.168.1.13";

  static const int cdnTestPort = 8000;

  static QueryType globalQueryType = QueryType.test;

  static getQueryType({
    QueryType? queryType,
  }) {
    return queryType ?? globalQueryType;
  }

  static getScheme({
    required QueryType queryType,
  }) {
    return (queryType != globalQueryType) ? uriProdScheme : uriTestScheme;
  }

  static getHost({
    required QueryType queryType,
  }) {
    return (queryType != globalQueryType) ? cdnProdHost : cdnTestHost;
  }

  static getPort({
    required QueryType queryType,
  }) {
    return (queryType != globalQueryType) ? null : cdnTestPort;
  }
}
