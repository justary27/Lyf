use std::collections::HashMap;
use enums::query_type::QueryType;
use helpers::http_helpers::{self};

mod api;
mod models;
mod config;
mod helpers;
mod enums;
mod endpoints;


fn main() {
    let mut creds: HashMap<String, String> = HashMap::new();

    creds.insert("email".to_string(), "aryan_r@ch.iitr.ac.in".to_string());
    creds.insert("password".to_string(), "27a20048".to_string());

    let client : reqwest::Client = reqwest::Client::new();

    let x : http_helpers::http_helper = http_helpers::http_helper{client};

    x.do_post_req(endpoints::user_endpoints::login_ep(&QueryType::PROD), &creds);
    
}
