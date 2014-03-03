#include "list.h"

void list_init(struct list* list)
{
    if (list) {
        list->prev = list;
        list->next = list;
    }
}

int list_empty(struct list *list)
{
    return list->next == list;
}

void list_push(struct list *list, struct list *new)
{
    if (list && new) {
        /* Remove new from origin list */
        new->prev->next = new->next;
        new->next->prev = new->prev;

        new->next = list;
        new->prev = list->prev;
        list->prev = new;
    }
}

struct list* list_pop(struct list *list)
{
    struct list *first = list->next;

    if (first == list)
        return 0;

    list->next = first->next;
    list->next->prev = list;

    return first;
}
