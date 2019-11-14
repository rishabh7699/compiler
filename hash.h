// hash header file for hashing of string

#define prime 101

struct Node
{
    char *id;
    struct Node* next;
} *map[prime];

int hash(char *x)
{
    int p = 17, q = 1;
    int ans = 0;
    for(int i=0;x[i] != '\0';i++)
    {
        ans = (ans + q*(x[i]-'0'))%prime;
        q = (q*p)%prime;
    }
    return ans;
}

int is_exist(char *x)
{
    int hash_value = hash(x);
    struct Node *T = map[hash_value];
    while(T != NULL)
    {
        if(strcmp(T->id, x) == 0)
            return 1;
        T = T->next;
    }
    return 0;
}

void add_identifier(char *x, int line)
{
    if(is_exist(x))
        printf("\nE : Multiple declaration of variable %s in line %d\n", x, line);
    else
    {
        printf("\nvariable %s declared\n", x);
        int hash_value = hash(x);
        
        if(map[hash_value] == NULL)
        {
            map[hash_value] = (struct Node*)malloc(sizeof(struct Node*));
            map[hash_value]->id = x;
            map[hash_value]->next = NULL;
            return;
        }
        struct Node *T = map[hash_value];
        while(T->next != NULL)
            T = T->next;
        T->next = (struct Node*)malloc(sizeof(struct Node*));
        T->next->id = x;
        T->next->next = NULL;
    }
}

void initialize_map()
{
    for(int i=0;i<prime;i++)
        map[i] = NULL;
}