(:Egy epizód tömbjének előállítása az API-ból név alapján:)

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:media-type "application/json";

declare function local:getEpisodeByName($name){
    let $episodes := json-doc("http://stapi.co/api/v1/rest/episode?uid=EPMA0000001378")?*
    return $episodes[?title eq $name]
};

let $result :=local:getEpisodeByName("The Drumhead")

return array {$result}
