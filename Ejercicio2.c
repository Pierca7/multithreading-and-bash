#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>     // para hacer sleep


#define TIEMPO 1000

sem_t semaforo;

void* funcionA(void* parametro)
{
    sem_wait(&semaforo);

    printf("→");

    sem_post(&semaforo);

    pthread_exit(NULL);
}

void* funcionB(void* parametro)
{
    sem_wait(&semaforo);

    printf("↑");

    sem_post(&semaforo);

    pthread_exit(NULL);
}

void* funcionC(void* parametro)
{
    sem_wait(&semaforo);

    printf("←");

    sem_post(&semaforo);

    pthread_exit(NULL);
}

void* funcionD(void* parametro)
{
    sem_wait(&semaforo);

    printf("\n");

    sem_post(&semaforo);

    pthread_exit(NULL);
}

int main()
{
    pthread_t threadA;
    pthread_t threadB;
    pthread_t threadC;
    pthread_t threadD;

    //Inicializo semaforo
    int res = sem_init(&semaforo,1,1);

        int rca = pthread_create(&threadA,
                             NULL,
                             funcionA,
                             NULL);
        usleep(TIEMPO);
        int rcb = pthread_create(&threadB,
                                 NULL,
                                 funcionB,
                                 NULL);
        usleep(TIEMPO);
        int rcc = pthread_create(&threadC,
                                 NULL,
                                 funcionC,
                                 NULL);
        usleep(TIEMPO);
        int rcb2 = pthread_create(&threadB,
                                 NULL,
                                 funcionB,
                                 NULL);
        usleep(TIEMPO);
        int rcd = pthread_create(&threadD,
                                 NULL,
                                 funcionD,
                                 NULL);

        pthread_join(threadA,NULL);
        pthread_join(threadB,NULL);
        pthread_join(threadC,NULL);
        pthread_join(threadD,NULL);
    }

}
