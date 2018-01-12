BEGIN {
maior = 0;
} 
{
channel = $8;
if ($10 > maior) maior = $10;
} 
END {
printf ("%2d %2d ", channel, maior);
}
