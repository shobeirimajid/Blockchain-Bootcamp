#include <stdio.h>
#include <string.h>

void main() {

    char str[] = "Beauty is in the eye of the beholder";
    char word[] = "the";
    int len = strlen(word);     // length of search word

    int i=0, j=0, count=0;

    while(str[i] != '\0') {

        if(str[i] == word[j]) {

            // if first character of search word matches
            // keep on searching

            while(str[i] == word[j] && str[i] != '\0') {
                i++;
                j++;
            }

            if(j == len && ( str[i] == ' ' || str[i] == '\0' ))

            // if we sequence of characters matching with the length of searched word
            // we find our search word

            count++;
        } else {

            // if first character of search string DOES NOT match
            // Skip to next word

            while(str[i] != ' ') {
                i++;
                if(str[i] == '\0')
                    break;
            }
        }

        i++;    // first character of next word in string
        j=0;    // first character of the search word
    }

    printf("\n String:   %s", str);
    printf("\n Search:   %s", word);
    printf("\n appears:  %d", count);

}
