#include "mybackend.h"
#include <QDebug>

MyBackend::MyBackend(QObject *parent)
    : QObject{parent}
{
    loadInitialMockData();
}

void MyBackend::loadInitialMockData(){
    //A student is represented cleanly as a QVarintMap
    QVariantMap s1;
    s1["id"] = 2;
    s1["name"] = "Ravi";
    s1["age"] = 24;
    s1["department"] = "Computer Science";
    s1["status"] = "Active";
    s1["gpa"] = 3.9;

    QVariantMap s2;
    s2["id"] = 3;
    s2["name"] = "Akash";
    s2["age"] = 23;
    s2["department"] = "Electronics";
    s2["status"] = "Active";
    s2["gpa"] = 3.9;

    m_students.append(s1);
    m_students.append(s2);

    emit studentsChanged();

    selectStudent(2);//Default to selecting student #2
}
void MyBackend::selectStudent(int studentId){
    for(const auto &item :std::as_const( m_students))
    {
        auto student = item.toMap();
        if(student["id"].toInt()  == studentId){
            m_selectedStudent  = student;
            emit selectedStudentChanged();

            //Load mock changelogs for this student
            m_changelong.clear();
            QVariantMap c1;c1["tag"] = "Academics";c1["action"] = "Enrolled in CS201";
            QVariantMap c2;c2["tag"] = "Campus";c2["action"] = "Library Card Issuded";
            m_changelong.append(c1);
            m_changelong.append(c2);
            emit changelogsChanged();
            break;
        }
    }

}

void MyBackend::addChangelog(const QString &action, const QString &tag)
{
    QVariantMap newEntry;
    newEntry["action"]=action;
    newEntry["tag"] = tag;
    m_changelong.prepend(newEntry);
    emit changelogsChanged();
}