# Constrained Search

Only search an allow list of webpages with google.


## Usability

Set this as default address bar search in google chrome: `http://search.tauinformatics.com?s=%s`

Add the chrome plugin [New Tab Redirect](https://chrome.google.com/webstore/detail/new-tab-redirect/icpgjfneehieebagbmdbhnlpiopdcmna) and redirect to `http://search.tauinformatics.com`


## TODO

0. validate json ASAP, flash error message on invalid json, link to beautifier for debug?
1. fold-down shows sites.json and accepts custom sites.json payload
  - stored to cookies
  - also serves as exporter
  - can edit json directly for now... eventually take yaml maybe for user sanity
2. identity login will store your sites.json
  - then when you login through google/facebook, load your sites.json
  - multiple sites.json
  - sites.json history
3. add "default checked categories" to sites.json data structure
4. add "uncheck all" and "check all" buttons on site
  - update cookie on these events too
5. add "save checked" option
  - site can default to none checked, all checked, or "last checked"
6. allow to specify categories in querystring
  - then subset can be used in bar search on different browsers, like work/home



## TODO (old)

- Free search with disallow list
- Search with both allow and disallow list
- Configurable groupings of lists, rather than just 1
- move DNS into `radiant-infra.git`


## Terraform

Backend defined in backend, provisioned in `radiant`.
