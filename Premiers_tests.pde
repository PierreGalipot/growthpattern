// Fourier transform of an image


PImage img;
float fourier[][] = new float [256][256]; //2D matrix containing the values of all amplitudes
float fourierpartiereelle[][] = new float [256][256]; //2D matrix of the real part
float fourierpartieimaginaire[][] = new float [256][256]; //2D matrix of the imaginary part
float fouriermagnitude = 0; //stock the value of the magnitude
float fourierexp = 0; //stock the exponential value during calculation
float maxvaluemag = 0; //max value of the magnitude
float intensity[][] = new float [256][256]; //2D matrix containing the values of all amplitudes
float colorvalue;

void setup() {
  size(256,512);
  colorMode(RGB,255,255,255);
  img = loadImage("son3rot1.gif");
//Calculation of Fourier transform
for (int k = 0; k < img.width; k++) {
    for (int l = 0; l < img.height; l++) {
      intensity[k][l] = red(img.get(k,l));
    }
}


for (int k = 0; k < img.width; k++) {
  print(k);
    for (int l = 0; l < img.height; l++) {
      fouriermagnitude=0;
        for (int i = 0; i < img.width; i++) {
          for (int j = 0; j < img.height; j++) {
            fourierexp = (-2*PI*((k*i/img.width)+(l*j/img.height)));
            fourierpartiereelle[k][l] += intensity[i][j]*cos(fourierexp);
            fourierpartieimaginaire[k][l] += intensity[i][j]*sin(fourierexp);
            
            }
          }
      fouriermagnitude = sqrt((fourierpartiereelle[k][l])*(fourierpartiereelle[k][l]) + (fourierpartieimaginaire[k][l])*(fourierpartieimaginaire[k][l]));
      if (fouriermagnitude > maxvaluemag) {
        maxvaluemag = fouriermagnitude;
        }
      fourier[k][l] = fouriermagnitude;
        }
        }
  //set color mode to RGB
}

void draw() {
  image(img, 0, 0);
  loadPixels();
  for (int k = 0; k < img.width; k++) {
    for (int l = 0; l < img.height; l++) {
      colorvalue = 255*fourier[k][l]/maxvaluemag;
      pixels[256*256+img.width*k+l] = color(colorvalue, colorvalue, colorvalue);
    }  
   }
  
  updatePixels();
  
}
