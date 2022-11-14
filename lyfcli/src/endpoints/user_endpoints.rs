use crate::config::cli_config_functions::*;
use crate::enums::query_type::*;

pub (crate) fn login_ep(query_type : &QueryType)->String{
    let mut login = get_base_uri(query_type);
    login.push_str("/logIn");

    login
}

// pub (crate) fn signup_ep(query_type : &QueryType)->String{
//     let mut signup = get_base_uri(query_type);
//     signup.push_str("/signUp");

//     signup
// }
