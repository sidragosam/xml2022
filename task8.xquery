(: Star Trek epizódok mutatása HTML formátumban :)
xquery version "3.1";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";

declare function local:getEpisodes(){
    let $episodes := json-doc("task10.json")?*
    return $episodes
};

let $episodes := local:getEpisodes()

let $document := 

<html>
    <head>
        <title>Star Trek Filmek</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="task8.css"/>
    </head>
    <body>
    
      <p class="text-center">Star Trek Filmek:</p>
            <section class="container">
                <div class="row">
                    <div class="col-12">
                    <div class="table-responsive stapi-table-div">
                        <table class="table stapi">
                            <thead class="table stapi-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Cím</th>
                                        <th>Évad</th>
                                        <th>Rész</th>
                                        <th>Cselekmény eleje</th>
                                        <th>Cselekmény vége</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        for $episode in $episodes
                                        let $title := $episode?title
                                        let $seasonnum := $episode?seasonNumber
                                        let $episodenum := $episode?episodeNumber
                                        order by $seasonnum ascending, $episodenum ascending, $title ascending
                                        count $i
                                        return
                                            <tr>
                                                <td>{$i}</td>
                                                <td>{$episode?title}</td>
                                                <td>[{$episode?seasonNumber}] {$episode?season?title}</td>
                                                <td>{$episode?episodeNumber}</td>
                                                <td>{$episode?yearFrom}</td>
                                                <td>{$episode?yearTo}</td>
                                            </tr>
                                    }
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
            <footer>
                Ignéczi Tibor | UM72V9
            </footer>
    </body>
</html>

return $document
