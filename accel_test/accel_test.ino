/*  Accelerometer Test
    Written by Allen Lee (alee@sparke.ca)
    Uses the Lilypad Accelerometer (ADXL335)
    IMPORTANT:  SUPPLY THE ACCELEROMETER WITH VDD=3.3 V  JUMPER 3.3 V ON AN UNO TO AREF
    A good tutorial on accelerometers is on Instructables at: http://www.instructables.com/id/Accelerometer-Gyro-Tutorial
*/


// Setup global variables for analog read (x,y & z), voltages (vx,vy & vz) and g-readings (gx,gy & gz)
int x,y,z;
float vx, vy, vz, gx, gy, gz;


void setup()
{
  Serial.begin(9600);
  analogReference(EXTERNAL);
}


void loop()
{
  // Read in accelerometer values
  x = analogRead(A0);
  y = analogRead(A1);
  z = analogRead(A2);
  
  // Convert ADC values to voltages and G values
  // The formula for voltage conversion is v = (ADCREAD*VREF/1023)-ZGV, where ZGV is "Zero-G voltage" (voltage at 0G)
  // ZGV is found in the spec sheet and happens to be 1.5 in our case.  Warning: you need to make the variable signed!
  // The formula for G conversion is g = v/SENSITIVITY.  The sensitvity is also found in the spec sheet and happens to be 300 mV/g here.
  // Remember to make your units consistent! (g = v[V]*1000 / SEN [mV] )
  vx = (x*3.3/1023)-1.5;
  gx = vx*10/3;
  vy = (y*3.3/1023)-1.5;
  gy = vy*10/3;
  vz = (z*3.3/1023)-1.5;
  gz = vz*10/3;
  
  Serial.print("gx=");
  Serial.print(gx,DEC);
  Serial.print("  ");
  Serial.print("gy=");
  Serial.print(gy,DEC);
  Serial.print("  ");
  Serial.print("gz=");
  Serial.println(gz,DEC);
  
  delay(50);
  
}
  
