#pragma once //prevent repeated references

#include "FreeImage.h"
#include "stdlib.h"


class gFreeImage
{
public:
	gFreeImage(void);
	~gFreeImage(void);
public:
    FIBITMAP *bitmap;
	unsigned char *imageData;
	unsigned char *imageData4;
	FREE_IMAGE_FORMAT imagetype;
	int width;
	int height;
	int imageDatalength;
	int imageData4length;

	int LoadImage(char *filename);
	int LoadImageGrey(char *filename);
	int SaveImage(char *filename);
	int SaveImageGrey(char *filename);
    unsigned char * getImageData(int& w, int& h);
	unsigned char * getImageDataGrey(int& w, int& h);

	int updateImageData(unsigned char *m_imageData, int m_width, int m_high, int BitsPP);
};
