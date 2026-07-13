#include "vehiclesimulator.h"
#include <algorithm>
#include <cmath>

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
    processMovement();
    processEnergy();

    emit speedChanged();
    emit socChanged();
    emit accelerationChanged();
    emit throttleChanged();
    emit brakeChanged();
    emit estimatedRangeChanged();
    emit motorTemperatureChanged();
    emit batteryTemperatureChanged();
    emit regenActiveChanged();
    emit coolingFanActiveChanged();
    emit energyEfficiencyChanged();
    emit powerUsageChanged();
}

void VehicleSimulator::processMovement()
{
    if (m_speed > 0.0f) {
        if (m_brake > 0.0f) {
            m_regenActive = true;
        }
        else if (m_onePedalMode && m_throttle == 0.0f) {
            m_regenActive = true;
        }
        else {
            m_regenActive = false;
        }
    }
    else {
        m_regenActive = false;
    }


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
    if (m_onePedalMode && m_throttle == 0) {
        naturalFriction += 3.5;
    }

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

    if (m_soc <= 0.0f) {
        m_speed *= 0.95;
        m_throttle = 0.0f;
    }
    else {
        m_acceleration = (max_acceleration * m_throttle) - (max_brakingForce * m_brake) - naturalFriction;
        m_speed += m_acceleration;
    }

    m_speed = std::clamp(m_speed, 0.0, max_speed);
}

void VehicleSimulator::processEnergy()
{
    if (m_regenActive) {
        if (m_brake > 0.0f) {
            m_powerUsage = -15.0f * m_brake;
        }
        else {
            m_powerUsage = -5.0f;
        }
    }
    else {
        m_powerUsage = 0.5f + (m_throttle * m_speed * 0.25f);
    }

    if (m_throttle > 0.5) {
        m_motorTemperature += 0.2f;
    }


    bool motorNeedsFan = m_coolingFanActive;
    bool batteryNeedsFan = m_coolingFanActive;

    if (m_motorTemperature >= 75.0f) {
        motorNeedsFan = true;
    }
    else if (m_motorTemperature <= 50.0f) {
        motorNeedsFan = false;
    }

    float batteryHeatGeneration = std::abs(m_powerUsage) * 0.005f;
    m_batteryTemperature += batteryHeatGeneration;

    if (m_batteryTemperature > 28.8f) {
        batteryNeedsFan = true;
    }
    if (m_batteryTemperature < 25.0f) {
        batteryNeedsFan = false;
    }
    m_coolingFanActive = (motorNeedsFan || batteryNeedsFan);

    if (m_coolingFanActive) {
        float airflowBonus = 0.005f * m_speed;
        float totalCooling = 0.2f;

        m_motorTemperature -= totalCooling + airflowBonus;
        m_batteryTemperature -= totalCooling * 0.18f;
    }

    m_motorTemperature = std::clamp(m_motorTemperature, 25.0f, 100.0f);
    m_batteryTemperature = std::clamp(m_batteryTemperature, 25.0f, 55.0f);

    if (m_throttle > 0.5) {
        m_energyEfficiency -= 0.02f;
    }
    else if (m_regenActive) {
        m_energyEfficiency += 0.01f;
    }
    else {
        if (m_energyEfficiency < 4.0f) m_energyEfficiency += 0.005f;
        if (m_energyEfficiency > 4.0f) m_energyEfficiency -= 0.005f;
    }
    m_energyEfficiency = std::clamp(m_energyEfficiency, 1.5f, 5.5f);

    double finalDrain = m_powerUsage * 0.001;
    if (m_motorTemperature > 75.0f) {
        finalDrain *= 1.15;
    }

    double nextSoc = m_soc - finalDrain;
    nextSoc = std::clamp(nextSoc, 0.0, 100.0);

    setSoc(nextSoc);
    m_estimatedRange = m_soc * m_energyEfficiency;
}

void VehicleSimulator::setGasPressed(bool pressed)
{
    m_gasPressed = pressed;
}

void VehicleSimulator::setBrakePressed(bool pressed)
{
    m_brakePressed = pressed;
}