#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>     // para hacer sleep


#define TIEMPO 1000000

sem_t semaforo;

void* tenedor(void* parametro)
{
    char nombre = *(char*) parametro;

    printf("El filosofo %s agarro un tenedor\n", &nombre);

    sem_wait(&semaforo);

    usleep(TIEMPO);

    sem_wait(&semaforo);

    printf("El filosofo %s agarro otro tenedor\n", &nombre);

    pthread_exit(NULL);

}

int main()
{
    pthread_t threadA;
    pthread_t threadB;
    pthread_t threadC;
    pthread_t threadD;
    pthread_t threadE;

    //Inicializo semaforo
    int res = sem_init(&semaforo,1,5);

    char NombreA='A';
    int rca = pthread_create(&threadA,
                             NULL,
                             tenedor,
                             (void*)&NombreA);
    //usleep(TIEMPO);
    char NombreB='B';
    int rcb = pthread_create(&threadB,
                             NULL,
                             tenedor,
                             (void*)&NombreB);
    //usleep(TIEMPO);
    char NombreC='C';
    int rcc = pthread_create(&threadC,
                             NULL,
                             tenedor,
                             (void*)&NombreC);
    //usleep(TIEMPO);
    char NombreD='D';
    int rcd = pthread_create(&threadD,
                             NULL,
                             tenedor,
                             (void*)&NombreD);
    //usleep(TIEMPO);
    char NombreE='E';
    int rce = pthread_create(&threadE,
                             NULL,
                             tenedor,
                             (void*)&NombreE);

    pthread_join(threadA,NULL);
    pthread_join(threadB,NULL);
    pthread_join(threadC,NULL);
    pthread_join(threadD,NULL);
    pthread_join(threadE,NULL);

}

//Para compilar:   gcc Ejercicio4.c -o ej4 -lpthread
//Para ejecutar:   time ./ej4
