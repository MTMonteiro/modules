{
 if (($2 == 1) || ($2 == 6) || ($2 == 11) ) {
	printf("%2d %2d %s\n", $2, $4, $7);}
  else { 
 	if ($2 == 2 ) {
         printf(" 1 %2d %s\n",  ($4*0.8), $7);
         printf(" 6 %2d %s\n",  ($4*0.2), $7);
        } else {

	 if ($2 == 3 ) {
          printf(" 1 %2d %s\n",  ($4*0.6), $7);
          printf(" 6 %2d %s\n",  ($4*0.4), $7);
         } else {

 	if ($2 == 4 ) {
         printf(" 1 %2d %s\n",  ($4*0.4), $7);
         printf(" 6 %2d %s\n",  ($4*0.6), $7);
        } else {

  	if ($2 == 5 ) {
         printf(" 1 %2d %s\n",  ($4*0.2), $7);
         printf(" 6 %2d %s\n",  ($4*0.8), $7);
        } else {

        if ($2 == 7 ) {
         printf(" 6 %2d %s\n",  ($4*0.8), $7);
         printf("11 %2d %s\n",  ($4*0.2), $7);
        } else {

 	if ($2 == 8 ) {
         printf(" 6 %2d %s\n",  ($4*0.6), $7);
         printf("11 %2d %s\n",  ($4*0.4), $7);
        } else {

  	if ($2 == 9 ) {
         printf(" 6 %2d %s\n",  ($4*0.4), $7);
         printf("11 %2d %s\n",  ($4*0.6), $7);
        } else {

  	if ($2 == 10 ) {
         printf(" 6 %2d %s\n",  ($4*0.2), $7);
         printf("11 %2d %s\n",  ($4*0.8), $7);
        } 
        }}}}}}}}
    }

