(: Simplifies the ecrm.owl file by removing some OWL constructs. Usage:
- Get https://raw.github.com/erlangen-crm/ecrm/master/ecrm.owl
- Download the Saxon xquery processor from http://www.saxonica.com
- Run eg:
  Query ecrm-simplify.xq                 > ecrm-inverse.owl
  Query ecrm-simplify.xq keep=transitive > ecrm-inverse-transitive.owl

Always keeps owl:inverseOf and owl:SymmetricProperty (self-inverses): they are an innate part of CRM.
Parameter keep= gives a comma-separated list of other features to keep:
- transitive:  owl:TransitiveProperty
- restriction: owl:Restriction (blank-node subClassOf)
- functional:  owl:FunctionalProperty, owl:InverseFunctionalProperty
- disjoint:    owl:disjointWith

Author: vladimir.alexiev@ontotext.com, 18-Dec-2012
Last updated: 12-Feb-2014
:)

(:
References
- http://en.wikibooks.org/wiki/XQuery/Filtering_Nodes : remove and rename elements
- http://www.saxonica.com/documentation/using-xquery/commandline.xml
- XQuery (O'Reilly 2007) p135 "Controlling Namespace Declarations in Your Results"
:)

declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace owl="http://www.w3.org/2002/07/owl#";
declare namespace saxon="http://saxon.sf.net/";
(: declare copy-namespaces no-preserve, inherit; :)
declare option saxon:output "indent=yes";

declare option saxon:default "''";
declare variable $keep external;

declare variable $transitive as xs:boolean  := matches($keep,"transitive");
declare variable $restriction as xs:boolean := matches($keep,"restriction");
declare variable $functional as xs:boolean  := matches($keep,"functional");
declare variable $disjoint as xs:boolean    := matches($keep,"disjoint");

declare function local:process($n as node()) as node()?
{
  if (not($n instance of element())) then $n
  else
    let $name := name($n)
    return
      if ($name="owl:disjointWith" and not ($disjoint)
        or $name="rdfs:subClassOf" and $n/owl:Restriction and not($restriction))
        then ()
      (: ECRM doesn't have DataProperties with special traits, so if we find such, we replace with simple ObjectProperty :)
      else if ($name="owl:TransitiveProperty" and not($transitive)
        or $name="owl:FunctionalProperty" and not($functional)
        or $name="owl:InverseFunctionalProperty" and not($functional))
        then element {QName(namespace-uri($n),"owl:ObjectProperty")}
          {$n/@*,
          for $c in $n/node() return local:process($c)}
      else element {node-name($n)}
          {$n/@*,
          for $c in $n/node() return local:process($c)}
};

<rdf:RDF
  xmlns:ecrm="http://erlangen-crm.org/current/"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xml:base="http://erlangen-crm.org/current/">
{
  for $n in doc("ecrm.owl")/rdf:RDF/* return local:process($n)
}
</rdf:RDF>
