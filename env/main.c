#include <stdio.h>

int main(int argc, char **argv, char** envp)
{
    for (int i = 0; envp[i]; i++)
        printf("%s\n", envp[i]);
    printf("argv = %p envp = %p\n", argv, envp);
    return 0;   
}
