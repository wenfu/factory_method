#include "operation_factory.h"

Operation *OperationFactory::createOperation(char operate) {
	switch(operate) {
	case '+':
		oper = new OperationAdd();
		break;
	case '-':
		oper = new OperationSub();
		break;
	case '*':
		oper = new OperationMul();
		break;
	case '/':
		oper = new OperationDiv();
		break;
	default:
    	  printf("input error\n");
	}

	return oper;
}
