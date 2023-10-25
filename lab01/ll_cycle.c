#include <stddef.h>
#include "ll_cycle.h"
/*complete the function ll_has_cycle() to implement the following algorithm for checking if a singly- linked list has a cycle.

1.Start with two pointers at the head of the list. We’ll call the first one tortoise and the second one hare.
2.Advance hare by two nodes. If this is not possible because of a null pointer, we have found the end of the list, and therefore the list is acyclic.
3.Advance tortoise by one node. (A null pointer check is unnecessary. Why?)
4.If tortoise and hare point to the same node, the list is cyclic. Otherwise, go back to step 2.
 * */
int ll_has_cycle(node *head) {
    /* your code here */
    if(head == NULL) return 0;
    node *slow, *fast;
    slow = fast = head;
/*Take away: NULL is case-sensitive in C
 * and as for slow and fast pointer, check once move
 * */
    while(1) {
        fast = fast->next;
        if (fast == NULL) return 0;
        fast = fast->next;
        if (fast == NULL) return 0;
        slow = slow->next;
        if (fast == slow) {
            return 1;
        }
    }
    return 0;
}