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

### Block Diagram
![1](https://user-images.githubusercontent.com/23147474/30789155-7e7a9570-a171-11e7-944a-6f9712aa4b9f.JPG)

### Database
We used MySQL for database connectivity with a database named `Portal` containing the following tables:

* `Student(regno varchar(10) primary key,name varchar(10),gender varchar(10),email varchar(10),dob date,phone varchar(10) ,resume text,cgpa varchar(10));`
* `Company(name varchar(10) primary key,branch varchar(10),dateproc date,branch varchar(10),offer varchar(10),cgpa varchar(10),ctc varchar(10),stipend varchar(10));`
* `Stud_comp(regno varchar(10) foreign key,company name varchar(10) foreign key);`
* `Admin(username varchar(10),password varchar(10));`

### 
