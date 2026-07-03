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
    emit estimatedRangeChanged();
    emit motorTemperatureChanged();
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
    float max_brakingForce = 12.0;
    float max_acceleration = 4.2f;
    double max_speed = 180.0;

    switch (m_driveMode) {
    case DriveMode::Eco:
        max_acceleration = 2.2;
        max_speed = 140.0;
        break;

    case DriveMode::Normal:
        max_acceleration = 4.2;
        max_speed = 180.0;
        break;

    case DriveMode::Sport:
        max_acceleration = 7.0;
        max_speed = 250.0;
        break;
    }

    if (m_soc <= 0) {
        m_soc = 0;
        m_speed *= 0.95;
        m_throttle = 0.0f;
    }
    if (m_throttle == 0.0f) {
        naturalFriction += 0.2;
        m_regenActive = true;
    }
    if (m_throttle > 0.0f) {
        m_regenActive = false;
    }

    m_acceleration = (max_acceleration * m_throttle) - (max_brakingForce * m_brake) - naturalFriction;
    m_speed += m_acceleration;


    // Safety clamp so the car doesn't go backward from friction or exceed top speed
    m_speed = std::clamp(m_speed, 0.0, max_speed);
}

void VehicleSimulator::processEnergy()
{
    double drain = 0.005 + (m_speed * 0.001);
    m_soc -= drain;
    m_soc = std::clamp(m_soc, 0.0, 100.0);

    if (m_throttle > 0.5) {
        m_motorTemperature += 0.2; // Heat up under load
    } else {
        m_motorTemperature -= 0.1; // Cool down naturally
    }
    m_motorTemperature = std::clamp(m_motorTemperature, 25.0f, 100.0f);

    if (m_regenActive == true) {
        m_soc += 0.002;
    }
    m_estimatedRange = m_soc * 4.0;
}

void VehicleSimulator::setGasPressed(bool pressed)
{
    m_gasPressed = pressed;
}

void VehicleSimulator::setBrakePressed(bool pressed)
{
    m_brakePressed = pressed;
}