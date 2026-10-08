#ifndef MYBACKEND_H
#define MYBACKEND_H

#include <QObject>
#include <QQmlEngine>

class MyBackend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MyBackend(QObject *parent = nullptr);

signals:
};

#endif // MYBACKEND_H
