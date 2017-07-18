#include<GLUT/glut.h>
#include<OpengL/gl.h>
#include<OpengL/glu.h>
#include<math.h>

void circle_draw(int x,int y,int r)
{
	GLfloat x1,y1,i;
	glColor3f(0.0,0.0,0.0);
	glPointSize(2.0);
	glBegin(GL_LINE_LOOP);
	for(i=0;i<6.38;i+=0.01)
	{
		x1 = r * cos(i) + x;
		y1 = r* sin(i) + y;
		glVertex2f(x1,y1);		
	}
	glEnd();
	glFlush();
}

void parallelopiped(int x1,int x2,int y1, int y2,int y3,int y4)
{
	glColor3f(0.0,0.0,0.0);
	glPointSize(2.0);
	glBegin(GL_LINE_LOOP);
	glVertex2i(x1,y1);
	glVertex2i(x2,y3);
	glVertex2i(x2,y4);
	glVertex2i(x1,y2);
	glEnd();
}


void cylinder_draw()
{
	GLint x=100,y=100,r=50,i;
	//int i;
	for(i=0;i<90;i+=2)
	{
		circle_draw(x,y+i,r);
	}
	//glFlush();
}

void parallelopiped_draw()
{
	int x1=200,x2=300,y1=100,y2=175,y3=100,y4=175;
	GLint i,n=40;
	
	for(i=0;i<n;i+=2)
	{
		parallelopiped(x1+i,x2+i,y1+i,y2+i,y3+i,y4+i);
	}	
}

void display()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(1.0,0.0,0.0);
	glPointSize(2.0);
	
	cylinder_draw();
	parallelopiped_draw();
	glFlush();
}

void init()
{
	glClearColor(1.0,1.0,1.0,1.0);
	glMatrixMode(GL_PROJECTION);
	gluOrtho2D(0.0,400.0,0.0,300.0);
}

int main(int argc,char**argv)
{
	glutInit(&argc,argv);
	glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
	glutInitWindowPosition(50,50);
	glutInitWindowSize(400,300);
	glutCreateWindow("cylinder and parallelopiped");
	init();
	glutDisplayFunc(display);
	glutMainLoop();
	return 0;
}
