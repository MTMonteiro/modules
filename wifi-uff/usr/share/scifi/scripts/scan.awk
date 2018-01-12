/Cell/ { state= 0}
/Address/ { printf("%18s", $5);}
/Channel:/ { printf("%11s", $1);}
/Quality/ { printf("%14s", $1);}
/ESSID/ { if (state==0) {printf(" %s\n", $1); state=1;}}
