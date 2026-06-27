#include "vehiclesimulator.h"
#include <algorithm>

VehicleSimulator::VehicleSimulator(QObject *parent)
    : QObject(parent)
{
    m_simTimer = new QTimer(this);
    connect(m_simTimer, &QTimer::timeout, this, &VehicleSimulator::updateSimulation);
    m_simTimer->start(100);
}

double VehicleSimulator::speed() const
{
    return m_speed;
}

void VehicleSimulator::setSpeed(double newSpeed)
{
    if (m_speed == newSpeed)
        return;

    m_speed = newSpeed;
    emit speedChanged();
}

double VehicleSimulator::soc() const
{
    return m_soc;
}

void VehicleSimulator::setSoc(double newSoc)
{
    if (m_soc == newSoc)
        return;

    m_soc = newSoc;
    emit socChanged();
}

void VehicleSimulator::updateSimulation()
{
    float friction = 18.6;
    double currentSoc = soc();
    double currentSpeed = speed();
    float drain = 0.1 + (currentSpeed * 0.02);
    currentSoc -= drain;

    if (currentSoc > 0) {
        currentSpeed += 4.2;
    }
    if (currentSoc < 0) {
        currentSoc = 0;
        currentSpeed = currentSpeed - friction;
    }

    currentSpeed = std::clamp(currentSpeed, 0.0, 220.0);
    currentSoc = std::clamp(currentSoc, -0.1, 100.0);

    setSoc(currentSoc);
    setSpeed(currentSpeed);
}