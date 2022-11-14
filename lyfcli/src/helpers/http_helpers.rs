use std::collections::HashMap;


pub(crate) struct http_helper {
    pub(crate) client: reqwest::Client,
}

impl http_helper {
    async fn do_get_request(self, uri: String, body: &HashMap<String, String>)-> Result<(), Box<dyn std::error::Error>> {
        let response = self.client.get(uri).json(body).send().await?.json().await?;

        println!("{:#?}", response);
        Ok(())
    }

    pub(crate) async fn do_post_req(self, uri: String, body: &HashMap<String, String>) -> Result<(), Box<dyn std::error::Error>>{
        let response = self.client.post(uri).json(body).send().await?.json().await?;

        println!("{:#?}", response);

        Ok(())
    }
}
