(:Epizódok az legalább az ötödik évadtól validált XML formátumban:)
xquery version "3.1";
import schema default element namespace "" at "task7.xsd";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace validate = "http://basex.org/modules/validate";

declare option output:method "xml";
declare option output:indent "yes";

declare function local:getEpisodes(){
    let $episodes := json-doc("task10.json")?*
    return $episodes
};

let $episodes := local:getEpisodes()

let $document := 
    <episodes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="task7.xsd">
        {
        for $episode in $episodes
        let $title := $episode?title
        order by $title ascending
            return if ($episode?seasonNumber >= 5)
                then (
                <episode season="{$episode?season?title}" uid="{$episode?season?uid}" number="{$episode?seasonNumber}">
                <episodeNumber>{$episode?episodeNumber}</episodeNumber>
                <title>{$episode?title}</title>
                </episode>)
          else ()
        }
    </episodes>
    
return validate {$document}
