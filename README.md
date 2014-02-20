Ontology versions:
- ecrm_current.owl: current version, using namespace http://erlangen-crm.org/ current /. Includes rdfs:label for each class and property
- ecrm__yymmdd_.owl: older version, using namespace http://erlangen-crm.org/ _yymmdd_ /

Scripts:
- ecrm-labels.pl: generates rdfs:label for each class and property. (Run just once: Protege remembers them)
- ecrm-simplify.xq: generates CRM "application profiles", eg to exclude the controversial owl:Restriction's

Application profiles:
- ecrm_current.owl: includes inverse, symmetric, transitive, functional, disjoint, restriction (full)
- ecrm-inverse.owl: includes inverse, symmetric only (innate part of CRM)
- ecrm-inverse-transitive.owl: includes inverse, symmetric, transitive.

You can generate more profiles with ecrm-simplify.xq
