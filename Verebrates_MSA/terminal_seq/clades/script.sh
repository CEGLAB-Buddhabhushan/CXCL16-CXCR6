#!/bin/bash

# Input file
input_file="N-term.pepstat.tsv"

# Output file
output_file="N-term.pepstat_group.tsv"

# Lists for each group
aves_list="Aves.lst"
amphibia_list="Amphibia.lst"
mammals_list="Mammalia.lst"
testudines_list="Testudines.lst"
lepidosauria_list="Lepidosauria.lst"

# AWK script to add the group column
awk -F'\t' -v aves_list="$aves_list" -v amphibia_list="$amphibia_list" -v mammals_list="$mammals_list" -v testudines_list="$testudines_list" -v lepidosauria_list="$lepidosauria_list" '
    BEGIN {
        # Load Aves list into an array
        while ((getline < aves_list) > 0) {
            aves[$1] = 1;
        }
        close(aves_list);

        # Load Amphibia list into an array
        while ((getline < amphibia_list) > 0) {
            amphibia[$1] = 1;
        }
        close(amphibia_list);

        # Load Mammals list into an array
        while ((getline < mammals_list) > 0) {
            mammals[$1] = 1;
        }
        close(mammals_list);

        # Load Testudines list into an array
        while ((getline < testudines_list) > 0) {
            testudines[$1] = 1;
        }
        close(testudines_list);

        # Load Lepidosauria list into an array
        while ((getline < lepidosauria_list) > 0) {
            lepidosauria[$1] = 1;
        }
        close(lepidosauria_list);

        # Print header with the Group column
        print $0 "\tGroup";
    }
    {
        if (NR > 1) {
            # Check which group the species belongs to
            if ($1 in aves) {
                group = "Aves";
            } else if ($1 in amphibia) {
                group = "Amphibia";
            } else if ($1 in mammals) {
                group = "Mammals";
            } else if ($1 in testudines) {
                group = "Testudines";
            } else if ($1 in lepidosauria) {
                group = "Lepidosauria";
            } else {
                group = "Unknown";
            }

            # Print the line with the assigned group
            print $0 "\t" group;
        }
    }
' "$input_file" > "$output_file"

echo "Group column added and saved to $output_file"
