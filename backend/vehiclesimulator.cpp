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
    // Run the sub-systems
    processMovement();
    processEnergy();

    // Tell QML that properties updated
    emit speedChanged();
    emit socChanged();
    emit accelerationChanged();
    emit throttleChanged();
    emit brakeChanged();
}

void VehicleSimulator::processMovement()
{
    if (m_gasPressed) {
        m_throttle += 0.1;
    }
    else {
        m_throttle -= 0.15;
    }
    m_throttle = std::clamp(m_throttle, 0.0f, 1.0f);

    if (m_brakePressed) {
        m_brake += 2.0;
    }
    else {
        m_brake -= 2.0;
    }
    m_brake = std::clamp(m_brake, 0.0f, 1.0f);

    float naturalFriction = 0.5;
    float max_acceleration = 4.2;
    float max_brakingForce = 12.0;

    m_acceleration = (max_acceleration * m_throttle) - (max_brakingForce * m_brake) - naturalFriction;
    m_speed += m_acceleration;

    // Safety clamp so the car doesn't go backward from friction or exceed top speed
    m_speed = std::clamp(m_speed, 0.0, 220.0);
}

void VehicleSimulator::processEnergy()
{
    // Battery drain math not complete yet
}

void VehicleSimulator::setGasPressed(bool pressed)
{
    m_gasPressed = pressed;
}

void VehicleSimulator::setBrakePressed(bool pressed)
{
    m_brakePressed = pressed;
}