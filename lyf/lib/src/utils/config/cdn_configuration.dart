import '../enums/query_type.dart';

class LyfCdnConfig {
  LyfCdnConfig._();
  static const String uriProdScheme = "https";
  static const String uriTestScheme = "http";

  static const String cdnProdHost = "cdn-lyf.herokuapp.com";
  static const String cdnTestHost = "10.38.1.92:8000";

  static QueryType globalQueryType = QueryType.prod;

  static getQueryType({
    QueryType? queryType,
  }) {
    return queryType ?? globalQueryType;
  }

  static getScheme({
    required QueryType queryType,
  }) {
    return (queryType == globalQueryType) ? uriProdScheme : uriTestScheme;
  }

  static getHost({
    required QueryType queryType,
  }) {
    return (queryType == globalQueryType) ? cdnProdHost : cdnTestHost;
  }
}
