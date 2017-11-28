#include<iostream>
#include<GLUT/glut.h>

#define maxx	10
#define maxy	10
#define dx		20
#define dy		20

void display()
{
	int i,j,x=10,y;
	glClear(GL_COLOR_BUFFER_BIT);
	for(i=0;i<maxx;i++)
	{
		y = 10;
		for(j=0;j<maxy;j++)
		{
			glBegin(GL_LINE_LOOP);
				glVertex2f(x,y);
				glVertex2f(x+dx,y);
				glVertex2f(x+dx,y+dy);
				glVertex2f(x,y+dy);
			glEnd();
			y	+= dy;
		}
		x		+= dx;
	}
	glFlush();
}

void init()
{
	glClearColor(1.0,1.0,1.0,1.0);
	glColor3f(1.0,0.0,0.0);
	glPointSize(5.0);
	gluOrtho2D(0,499.0,0,499.0);
}
int main(int argc, char** argv)
{
	glutInit(&argc,argv);
	glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(500,500);
	glutCreateWindow("Rectangular Mesh");
	glutDisplayFunc(display);
	init();
	glutMainLoop();
}