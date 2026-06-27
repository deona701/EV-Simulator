#ifndef VEHICLESIMULATOR_H
#define VEHICLESIMULATOR_H

#include <QObject>
#include <QTimer>
#include <QtQml>

class VehicleSimulator : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(double speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(double soc READ soc WRITE setSoc NOTIFY socChanged FINAL)

public:
    explicit VehicleSimulator(QObject *parent = nullptr);
    double speed() const;
    double soc() const;

public slots:
    void setSpeed(double newSpeed);
    void setSoc(double newSoc);

signals:
    void speedChanged();
    void socChanged();

private slots:
    void updateSimulation();

private:
    double m_speed = 0.0;
    double m_soc = 100.0;
    QTimer* m_timer = nullptr;
};

#endif // VEHICLESIMULATOR_H