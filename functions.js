function constructSearch(url, terms, allowed_sites) {
  url += "?q="
  url += encodeURIComponent(terms + " ")

  for (const site of allowed_sites) {
    url += "site%3a" + site + "+OR+"
  }

  // get rid of extra +OR+
  if (url.slice(-4) == "+OR+") {
    url = url.slice(0, -4)
  }
  return url
};

function constrainedSearchRedirect(query) {
  // TODO: take multiline site allowlist input from a text box

  var baseSearchUrl = "http://google.com/search";
  var allowed_sites_file = "/allowed_sites.txt";

  jQuery.get(allowed_sites_file, function( sitedata ) {
    var allowedSites = sitedata.trim().split(/\s+/)
    var searchUrl = constructSearch(baseSearchUrl, query, allowedSites)
    window.location.assign(searchUrl)
  })
}

function getsearchgroupdata() {

  var sitesFile = "sites.json";

  jQuery.getJSON(sitesFile, function( sitesdata ) {

    // compile checkbox template
    var source = document.getElementById("checkbox-site-checklist").innerHTML;
    var checkboxTemplate = Handlebars.compile(source);

    // console.log(template({ doesWhat: "is cool!" }));

    console.log(sitesdata)

    document.getElementById('checkbox-rendered-template').innerHTML = checkboxTemplate({ sitesdata: sitesdata });
  })
}

