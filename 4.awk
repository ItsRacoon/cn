BEGIN{
count=0;
}
{
if($1=="c")
count++;
}
END{
printf("\n The total packet collision %d\n",count);
}
