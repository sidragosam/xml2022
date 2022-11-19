(: Egy adott epizódból a férfiak megszámolása, majd leírása egy validált XML dokumentumban :)
xquery version "3.1";
import schema default element namespace "" at "task6.xsd";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace validate = "http://basex.org/modules/validate";

declare option output:method "xml";
declare option output:indent "yes";

declare function local:getPerformers(){
    let $performers := json-doc("http://stapi.co/api/v1/rest/episode?uid=EPMA0000001378")?episode?performers?*
    return $performers
};

let $performers := local:getPerformers()

let $males := $performers ,
    $gender := "M",
    $countMales := for $w in $males
                        where exists($w?gender) and $w?gender eq $gender
                        return fn:count($w?uid)

let $document := 
    <performers xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="task6.xsd" males="{fn:count($countMales)}">
        {
          for $performer in $performers
          return if($performer?gender eq "M") then (
          <performer uid="{$performer?uid}">
            <name>{$performer?name}</name>
            <birthname>{$performer?birthName}</birthname>
            <gender>{$performer?gender}</gender>
            <dateofbirth>{$performer?dateOfBirth}</dateofbirth>
          </performer>)
          else ()
        }
    </performers>
    
return validate {$document}
