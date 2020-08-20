# Constrained Search

Only search an allow list of webpages with google.


## Usability

Set this as default address bar search in google chrome: `http://search.tauinformatics.com?s=%s`

Add the chrome plugin [New Tab Redirect](https://chrome.google.com/webstore/detail/new-tab-redirect/icpgjfneehieebagbmdbhnlpiopdcmna) and redirect to `http://search.tauinformatics.com`


## TODO

- Allowlist also to be specified/overwritten in a text box?
- Free search with disallow list
- Search with both allow and disallow list
- Configurable groupings of lists, rather than just 1
- move DNS into `radiant-infra.git`


## Terraform

Backend defined in backend, provisioned in `radiant`.
