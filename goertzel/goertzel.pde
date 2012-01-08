/* Goertzel Algorithm Arduino Implementation
 Created by Allen Lee (alee@sparke.ca) 20-Nov/2011
 
 The Goertzel Algorithm is a stripped down version of the FFT which does not require as much horsepower as the FFT.
 It is perfect for determining if a handful of frequencies in a signal are present.
 
 */

#import "math.h"

#define SIGIN A0
#define N 160    // Number of bins
#define target 500  // Target frequency
#define samp 8000  // Sampling Frequency
#define flag 2
#define flagdetect 3
#define pi 3.14159

//void process(float array[]);

void setup(){
  Serial.begin(9600);
  // Use default 5V Analog Reference ie. 5V = 1023 when going through ADC
  analogReference(DEFAULT);
  // Define signal processing interrupt
  //attachInterrupt(0,process,RISING);
  // Enable interrupts
  //interrupts();
  // Flagging pins
  //pinMode(flag, OUTPUT);
  //pinMode(flagdetect, INPUT);
}

//  Setup global variables

float k = (0.5+((N*target)/samp));
float w = ((2*pi)/N)*k;
float cosine = cos(w);
float sine = sin(w);
float coeff = 2*cosine;

void loop(){
  
  float block[N];
  unsigned long currentTime = micros();

  for(int i=0; i<(N); i++){
    while(micros() - currentTime < (i+1)*125UL){    // Ensures sampling occurs at 8 kHz (Arduino forum)
      block[i] = analogRead(SIGIN);
      //Serial.println(block[i],DEC);
    }
  }

  process(block);

  //digitalWrite(flag, HIGH);
  //digitalWrite(flag, LOW);

}

void process(float array[]){
  float Q1 = 0;
  float Q2 = 0;

  for(int i=0; i < N; i++){
    float Q0 = (coeff*Q1)-Q2+array[i];
    Q2 = Q1;
    Q1 = Q0;
  }

  float real = Q1-(Q2*cosine);
  float imag = Q2*sine;
  float mag2 = pow(real,2)+pow(imag,2);

  Serial.println(mag2, DEC);
  //Serial.println(block[23],DEC);

}








