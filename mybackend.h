#ifndef MYBACKEND_H
#define MYBACKEND_H

#include <QObject>
#include <QQmlEngine>
#include <QString>
#include <QVariant>
#include <QVariantMap>

class MyBackend : public QObject
{
    Q_OBJECT
    QML_ELEMENT


    // Expose student data to QML
    Q_PROPERTY(QVariantList students  READ students  NOTIFY studentsChanged FINAL)
    Q_PROPERTY(QVariantMap selectedStudent READ selectedStudent  NOTIFY selectedStudentChanged FINAL)
    Q_PROPERTY(QVariantList changelogs READ changelogs NOTIFY changelogsChanged FINAL)


public:
    explicit MyBackend(QObject *parent = nullptr);

    //Geters
    QVariantList students()const{return m_students;}
    QVariantMap selectedStudent()const {return m_selectedStudent;}
    QVariantList changelogs()const{return m_changelong;}

    //Action called by QML when user interacts
    Q_INVOKABLE void selectStudent(int studentId);
    Q_INVOKABLE void addChangelog(const QString &action, const QString &tag);

signals:
    void studentsChanged();
    void selectedStudentChanged();
    void changelogsChanged();

private:
    QVariantList m_students;
    QVariantMap m_selectedStudent;
    QVariantList m_changelong;

    void loadInitialMockData();//stubs data before Drogon server connects
};

#endif // MYBACKEND_H
