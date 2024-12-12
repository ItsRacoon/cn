#include <stdio.h>
#include <stdlib.h>  // For system() function
#include <string.h>  // For string functions if needed

int min(int x, int y) {
    return (x < y) ? x : y;
}

int main() {
    int drop = 0, mini, nsec, cap, count = 0, i, inp[25], process;
    system("clear");  // Clears the terminal screen (might be system-dependent)

    printf("Enter The Bucket Size: ");
    scanf("%d", &cap);

    printf("Enter The Operation Rate: ");
    scanf("%d", &process);

    printf("Enter The Number Of Seconds You Want To Simulate: ");
    scanf("%d", &nsec);

    for (i = 0; i < nsec; i++) {
        printf("Enter The Size Of The Packet Entering At %d sec: ", i + 1);
        scanf("%d", &inp[i]);
    }

    printf("\nSecond | Packet Received | Packet Sent | Packet Left | Packet Dropped\n");
    printf("-----------------------------------------------------------------------\n");

    for (i = 0; i < nsec; i++) {
        count += inp[i];
        if (count > cap) {
            drop = count - cap;
            count = cap;
        }
        printf("%6d | %15d | %11d | %11d | %14d\n", i + 1, inp[i], min(count, process), count - min(count, process), drop);
        count -= min(count, process);
        drop = 0;
    }

    while (count > 0) {
        if (count > cap) {
            drop = count - cap;
            count = cap;
        }
        printf("%6d | %15d | %11d | %11d | %14d\n", i + 1, 0, min(count, process), count - min(count, process), drop);
        count -= min(count, process);
        i++;
        drop = 0;
    }

    return 0;
}
