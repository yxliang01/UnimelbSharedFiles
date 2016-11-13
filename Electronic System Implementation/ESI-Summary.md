Electronic System Implementation
=====

Electronics Fundamental
=====
- Passive circuit elements
    + Resistor $ V = IR $
    + Capacitor $ C\frac{dV}{dt} = I $
    + Inductor $ L\frac{dI}{dt} = V $
    + Diode $ i = i_0 (exp(\frac{v}{v_0}) - 1) $
- Sinusoidal steady state analysis
    + $ v = iR $
    + $ i = j\omega c $
    + $ v = j\omega L $


Embedded System
=====
- An embedded system is a computer system with a dedicated function within a mechanical or electrical system, often with real-time computing constraints

Microprocessor VS Microcontroller
-----

### Microcontroller

Microcontroller = Processor + Memory + I/O ports (interface)

It contains

- Microprocessor (Processor MPU / CPU) - Instruction Set + Memory + Accelerators
    + Read instructions
    + Process binary data
- Memory
    + Non-volatile
        * ROM
        * EPROM, EEPROM, Flash
    + Volatile
        * RAM (DRAM, SRAM)
- Interface
    + H/W
        * Ports
    + S/W
        * Device driver
    + Parallel, Serial, Analog, Time
- I/O
    + Memory-mapped
    + I/O instructions (I/O mapped)

Examples

- ATmega328P
    + 5V
    + 5V I/O pin can *draw 20mA*
    + 3.3V I/O pin can *draw 50mA*


Reactive System VS Real time system
=====

### Reactive System

- Accepts inputs
- Performs calculations
- Generates outputs

### Real time System

- Specifies an upper bound on the time required to perform the input/calculation/output in reaction to external events
- Interacts with physical environment



Arduino
=====

See ATmega328P
(TODO!!!)![Sampling limitation](wait for it)


The interesting project
=====

TEC
-----

Current: recommended +/- 1.5A
Voltage: recommended +/- 2.5V
Careful with high and low temperature


Misc
=====
- Analysis Vs Design
    + Analysis
        * given a circuit **calculate the currents and voltages**
    + Design
        * given a desired outcome **choose a circuit and components to realize that outcome**
- Some Choices
    + Electronic or mechanical
    + Digital or Analog
    + Hardware or software
    + Integrated circuit or discrete components
    + Surface mount or through hole
    + Breadboard, prototype board, or printed circuit board
    + **Make the choice on the basis of measurement, analysis, modeling, cost, size, power, patents**


Design Process
=====
- ![Design Flow](Design_Flow.png)
- Design entry
    + Create the electronic diagram or schematic or electronic circuit by a schematic design suite
    + Simulate the performance of sub-systems
    + Prototype the sub-systems
    + Test and measurements
        * review the outcomes and compare with the system specification

OUR Project Specific
=====
- Arduino UNO
    + Physical characteristics
        * Bandwidth, Current limit, Voltage limit, Resolution, Impedance
    + Voltage limit
        * 0~5 V
    + ADC
        * 10 ADC bits
        * Resolution: $ \frac{5}{1024} = 0.0048828125 V $
- TEC
    + Current limit
        * Recommended +/- 1.5A
    + Voltage
        * Recommended +/- 2.5V
- Thermistor
    + It can be a resistive components
    + a device convert the temperature into resistance
    + low cost
    + need to be calibrated and it is nonlinear in certain region
    + Negative temperature coefficient (NTC) thermistor
    + Generally made of ceramics or polymers
        * smaller size, faster response, greater resistance to shock and vibration at a lower cost, good sensitivity
    + Temperature approximation
        * $ \frac{1}{T} = a + bx + cx^2 + dx^3 $ where $ x = \ln{\frac{R_T}{R_{25}}} $
        * ![Temperature Curve](Temperature_Curve.png)
    + Or, calibrate point by point for high accuracy application
    + calibration
        * sensor can exhibit non-ideal effects
        * can be done by
            - specific calibration machine
            - some accurate reference device
            - e.g. speed, pressure, time, temperature, wavelength, intensity...  
- AD590
    + a current regulator
    + the output current is equal to a scale factor times the temperature of the sensor in degree Kelvin. This scale factor is trimmed to $ 1 \mu A/K $.
    + very accurate device
    + can be used for calibration
