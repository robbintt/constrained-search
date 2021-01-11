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

function constrainedSearchRedirect(query, sites) {
  var baseSearchUrl = "http://google.com/search";

  var searchUrl = constructSearch(baseSearchUrl, query, sites)
  window.location.assign(searchUrl)
}

function constrainedSearchRedirectFromFile(query) {
  var baseSearchUrl = "http://google.com/search";
  var allowed_sites_file = "allowed_sites.txt";

  jQuery.get(allowed_sites_file, function( sitedata ) {
    var allowedSites = sitedata.trim().split(/\s+/)
    var searchUrl = constructSearch(baseSearchUrl, query, allowedSites)
    window.location.assign(searchUrl)
  })
}

async function getSitesData(sitesFile) {
  var sitesdata = jQuery.getJSON(sitesFile, function( sitesdata ) {
    //console.log(sitesdata)
  })
  return await sitesdata
}

async function populateTemplateFromSearchGroupData(sitesdata) {
  // compile checkbox template
  var source = document.getElementById("checkbox-site-checklist").innerHTML;
  var checkboxTemplate = Handlebars.compile(source);
  // render checkbox template
  document.getElementById('checkbox-rendered-template').innerHTML = checkboxTemplate({ sitesdata: sitesdata });
}

function sitesdataRemapper(sitesdata) {
  // fix the handlebars json list to actually use mapped names
  // handlebars by default can't iterate on an objects keys without explicitly saying them
  // probably could have fixed this with a custom handler in handlebars
  var mapped_sitedata = {};
  sitesdata.forEach(function(category) {
    mapped_sitedata[category.name] = category.sites
  });
  return mapped_sitedata
}

function getSitesForCheckedCategories(checkboxclass, sitesdata) {
  //console.log($( checkboxclass ));
  // fix expanded datastructure delivered to populate handlebars template
  sitesdata_object = sitesdataRemapper(sitesdata)
  var sites = []
  $( checkboxclass ).each(async function( index ) {
    if (this.checked) {
      //console.log(this.name)
      sites.push(...sitesdata_object[this.name])
    }
  });
  return sites
}
