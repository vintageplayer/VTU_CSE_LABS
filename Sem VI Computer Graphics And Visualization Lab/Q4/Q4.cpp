#include<iostream>
#include<GLUT/glut.h>
#include<OpengL/gl.h>
#include<Opengl/glu.h>
#include<math.h>

using namespace std;

GLfloat house[3][9] = {
	{100,100,175,250,250,150,150,200,200},
	{100,300,400,300,100,100,150,150,100},
	{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}
};

GLfloat rot_mat[3][3] = {{0},{0},{0}};
GLfloat result[3][9] = {{0},{0},{0}};
GLfloat h = 100,k = 100, theta;

void drawhouse(GLfloat points[][9])
{
	glBegin(GL_LINE_LOOP);
		glVertex2f(points[0][0],points[1][0]);
		glVertex2f(points[0][1],points[1][1]);
		glVertex2f(points[0][3],points[1][3]);
		glVertex2f(points[0][4],points[1][4]);
		glVertex2f(points[0][5],points[1][5]);
		glVertex2f(points[0][6],points[1][6]);
		glVertex2f(points[0][7],points[1][7]);
		glVertex2f(points[0][8],points[1][8]);
	glEnd();
	glBegin(GL_LINE_LOOP);
		glVertex2f(points[0][1],points[1][1]);
		glVertex2f(points[0][2],points[1][2]);
		glVertex2f(points[0][3],points[1][3]);
	glEnd();
}


void rotate()
{
	theta = -45.0;
	GLfloat m = -h*(cos(theta)-1) + k*sin(theta);
	GLfloat n = -k*(cos(theta)-1) - h*sin(theta);
	rot_mat[0][0] = cos(theta);
	rot_mat[0][1] = -sin(theta);
	rot_mat[0][2] = m;
	rot_mat[1][0] = sin(theta);
	rot_mat[1][1] = cos(theta);
	rot_mat[1][2] = n;
	rot_mat[2][0] = 0;
	rot_mat[2][1] = 0;
	rot_mat[2][2] = 1;
	
	int i,j,k;
	
	for(i=0;i<3;i++)
	{
		for(j=0;j<9;j++)
		{
			for(k=0;k<3;k++)
			{
				result[i][j] += rot_mat[i][k]*house[k][j];
			}
		}
	}
}

void display()
{
	glClear(GL_COLOR_BUFFER_BIT);
	drawhouse(house);
	rotate();
	drawhouse(result);
	glFlush();
}

void init()
{
	glClearColor(1.0,1.0,1.0,1.0);
	glColor3f(1.0,0.0,0.0);
	glPointSize(2.0);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0,499.0,0,499.0);
}

int main(int argc, char  **argv)
{
	glutInit(&argc,argv);
	glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
	glutInitWindowPosition(50,50);
	glutInitWindowSize(500,500);
	glutCreateWindow("House rotation");
	glutDisplayFunc(display);
	init();
	glutMainLoop();
}
