(: Évadok ahol legalább 20 rész van validált XML dokumentumban, cím szerint növekvő sorrendben :)
xquery version "3.1";
import schema default element namespace "" at "task7.xsd";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace validate = "http://basex.org/modules/validate";

declare option output:method "xml";
declare option output:indent "yes";

declare function local:getSeasons(){
    let $seasons := json-doc("http://stapi.co/api/v1/rest/season/search?pageSize=100")?seasons?*
    return $seasons
};

let $seasons := local:getSeasons()

let $document := 
    <seasons xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="task7.xsd">
        {
        for $season in $seasons
        let $title := $season?title
        order by $title ascending
            return if ($season?numberOfEpisodes >= 20)
                then (
                <season season="{$season?series?title}" uid="{$season?series?uid}">
                <episodenumber>{$season?numberOfEpisodes}"</episodenumber>
                <title>{$season?title}</title>
                </season>)
          else ()
        }
    </seasons>
    
return validate {$document}
