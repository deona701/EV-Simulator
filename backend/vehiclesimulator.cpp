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
    float natural_friction = 0.5;
    float force = 0.0;
    double currentSoc = soc();
    double currentSpeed = speed();
    float max_acceleration = 4.2;
    float max_brakingForce = 12.0;

    float drain = 0.1 + (currentSpeed * 0.02);
    currentSoc -= drain;

    if (currentSoc > 0) {
        if (m_throttle >= 0.0 && m_throttle <= 1.0 && m_brake >= 0.0 && m_brake <= 1.0) {
            /* basically max throttle gives full acceleration, half throttle gives half acceleration, but we also
             * have natural drag which we add in every calculation to make things more realistic.
             * we also have a maximum braking force, which makes the car brake faster.
             */
            force = (max_acceleration * m_throttle) - max_brakingForce * m_brake - natural_friction;
            currentSpeed = currentSpeed + force;
        }
    }
    if (currentSoc < 0) {
        currentSoc = 0;
        currentSpeed = currentSpeed - 18.6;
    }

    currentSpeed = std::clamp(currentSpeed, 0.0, 220.0);
    currentSoc = std::clamp(currentSoc, -0.1, 100.0);

    setSoc(currentSoc);
    setSpeed(currentSpeed);

    m_acceleration = force;
    emit accelerationChanged();
}