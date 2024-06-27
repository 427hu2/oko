# пересборка всего проекта
gcc -c -I ./include main.cpp -o main.o
gcc -c -I ./include ./source/cache.cpp -o cache.o
gcc main.o cache.o -o main