#include "mybackend.h"
#include<print>

MyBackend::MyBackend(QObject *parent)
    : QObject{parent}
{
    std::println("I am working");
}
