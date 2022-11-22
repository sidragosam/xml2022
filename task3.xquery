(: Hány epizód van összesen :)
xquery version "3.1";
document {
    <result>Number of Episodes: {fn:count(fn:json-doc("task10.json")?*)}</result>
}
