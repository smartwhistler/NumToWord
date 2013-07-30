#!/usr/bin/awk

BEGIN {
	ORS=""
}

{
	for(k=2; k<=NF; k++){
		print $k "!id(" $1*1000 ")|\n";
	}
}
