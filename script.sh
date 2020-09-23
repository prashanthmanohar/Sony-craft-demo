#!/bin/bash

main() {
    echo "Parameter passed : $@"
    FILE=data.json
    if [ -f "$FILE" ]
    then
        echo "File present, refreshing with the latest data set."
        $(rm -f $FILE)
        $(curl -# -S https://www.travel-advisory.info/api > $FILE)
        echo "Download dataset Completed"
    else
        echo "File not found, hence downloading"
        $(curl -# -S https://www.travel-advisory.info/api > $FILE)
	echo "Download dataset completed"
    fi
    if [ "$#" -eq 0 -a "$#" -ge 2 ]
    then
        help_page
    else
        echo "$*" > parameter 
        local key=$(cat parameter | cut -d '=' -f1)
        local values=$(cat parameter | cut -d '=' -f2)
	    echo "Values: $values"
        `rm -f parameter`
        if [[ "$key" == "--countryCodes" && "$values" != " " ]]
        then
            IFS=","
            for value in $values
            do
	            local countryName=$(cat $FILE | jq ".data.${value}.name")
		        if [[ "$?" -eq 0 && "$countryName" != "null" && "$countryName" != "" ]]
		        then
			        echo "Search complete! For Country Code $value: $countryName" 
		        else 
                    echo "Enter Valid Country Code.."
                fi
            done
        else
        fi
    fi

}

help_page() {
  cat <<EOM
  Usage
  $ ./script.sh <param> 
  Ex.: For single country lookup <param>: --countryCodes=AU
  OR
  Ex.: For single country lookup <param>: --countryCodes=AU,IN
EOM
}

main "$@"
