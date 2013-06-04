#ifndef __OPERATION_FACTORY_H
#define __OPERATION_FACTORY_H

#include "operationAdd.h"
#include "operationSub.h"
#include "operationMul.h"
#include "operationDiv.h"
#include "common.h"

class OperationFactory
{
public:
	Operation *createOperation(char operate);
private:
	Operation *oper;
};
#endif
