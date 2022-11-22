(:Azon epizódok mutatása validált XML-ben, amelyek rendelkeznek Angol, Német és Olasz címmel is:)
xquery version "3.1";
import schema default element namespace "" at "task5.xsd";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace validate = "http://basex.org/modules/validate";

declare function local:getEpisodes(){
    let $episodes := json-doc("task10.json")?*
    return $episodes
};

let $eps :=local:getEpisodes()

let $document := 
    <episodes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="task5.xsd">
        {
          for $ep in $eps
          return if(not(fn:empty($ep?title)) and not(fn:empty($ep?titleGerman)) and not(fn:empty($ep?titleItalian))) then (
          <episode uid="{$ep?uid}" seasonnum="{$ep?seasonNumber}" epnum="{$ep?episodeNumber}">
            <title>{$ep?title}</title>
            <titlegerman>{$ep?titleGerman}</titlegerman>
            <titleitalian>{$ep?titleItalian}</titleitalian>
            <seasontitle>{$ep?season?title}</seasontitle>
          </episode>)
          else ()
        }
    </episodes>
    
return validate {$document}
