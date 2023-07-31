// Fourier transform of an image


PImage img;
float fourier[][] = new float [256][256]; //2D matrix containing the values of all amplitudes
float fourierpartiereelle[][] = new float [256][256]; //2D matrix of the real part
float fourierpartieimaginaire[][] = new float [256][256]; //2D matrix of the imaginary part
float fouriermagnitude = 0; //stock the value of the magnitude
float fourierexp = 0; //stock the exponential value during calculation
float maxvaluemag = 0; //max value of the magnitude
float intensity[][] = new float [256][256]; //2D matrix containing the values of all intensities values from image
float shiftmatrix[][] = new float [256][256]; //2D matrix containing alternation of +1 and -1 for shifted
float shiftedimage[][] = new float [256][256]; //2D matrix containing the values of all shifted intensities values from imqge
float colorvalue;

void setup() {
  size(256,768);
  colorMode(RGB,255,255,255);
  img = loadImage("son3rot1.gif");
  float imgWidth = img.width;
  float imgHeight = img.height;
//Calculation of Fourier transform
  for (int k = 0; k < img.width; k++) {
      for (int l = 0; l < img.height; l++) {
        intensity[k][l] = red(img.get(k,l));
      }
  }
  
  for (int x = 0; x < img.width; x++) {
      for (int y = 0; y < img.height; y++) {
        shiftmatrix[x][y] = pow(-1,x+y);
      }
  }
  
  for (int a = 0; a < img.width; a++) {
      for (int b = 0; b < img.height; b++) {
        for (int c = 0; c < img.height; c++) {
          shiftedimage[a][b] += intensity[c][b]*shiftmatrix[a][c];
      }
      }
  }

  
  for (int k = 0; k < img.width; k++) {
    print(k);
    for (int l = 0; l < img.height; l++) {
      fouriermagnitude=0;
      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          float ki = k*i;
          float lj = l*j;
          fourierexp = (-2*PI*((ki/imgWidth)+(lj/imgHeight)));
          fourierpartiereelle[k][l] += shiftedimage[i][j]*cos(fourierexp);
          fourierpartieimaginaire[k][l] += shiftedimage[i][j]*sin(fourierexp);
        }
      }
      fouriermagnitude = sqrt((fourierpartiereelle[k][l])*(fourierpartiereelle[k][l]) + (fourierpartieimaginaire[k][l])*(fourierpartieimaginaire[k][l]));
      if (fouriermagnitude > maxvaluemag) {
        maxvaluemag = fouriermagnitude;
      }
      fourier[k][l] = fouriermagnitude;
    }
  }
  print("done");
  //set color mode to RGB
}

void draw() {
  image(img, 0, 0);
  loadPixels();
  for (int k = 0; k < img.width; k++) {
    for (int l = 0; l < img.height; l++) {
      float c = 255.0 / log(1 + maxvaluemag);
      colorvalue = c * log(1 + fourier[k][l]);
      //colorvalue = 255*fourier[k][l]/maxvaluemag;
      pixels[256*256+img.width*k+l] = color(colorvalue, colorvalue, colorvalue);
    }  
   }
  updatePixels();
}
