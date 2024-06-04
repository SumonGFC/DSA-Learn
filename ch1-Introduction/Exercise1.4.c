/* Exercise 1.4. Suppose you have a Stack, s, that supports only the push(x)
 * and pop() operations. Show how, using only a FIFO Queue, q, you can reverse
 * the order of all elements in s.
 */


#include <stdio.h>

#define BUFFER 100

void push(int x, int *arr, int top);
int pop(size_t *height, int *arr);

int main(void) 
{
        int stack[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
        size_t stack_len = sizeof(stack) / sizeof(stack[0]);
        int reversed[stack_len];

        int i;
        for (i = 0; i < 10; ++i) {
                push(pop(&stack_len, stack), reversed, i);
                printf("%d", reversed[i]);
        }
        return 0;
}



void push(int item, int *arr, int top)
{
        arr[top] = item;
}

int pop(size_t *curr_height, int *arr)
{
        if (*curr_height > 0) {
                int tmp =  *(arr + *curr_height - 1);
                (*curr_height)--;
                return tmp;
        } else
                printf("Error: Negative Stack Growth\n");
        return 0;
}
