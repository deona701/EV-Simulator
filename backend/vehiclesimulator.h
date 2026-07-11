#ifndef VEHICLESIMULATOR_H
#define VEHICLESIMULATOR_H

#include <QObject>
#include <QTimer>
#include <QtQml>

class VehicleSimulator : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    enum DriveMode {
        Eco,
        Normal,
        Sport
    };
    Q_ENUM(DriveMode)

    //Movement Properties
    Q_PROPERTY(double speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(float acceleration MEMBER m_acceleration NOTIFY accelerationChanged)
    Q_PROPERTY(float throttle MEMBER m_throttle NOTIFY throttleChanged)
    Q_PROPERTY(float brake MEMBER m_brake NOTIFY brakeChanged)
    Q_PROPERTY(DriveMode driveMode MEMBER m_driveMode NOTIFY driveModeChanged)

    //Energy Properties
    Q_PROPERTY(double soc READ soc WRITE setSoc NOTIFY socChanged FINAL)
    Q_PROPERTY(float estimatedRange MEMBER m_estimatedRange NOTIFY estimatedRangeChanged)
    Q_PROPERTY(float powerUsage MEMBER m_powerUsage NOTIFY powerUsageChanged)
    Q_PROPERTY(bool regenActive MEMBER m_regenActive NOTIFY regenActiveChanged)
    Q_PROPERTY(bool onePedalMode MEMBER m_onePedalMode  NOTIFY onePedalModeChanged)
    Q_PROPERTY(float energyEfficiency MEMBER m_energyEfficiency NOTIFY energyEfficiencyChanged)

    //Thermal Properties
    Q_PROPERTY(float batteryTemperature MEMBER m_batteryTemperature NOTIFY batteryTemperatureChanged)
    Q_PROPERTY(float motorTemperature MEMBER m_motorTemperature NOTIFY motorTemperatureChanged)
    Q_PROPERTY(bool coolingFanActive MEMBER m_coolingFanActive NOTIFY coolingFanActiveChanged)

    explicit VehicleSimulator(QObject *parent = nullptr);

    double speed() const;
    double soc() const;

public slots:
    void updateSimulation();
    void setSpeed(double newSpeed);
    void setSoc(double newSoc);
    void setGasPressed(bool pressed);
    void setBrakePressed(bool pressed);

signals:
    void speedChanged();
    void accelerationChanged();
    void throttleChanged();
    void brakeChanged();
    void driveModeChanged();
    void socChanged();
    void estimatedRangeChanged();
    void powerUsageChanged();
    void regenActiveChanged();
    void batteryTemperatureChanged();
    void motorTemperatureChanged();
    void coolingFanActiveChanged();
    void onePedalModeChanged();
    void energyEfficiencyChanged();

private:
    // Default starting values for the physical machine
    void processMovement();
    void processEnergy();
    double m_speed = 0.0f;
    float m_acceleration = 0.0f;
    float m_throttle = 0.0f;
    float m_brake = 0.0f;
    bool m_gasPressed = false;
    bool m_brakePressed = false;
    DriveMode m_driveMode = DriveMode::Normal;

    double m_soc = 100.0f;
    float m_estimatedRange = 400.0f; // Starting range in km
    float m_energyEfficiency = 4.0f; // KM per % of battery
    float m_powerUsage = 0.0f;
    bool m_regenActive = false;

    float m_batteryTemperature = 25.0f; // Room temp to start
    float m_motorTemperature = 25.0f;
    bool m_coolingFanActive = false;
    bool m_onePedalMode = false;

    float m_coolingRate = 0.5f;
    float m_coolingFactor = 0.5f;

    QTimer *m_simTimer;
};

#endif // VEHICLESIMULATOR_H