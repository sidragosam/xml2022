(:Azon epizódok mutatása validált XML-ben, amelyek rendelkeznek olasz címmel Season és Epizód szerint növekvő sorrendben:)
xquery version "3.1";
import schema default element namespace "" at "task4-5.xsd";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace validate = "http://basex.org/modules/validate";

declare function local:getItalianEpisodes(){
    let $episodes := json-doc("task10.json")?*
    return $episodes[?titleItalian  != "null"]
};

let $episodes :=local:getItalianEpisodes()

let $document := 
    <episodes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="task4-5.xsd">
        {
          for $episode in $episodes
          let $seasonnum := $episode?seasonNumber
          let $episodenum := $episode?episodeNumber
          order by $seasonnum ascending, $episodenum ascending
          return 
          <episode uid="{$episode?uid}">
            <title>{$episode?title}</title>
            <titleItalian>{$episode?titleItalian}</titleItalian>
            <seasonNumber>{$seasonnum}</seasonNumber>
            <episodeNumber>{$episodenum}</episodeNumber>
          </episode>
        }
    </episodes>
    
return validate {$document}
