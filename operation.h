#ifndef __OPERATION_H
#define __OPERATION_H

#include <iostream>
using namespace std;

class Operation {
public:    
	void set_numberA(double a);
	double get_numberA();
	void set_numberB(double b);
	double get_numberB();
	virtual double getResult();
	virtual ~Operation(){};
private:
	double m_numberA;
	double m_numberB;
};
#endif
