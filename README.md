# Car-Parking-Sensor

Assembly Language 8051

### About
A simple ultrasonic range finder using 8051 microcontroller to measure distances up to 2.5 meters at an accuracy of 1
centimetre. AT89c51 microcontroller and the ultrasonic transducer module HC-SR04 form the basis of this circuit.

A sensor is mounted at the back of the car. It detects the distance by sending electromagnetic
pulses through a transmitter,reflected by an obstacle. The sensor is connected to the HC-SR04 module. This module works on 5V DC supply and the standby current is less than 2mA. It transmits an ultrasonic signal, picks up its echo, measures the time elapsed between the two events and outputs a waveform whose high time is modulated by the measured time which is proportional to the distance. 

The microcontroller accepts this signal, performs necessary processing and displays the corresponding distance on the 16x2 LCD. 
This distance is displayed on the LCD and if it is less than 20 centimetre, a buzzer is sound.


### Design
* Make "Trig" pin of the sensor high for 10 microseconds. This initiates a sensor cycle.
* 8 x 40 kHz pulses will be sent from the transmitting transducer of the sensor, after which time the "Echo" pin on the sensor will go from low to high.
* The 40 kHz sound wave will bounce off the nearest object and return to the sensor.
* When the sensor detects the reflected sound wave, the Echo pin will go low again.
* The distance between the sensor and the detected object can be calculated based on the length of time the Echo pin is high.
* If no object is detected, the Echo pin will stay high for 38ms and then go low. 

### Components Used
*	AT89c51 chip 
*	Jumper wires
* Rainbow wires
* 16x2 LCD
* Buzzer
* HC-SR04 module (transducer)
* Wireless Remote Controlled car
* 9V DC Battery
* Development Board

### Block Diagram
![1](https://user-images.githubusercontent.com/23147474/30789155-7e7a9570-a171-11e7-944a-6f9712aa4b9f.JPG)

### Circuit Configuration
To inter face the sensor to AT89c51 microcontroller we need two I/O pins. One is connected to P3.2 and other to P3.5
* Connect the trigger pin of sensor to P3.5 of AT89c51
* Connect the echo pin of the sensor to P3.2 0f AT89c51
* Configure the TIMER of 8051 in mode 1. When P3.2 is high then the TIMER starts counting. Whenever P3.2 goes low TIMER0 holds its count.
* As the P3.2 pin is input declare the pin as input. Write “1” to the pin to make it input.

### Circuit Diagram

### Algorithm
1. Send a 10 micro second high pulse at trigger

                                      Initially P3.5=0;
                                      
                                      P3.5=1;
                                      
                                      Delay(10 micro second);
                                      
                                      P3.5=0;
                                      
2. "WAIT" until the sensor transmits the eight 40KHz pulses and signal reflection.

Initially the "ECHO" pin is low when the transmitter completes the pulse the pin goes high then our TIMER starts counting. When input at P3.2 goes low timer holds count. Logic for waiting:

                                      while(P3.2==0);
                                      
                                      while(P3.2==1); 
                                      
but some times due to errors in the sensor functioning the 8051 microcontroller may go into an "INFINITE LOOP" 
for that there are two remedies
 * use watch dog timer(present on AT89S52 and other advanced versions)
 * generate a delay of 40 milliseconds after triggering the ultrasonic sensor.
 
The second option has been used in this project.

3. TIMER value = time taken by the signal to (go forward+come back)

It measures the signal traces the whole distance twice. 

so time taken by the signal to travel the distance = TIMER0 value/2 

ULTRASONIC  pulse travels with the speed of sound 340.29 m/s = 34029 cm/s 

range of target= velocity *time ==> 34029 * TIMER0/2

                                                  ==>  17015 * TIMER0
                                                  
At 12MHz TIMER0 gets incremented for 1microsecond.

        RANGE    =    17015 centimeters/seconds  *  TIMER0 micro seconds

                           =    17015 centimeters/seconds *  TIMER0 * (10^-6)  seconds                 
                                     as            (1micro second=10^-6 seconds)
                        
                           =    17015 centimeters/seconds *  TIMER0 * (10^-6)  seconds  
                         
                              
                           =    17015  *  TIMER0     centimeters 
                                        (1000000)   
                           
                           =       TIMER0_______     centimeters 
                                    1000000/ 17015  

                           =       TIMER0_   centimeters 
                                    58.771

                   RANGE of target  =  (TIMER/59)   centimeters 
                   
This formula is used to calculate the range of the target easily.


