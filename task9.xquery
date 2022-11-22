(:Egy adott epizódból egy adott karakter információinak leírása validált XML formátumban hibakezeléssel:)
xquery version "3.1";
import schema default element namespace "" at "task9.xsd";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace validate = "http://basex.org/modules/validate";

declare option output:method "xml";
declare option output:indent "yes";

declare function local:getEpisodeByName($name){
    let $episodes := json-doc("task10.json")?*
    return $episodes[?title eq $name]
};

declare function local:getCharacterByNameFromEpisode($title, $name){
    let $ep := local:getEpisodeByName($title)
    let $uid := $ep?uid
    let $episode := json-doc(concat("http://stapi.co/api/v1/rest/episode?uid=", $uid))
    let $characters := $episode?episode?characters?*
    return $characters[?name eq $name]
};

let $episodetitle := "The Drumhead"
let $charactername := "William T. Riker"
let $character := local:getCharacterByNameFromEpisode($episodetitle, $charactername)

let $document := 
    if($character?name eq $charactername) then
    <performer xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="task9.xsd" title="{$episodetitle}" uid="{$character?uid}">
            <name>{$character?name}</name>
            <birthday>{$character?yearOfBirth}-{$character?monthOfBirth}-{$character?dayOfBirth}</birthday>
            <gender>{$character?gender}</gender>
            <height>{$character?height}</height>
    </performer>
    else(
        <performer xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="task9.xsd" title="{$episodetitle}" uid="-">
            <error>Unknown! {$charactername} not found in this episode!</error>
    </performer>
    )
    
return validate {$document}
