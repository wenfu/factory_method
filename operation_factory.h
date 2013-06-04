#ifndef __OPERATION_FACTORY_H
#define __OPERATION_FACTORY_H

#include "operation_add.h"
#include "operation_sub.h"
#include "operation_mul.h"
#include "operation_div.h"
#include "common.h"

class OperationFactory
{
public:
	Operation *createOperation(char operate);
private:
	Operation *oper;
};
#endif
