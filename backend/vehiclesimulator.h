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
    Q_PROPERTY(double throttle MEMBER m_throttle NOTIFY throttleChanged)
    Q_PROPERTY(float brake MEMBER m_brake NOTIFY brakeChanged)
    Q_PROPERTY(DriveMode driveMode MEMBER m_driveMode NOTIFY driveModeChanged)

    //Energy Properties
    Q_PROPERTY(double soc READ soc WRITE setSoc NOTIFY socChanged FINAL)
    Q_PROPERTY(float estimatedRange MEMBER m_estimatedRange NOTIFY estimatedRangeChanged)
    Q_PROPERTY(float powerUsage MEMBER m_powerUsage NOTIFY powerUsageChanged)
    Q_PROPERTY(bool regenActive MEMBER m_regenActive NOTIFY regenActiveChanged)

    //Thermal Properties
    Q_PROPERTY(float batteryTemperature MEMBER m_batteryTemperature NOTIFY batteryTemperatureChanged)
    Q_PROPERTY(float motorTemperature MEMBER m_motorTemperature NOTIFY motorTemperatureChanged)
    Q_PROPERTY(bool coolingFanActive MEMBER m_coolingFanActive NOTIFY coolingFanActiveChanged)

    //ADAS Properties
    Q_PROPERTY(float laneOffSet MEMBER m_laneOffSet NOTIFY laneOffSetChanged)
    Q_PROPERTY(float distanceToVehicleAhead MEMBER m_distanceToVehicleAhead NOTIFY distanceToVehicleAheadChanged)

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
    void laneOffSetChanged();
    void distanceToVehicleAheadChanged();

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
    float m_powerUsage = 0.0f;
    bool m_regenActive = false;

    float m_batteryTemperature = 25.0f; // Room temp to start
    float m_motorTemperature = 25.0f;
    bool m_coolingFanActive = false;

    float m_laneOffSet = 0.0f; // Dead center in the lane
    float m_distanceToVehicleAhead = 150.0f; // Safe distance ahead

    QTimer *m_simTimer;
};

#endif // VEHICLESIMULATOR_H