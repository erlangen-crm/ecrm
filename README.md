- ecrm.owl: ECRM ontology, using namespace http://erlangen-crm.org/current/, including rdfs:label for each class and property
- ecrm-labels.pl: generates rdfs:label for each class and property 
- ecrm-simplify.xq: generates CRM "application profiles", eg to exclude the controversial owl:Restriction's

Application profiles:
- ecrm.owl: includes inverse, symmetric, transitive, functional, disjoint, restriction (full)
- ecrm-inverse.owl: includes inverse, symmetric only (innate part of CRM)
- ecrm-inverse-transitive.owl: includes inverse, symmetric, transitive
You can generate more profiles with ecrm-simplify.xq
