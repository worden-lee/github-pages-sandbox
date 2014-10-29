export SageUtils=../SageDynamics/SageUtils
export SageDynamics=../SageDynamics/SageDynamics

$(SageDynamics)/% :
	$(MAKE) -C $(SageDynamics) $*
 
$(SageUtils)/% :
	$(MAKE) -C $(SageUtils) $*
 
# Use the general rules from the utility project's makefiles
-include $(SageUtils)/sage.mk
-include $(SageUtils)/step.mk
