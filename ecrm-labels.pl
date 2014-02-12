#!perl -wn
# Given the ECRM OWL file, extract all class and property URIs and generate rdfs:label and skos:notation for them.
# Usage: perl -wn ecrm-labels.pl ecrm.owl > ecrm-with-labels.owl
# Example: ecrm:P91i_is_unit_of rdfs:label "P91 is unit of"; skos:notation "P91i".
# Author: vladimir.alexiev@ontotext.com, 8-Aug-2012

# TODO: add opton -s (short) to skip numeric IDs and parasitic words (is/was) from rdfs:label

print; # print the original line first!
m{xmlns:ecrm="http://erlangen-crm.org/current/"} and
  print qq{    xmlns:skos="http://www.w3.org/2004/02/skos/core#"\n};
m{^  <.*rdf:about="http://erlangen-crm.org/current/([^_]+)_([^"]+)} and do {
  my ($notation,$label) = ($1,$2);
  my $id = $notation; $id =~ s{i}{}; # "P91"
  $label =~ s{_}{ }g; # "is unit of"
  print << "EOF"
    <rdfs:label xml:lang="en">$id $label</rdfs:label>
    <skos:notation>$notation</skos:notation>
EOF
}
