#include<OpengL/gl.h>
#include<OpengL/glu.h>
#include<GLUT/glut.h>

void display()
{
	glClearColor(0.0,0.0,0.0,1.0);
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glColor3f(1,1,0);
	glPointSize(5);
	glBegin(GL_LINE_LOOP);
		glVertex3f(-100,50,0);
		glVertex3f(100,50,200);
		glVertex3f(200,200,100);
	glEnd();
	glFlush();
}

void init()
{
	glClearColor(1.0,1.0,1.0,1.0);
	//glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char **argv)
{
	glutInit(&argc,argv);
	glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB|GLUT_DEPTH);
	glutInitWindowPosition(0,0);
	glutInitWindowSize(500,500);
	glutCreateWindow("Serpenski's Tetrahedron");
	glutDisplayFunc(display);
	glEnable(GL_DEPTH_TEST);
	//init();
	glutMainLoop();
}
