(:Összes epizód kilistázása JSON-ba:)
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:media-type "application/json";

declare function local:getEpisodesFromURI($url as xs:string?, $pageN as xs:integer?, $c as xs:integer?) {
    
    let $page := json-doc(concat($url, $pageN))
    let $max := $page?page?totalElements
    let $count := $c + array:size($page?episodes)
    return if ($count lt $max) then 
        array:join(($page?episodes, local:getEpisodesFromURI($url, $pageN+1, $count)))
    else 
        $page?episodes
};
let $URI := "http://stapi.co/api/v1/rest/episode/search?pageNumber="
let $result := local:getEpisodesFromURI($URI, 0, 0)

return $result
