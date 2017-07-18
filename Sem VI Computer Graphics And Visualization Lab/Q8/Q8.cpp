#include<iostream>
#include<GLUT/glut.h>
#include<OpengL/gl.h>
#include<OpengL/glu.h>

using namespace std;

GLfloat points[8][3] = {
	{-1.0,-1.0,-1.0},{1.0,-1.0,-1.0},{1.0,1.0,-1.0},
	{-1.0,1.0,-1.0},{-1.0,-1.0,1.0},{1.0,-1.0,1.0},
	{1.0,1.0,1.0},{-1.0,1.0,1.0}
};

GLfloat colors[8][3] = {
	{0,0,0},{1,0,0},{1,1,0},
	{0,1,1},{0,0,1},{1,0,1},
	{1,1,1},{0,1,1}
};

GLfloat axis[3] = {0.0,0.0,0.0};
int axi = 2;

void polygon(int a,int b,int c,int d)
{
	glBegin(GL_POLYGON);
		glColor3fv(colors[a]);
		glVertex3fv(points[a]);
		glColor3fv(colors[b]);
		glVertex3fv(points[b]);
		glColor3fv(colors[c]);
		glVertex3fv(points[c]);
		glColor3fv(colors[d]);
		glVertex3fv(points[d]);
	glEnd();
}

void colorcube()
{
	polygon(0,3,2,1);
	polygon(5,1,2,6);
	polygon(4,5,6,7);
	polygon(4,7,3,0);
	polygon(2,3,7,6);
	polygon(5,4,0,1);
}

void display()
{
	glClearColor(1.0,1.0,1.0,1.0);
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glRotatef(axis[0],1.0,0.0,0.0);
	glRotatef(axis[1],0.0,1.0,0.0);
	glRotatef(axis[2],0.0,0.0,1.0);
	colorcube();
	glFlush();
	glutSwapBuffers();
}

void spincube()
{
	axis[axi] += 1.0;
	if(axis[axi]>360)
		axis[axi] = -360.0;
	glutPostRedisplay();
}

void mouse(int btn,int state,int x,int y)
{
	if(btn==GLUT_LEFT_BUTTON && state==GLUT_DOWN) axi = 0;
	if(btn==GLUT_MIDDLE_BUTTON && state==GLUT_DOWN) axi = 1;
	if(btn==GLUT_RIGHT_BUTTON && state==GLUT_DOWN) axi = 2;
}

void reshape(int w,int h)
{
	glViewport(0,0,w,h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	if(w<=h)
		glOrtho(-2.0,2.0,-2.0*(GLfloat(h)/GLfloat(w)),2.0*((GLfloat)h/(GLfloat)w),-10.0,10.0);
	else
		glOrtho(-2.0*((GLfloat)w/(GLfloat)h),2.0*((GLfloat)w/(GLfloat)h),-2.0,2.0,-10.0,10.0);
	glMatrixMode(GL_MODELVIEW);
}

int main(int argc,char **argv)
{
	glutInit(&argc,argv);
	glutInitDisplayMode(GLUT_DOUBLE|GLUT_RGB|GLUT_DEPTH);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(500,500);
	glutCreateWindow("Spinning Cube");
	glutDisplayFunc(display);
	glutIdleFunc(spincube);
	//glutFullScreen();
	glutMouseFunc(mouse);
	glutReshapeFunc(reshape);
	glEnable(GL_DEPTH_TEST);
	glutMainLoop();
}
