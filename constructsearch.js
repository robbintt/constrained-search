/*
 * Goal:
 * - Add a list of acceptable sites to the contents of a textbox for search
 *
 * References:
 * ultimate google search params: https://moz.com/blog/the-ultimate-guide-to-the-google-search-parameters
 *
 *
 * A url:
 * https://www.google.com/search?source=hp&ei=Tt89X-OJNtXB7gKxiLvIDA
 * &q=site%3Areddit.com+OR+site%3Anews.ycombinator.com+potato
 *
 *
 * https://www.google.com/search?ei=Wd89X8HNOMPv9APdlL-YCQ&q=site%3Areddit.com+OR+site%3Anews.ycombinator.com+potato&oq=site%3Areddit.com+OR+site%3Anews.ycombinator.com+potato&gs_lcp=CgZwc3ktYWIQA1D71gxYnN0MYKbeDGgCcAB4AIABTYgBowSSAQE5mAEAoAEBqgEHZ3dzLXdpesABAQ&sclient=psy-ab&ved=0ahUKEwiB3sfK3ajrAhXDN30KHV3KD5MQ4dUDCAw&uact=5
*/

var allowed_sites = ["reddit.com", "news.ycombinator.com"];

var search_url = "http://google.com/search";

function constructSearch(url, terms, allowed_sites) {
  url += "?q="
  console.log(url)
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

$("button").click(function() {
  var searchUrl = constructSearch(search_url, "clojure source", allowed_sites);
  console.log(searchUrl);
  window.location.assign(searchUrl);
  // window.location.assign("http://google.com/search?q=potato");
});
