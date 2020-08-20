/* Goal:
 * - Add a list of acceptable sites to the contents of a textbox for search
 *
 * References:
 * ultimate google search params: https://moz.com/blog/the-ultimate-guide-to-the-google-search-parameters
 *
 * URL:
 * https://www.google.com/search?source=hp&ei=Tt89X-OJNtXB7gKxiLvIDA
 * &q=site%3Areddit.com+OR+site%3Anews.ycombinator.com+potato
 *
 * URL:
 * https://www.google.com/search?ei=Wd89X8HNOMPv9APdlL-YCQ&q=site%3Areddit.com+OR+site%3Anews.ycombinator.com+potato&oq=site%3Areddit.com+OR+site%3Anews.ycombinator.com+potato&gs_lcp=CgZwc3ktYWIQA1D71gxYnN0MYKbeDGgCcAB4AIABTYgBowSSAQE5mAEAoAEBqgEHZ3dzLXdpesABAQ&sclient=psy-ab&ved=0ahUKEwiB3sfK3ajrAhXDN30KHV3KD5MQ4dUDCAw&uact=5
*/

// If a s= querystring is provided, we should just pass it on
// Simplify: if any querystring is provided, process it right away
// from: https://stackoverflow.com/questions/523266/how-can-i-get-a-specific-parameter-from-location-search/42316411#42316411
const params = location.search.slice(1).split('&').reduce((acc, s) => {
    const [k, v] = s.split('=')
    return Object.assign(acc, {[k]: v})
}, {})

if (params.hasOwnProperty('s')) {
  // TODO: why decode and encode to accomodate the other use of this method
  constrainedSearchRedirect(decodeURIComponent(params.s))
}

// Enter key should trigger js instead of submitting form
$("input#query").keypress(function(event) {
  if (event.keyCode === 13) {
    // don't submit the form
    event.preventDefault();
    // do click the button
    $("button").click();
  }
});

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

$("button").click(function() {
  var query = $( "input#query" ).val();
  constrainedSearchRedirect(query)
});
