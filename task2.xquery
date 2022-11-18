(: Epizódok szűrése egy megadott Season alapján :)

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare option output:method "json";
declare option output:media-type "application/json";

declare function local:getSeasonEpisodes($stitle){
    let $episodes := json-doc("http://stapi.co/api/v1/rest/episode/search?pageSize=100")?episodes?*
    return $episodes[?season?title = $stitle]
};
let $sepisodes :=local:getSeasonEpisodes("TOS Season 2")

return array {
    for $episode in $sepisodes
    where exists($episode?title)
    order by $episode?episodeNumber ascending
    return map {
        "title": $episode?title,
        "episodeNumber": $episode?episodeNumber,
        "seasonNumber": $episode?seasonNumber,
        "UID": $episode?uid
    }
}
