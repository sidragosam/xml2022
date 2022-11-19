(:Azon zeneszámok mutatása XML-ben amelyek rendelkeznek kiadási dátummal:)
xquery version "3.1";
import schema default element namespace "" at "task4.xsd";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace validate = "http://basex.org/modules/validate";

declare function local:getSoundtracksWithReleaseDate(){
    let $soundtracks := json-doc("http://stapi.co/api/v1/rest/soundtrack/search?pageSize=100")?soundtracks?*
    return $soundtracks[?releaseDate  != "null"]
};

let $songs :=local:getSoundtracksWithReleaseDate()

let $document := 
    <soundtracks xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="task4.xsd">
        {
          for $song in $songs
          return 
          <soundtrack uid="{$song?uid}">
            <title>{$song?title}</title>
                <releasedate>{$song?releaseDate}</releasedate>
          </soundtrack>
        }
    </soundtracks>
    
return validate {$document}
