#include <cstdlib>
#include "operationFactory.h"
#include "common.h"

int main(int argc, char *argv[])
{
	OperationFactory op;
	Operation *oper;
	oper = op.createOperation('+');
	oper->set_numberA(10.0);
	oper->set_numberB(5.0);

	double sum = oper->getResult();
	printf("%lf\n",sum);

	return 0;
}
