# Car-Parking-Sensor

Assembly 8051

### About
A simple ultrasonic range finder using `8051` microcontroller to measure distances up to 2.5 meters at an accuracy of 1
centimetre. `AT89c51` microcontroller and the ultrasonic transducer module `HC-SR04` forms the basis of this circuit.

A sensor is mounted at the back of the car. It detects the distance by sending electromagnetic
pulses through a transmitter, reflected by an obstacle. The sensor is connected to the HC-SR04 module. This module works on a 5V DC supply and the standby current is less than 2mA. It transmits an ultrasonic signal, picks up its echo, measures the time elapsed between the two events and outputs a waveform whose high time is modulated by the measured time which is proportional to the distance. 

The microcontroller accepts this signal, performs necessary processing and displays the corresponding distance on the `16x2 LCD`. 
If this distance is less than 20 centimetre, a `buzzer` is sound.

### Design
* Make `Trigger` pin of the sensor high for 10 microseconds. This initiates a sensor cycle.
* 8 x 40 kHz pulses will be sent from the transmitting transducer of the sensor.
* The `Echo` pin on the sensor goes from low to high.
* The 40 kHz sound wave bounces off the nearest object and returns to the sensor.
* When the sensor detects a reflected sound wave, the `Echo` pin goes to low again.
* The distance between the sensor and the detected object can be calculated based on the length of time, the Echo pin is high.
* If no object is detected, the `Echo` pin will stay high for 38ms and then go low. 

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
To interface the sensor to `AT89c51` microcontroller, we need two I/O pins. One is connected to `P3.2` and other to `P3.5`.
* Connect the `Trigger` pin of sensor to `P3.5` of `AT89c51`.
* Connect the `Echo` pin of the sensor to `P3.2` of `AT89c51`.
* Configure the `TIMER` of 8051 in mode 1.
* When `P3.2` is high, the `TIMER` starts counting.
* When `P3.2` goes low, `TIMER0` holds it's count.
* Declare `P3.2` as input.

### Circuit Diagram
![2](https://user-images.githubusercontent.com/23147474/30789361-0873a662-a173-11e7-83fa-970c5779dca9.JPG)


### Algorithm
1. Send a 10 micro second high pulse at `Trigger`: 

                                      P3.5=0;
                                      
                                      P3.5=1;
                                      
                                      Delay(10 micro second);
                                      
                                      P3.5=0;
                                      
2. Wait until the sensor transmits the eight 40KHz pulses and signal reflection. Initially the `Echo` pin is low. When the transmitter completes a pulse and the pin goes high, the TIMER starts counting. When input at `P3.2` goes low, timer holds count. Logic used to implement this is:

                                      while(P3.2==0);
                                      
                                      while(P3.2==1); 
                                      
Sometimes, due to errors in the sensor functioning, the 8051 microcontroller may go into an infinite loop. To solve that issue we generate a delay of 40 milliseconds after triggering the ultrasonic sensor.
 
3. `TIMER value = time taken by the signal to (go forward + come back)`

It measures the signal traces the whole distance twice. So, the time taken by the signal to travel the distance is:

                                `Time taken= TIMER0 value/2`

4.` ULTRASONIC pulse travels with the speed of sound 340.29 m/s = 34029 cm/s `

5.` Range of target= velocity * time = 34029 * TIMER0/2 =  17015 * TIMER0`
                                                  
6. At 12MHz, TIMER0 gets incremented for 1microsecond.

                     Range =    17015 centimeters/seconds  *  TIMER0 micro seconds

                           =    17015 centimeters/seconds *  TIMER0 * (10^-6)  seconds                 
                                     as            (1micro second=10^-6 seconds)
                        
                           =    17015 centimeters/seconds *  TIMER0 * (10^-6)  seconds  
                         
                              
                           =    17015  *  TIMER0     centimeters 
                                        (1000000)   
                           
                           =       TIMER0_______     centimeters 
                                    1000000/ 17015  

                           =       TIMER0_   centimeters 
                                    58.771

          Range of target  =  (TIMER/59)  centimeters 
                   
This formula is used to calculate the range of the target easily.


