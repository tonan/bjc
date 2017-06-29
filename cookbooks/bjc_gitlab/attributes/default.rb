default['omnibus-gitlab']['gitlab_rb']['gitlab-rails']['omniauth_providers'] = [
  {
    "name" => "github",
    "app_id" => "400c296d2ddae0e36b9a",
    "app_secret" => "00b1987a4bd0a4909042049259583e1c1a29be96",
    "url" => "https://github.com/",
    "args" => { "scope" => "user:email" }
  }
]