(:Egy epizód tömbjének előállítása az JSON fájlból név alapján:)
xquery version "3.1";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:media-type "application/json";

declare function local:getEpisodeByName($name){
    let $episodes := json-doc("task10.json")?*
    return $episodes[?title eq $name]
};

let $result :=local:getEpisodeByName("Prototype")

return $result
