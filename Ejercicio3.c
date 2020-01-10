#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>     // para castear de puntero a entero
#include <string.h>
#include <time.h>
#include <pthread.h>


#define TIEMPO 1000
char* lugares_labels[] = {"Norte America", "Centro America", "Sud America", "Africa", "Europa", "Asia", "Oceania"};

void esperar () {
  //simular un tiempo de ejecucion de algun script araña (algun codigo en python)

  //inicializar en 1 segundo = 1000000 microseconds:
  int microseconds = 1000000;

  //dormir el thread, simula que esta haciendo alguna tarea
  usleep(microseconds);
}


void* recopilar_informacion (void* parametro)
{
    int lugar = (intptr_t)parametro;
    printf("***************************************** \n");
    printf("Buscando informacion en  %s \n", lugares_labels[lugar]);
    esperar();
}


int main ()
{
    pthread_t threadA;
    pthread_t threadB;
    pthread_t threadC;
    pthread_t threadD;
    pthread_t threadE;
    pthread_t threadF;

    int num = 0;
    int rca = pthread_create(&threadA,
                             NULL,
                             recopilar_informacion,
                             (void*)(intptr_t)0);
    //usleep(TIEMPO);

    int rcb = pthread_create(&threadB,
                             NULL,
                             recopilar_informacion,
                             (void*)(intptr_t)1);
    //usleep(TIEMPO);

    int rcc = pthread_create(&threadC,
                             NULL,
                             recopilar_informacion,
                             (void*)(intptr_t)2);
    //usleep(TIEMPO);

    int rcd = pthread_create(&threadD,
                             NULL,
                             recopilar_informacion,
                             (void*)(intptr_t)3);
    //usleep(TIEMPO);

    int rce = pthread_create(&threadE,
                             NULL,
                             recopilar_informacion,
                             (void*)(intptr_t)4);
    //usleep(TIEMPO);

    int rcf = pthread_create(&threadF,
                             NULL,
                             recopilar_informacion,
                             (void*)(intptr_t)5);

    pthread_join(threadA,NULL);
    pthread_join(threadB,NULL);
    pthread_join(threadC,NULL);
    pthread_join(threadD,NULL);
    pthread_join(threadE,NULL);
    pthread_join(threadF,NULL);

}

/*
tiempo de ejecucion secuencial de este programa:
real	0m6,002s
user	0m0,002s
sys	0m0,000s

tiempo de ejecucion paralela de este programa:
real	0m1,007s
user	0m0,002s
sys	0m0,000s
*/



