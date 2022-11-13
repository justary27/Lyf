use super::cli_config_constants::*;
use crate::enums::query_type::QueryType;

/// Get the scheme being used as per the query_type.
pub (crate) fn get_scheme(query_type: &QueryType) -> &'static str {
    if *query_type == QueryType::TEST {
        CDN_TEST_SCHEME
    } else {
        CDN_PROD_SCHEME
    }
}

/// Get the host being used as per the query_type.
pub (crate) fn get_host(query_type: &QueryType) -> &'static str {
    if *query_type == QueryType::TEST {
        CDN_TEST_HOST
    } else {
        CDN_PROD_HOST
    }
}

/// Get the port being used as per the query_type.
pub (crate) fn get_port(query_type: &QueryType) -> &'static str {
    if *query_type == QueryType::TEST {
        CDN_TEST_PORT
    } else {
        ""
    }
}

/// Get the base uri for all requests as per the query_type.
pub (crate) fn get_base_uri(query_type: &QueryType) -> String {
    let mut base_uri: String = String::from(get_scheme(query_type));

    base_uri.push_str("://");
    base_uri.push_str(get_host(query_type));
    base_uri.push_str(get_port(query_type));

    base_uri
}