- Simulation
    + Before implementing the circuit, simulation can be carried out to investigate the performance of the circuit
        * give an preliminary understanding of the circuit performance
            - investigate the bandwidth, voltage, current of nodes in the circuit
        * trouble shooting the circuit
        * optimize the performance in an ideal situation
    + Electronic circuit simulation is named SPICE
- Transducer
    + A device that converts a primary form of energy into a corresponding signal with a different energy form
    + Sensor
        * **acquires information from the "real world"**
    + Actuator
        * a device that **generates a signal or stimulus**
- Signal Conditioning
    + Manipulate an analog signal in such way that it is optimized for further processing
    + ![Signal Conditioning](Signal_Conditioning.png)
    + Sampling
        * converts the continuous signal into a series of discrete analog signals at periodic intervals
    + Quantization
        * each discrete signal is converted into one of a finite number of discrete amplitude levels ($ 2^{Nb} $ levels) depends on the number of bits per sample Nb and full range voltage V<sub>FR</sub>
    + Encoding
        * discrete levels are converted into digital code
    + Resolution = $ V_{FR} / (2^{Nb}) $
    + Quantization error = $ +/- 0.5 * Resolution $
    + For thermistor
        * Thermistor Half-Bridge
            - Voltage divider
            - ![Voltage Divider Example](Voltage_Divider_Example.png)
        * Wheatstone Bridge
            - ![Wheatstone Bridge Example](Wheatstone_Bridge_Example.png)
            - $ R_3 = $ resistive sensor
            - $ R_4 $ is matched to nominal value of $ R_3 $
            - If $ R_1 = R_2, V_{out-nominal} = 0 $
            - $ V_{out} $ varies as $ R_3 $ changes
- Design Specification Consideration
    + Power
        * How much power is used and wasted
    + Accuracy
        * How good is the temperature calibration
    + Time scale
        * How long does it take to go from one desired temperature to another
    + Reliability
        * How long does the circuit continue working without intervention
    + Cost
        * How many components it needs and how much it will cost

Transistor
=====
- a semiconductor device that amplifies, oscillates, or switches the flow of current between two terminals by varying the current or voltage between one of the terminals and a third
- purpose: switch signal & amplify signals
- Diode - has only one P-N junction
    + Forward Biasing polarity facilitates motion of free electrons
    + Reverse Biasing polarity impedes motion of free electrons
    + ![Biasing Illustration](Biasing_Illustration.png)
- One P-N junction can control current flow via an external voltage
- Two P-N junction (bipolar junction transistor, BJT) can control current flow and amplify the current flow
- ![PNP BJT 1](PNP_BJT_1)
- categorized by
    + Semiconductor material: germanium, silicon, gallium arsenide, etc
    + Structure: BJT, FET, IGFET (MOSFET), IGBT
    + Polarity: NPN, PNP (BJTs); N-Channel, P-Channel (FETs)
    + Maximum power rating: low, medium, high
    + Maximum operating frequency: low, medium, high
    + Application: switch, audio, high voltage, etc
    + Physical packaging: through hole, surface mount, ball grid array, etc
- ![Transistor Symbols](Transistor_Symbols.png)
- BJT
    + Relationship Equations
    + ![BJT Equations](BJT_Equations.png)
    + Characteristics
        * $ \alpha = \text{ Common-base current gain }, \alpha = \frac{I_C}{I_E} $
        * $ \beta = \text{ Common-emitter current gain }, \beta = \frac{I_C}{I_B} $
            - Temperature and Voltage dependent
            - can vary a lot among transistors
    + relationships between two parameters
        * $ \alpha = \frac{\beta}{ \beta + 1 } $
        * $ \beta = \frac{\alpha}{ 1 - \alpha } $
    + Sometimes $ \alpha, \beta $ are referred as $ \alpha_{dc}, \beta_{dc} $ because those relationship are for BJT working with DC    

Exam
=====
- There will be at least one session on what is on the exam towards the end of semester
- Three questions each worth 20 marks
- At least one exam question which relies on workshops and assumes you have your logbook with you
- Have past exam
- Must be careful with units!!!
- call `pinMode` before using in `setup()`