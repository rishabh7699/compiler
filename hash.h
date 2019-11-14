// hash header file for hashing of string

int a = 0;
char *str[100];

int is_exist(char *x)
{
    for(int i=0;i<a;i++)
        if(strcmp(str[i], x) == 0)
            return 1;
        
    return 0;
}

void add_identifier(char *x, int line)
{
    if(is_exist(x))
        printf("\nMultiple declaration of variable %s in line %d\n", x, line);
    else
        str[a++] = x;
}