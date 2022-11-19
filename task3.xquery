(: Hány zene van összesen :)

document {
    <result>Number of Soundtracks: {fn:count(fn:json-doc("http://stapi.co/api/v1/rest/soundtrack/search?pageSize=100")?soundtracks?*)}</result>
}
