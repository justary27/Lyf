use crate::enums::query_type::QueryType;

// Available Schemes:
pub(crate) const CDN_PROD_SCHEME: &str = "https";
pub(crate) const CDN_TEST_SCHEME: &str = "http";

// Available hosts:
pub(crate) const CDN_PROD_HOST: &str = "cdn-lyf.herokuapp.com";
pub(crate) const CDN_TEST_HOST: &str = "127.0.0.1";

// Available ports:
pub(crate) const CDN_TEST_PORT: &str = ":8000";

/// The default query type
pub(crate) const DEFAULT_QUERY_TYPE: QueryType = QueryType::TEST;
