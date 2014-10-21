export SageUtils=../SageDynamics/SageUtils
export SageDynamics=../SageDynamics/SageDynamics

$(SageDynamics)/* :
	$(MAKE) -C $(SageDynamics) $*
 
$(SageUtils)/% :
	$(MAKE) -C $(SageUtils) $*
 
# The good makefile stuff is upstream, just reuse it
-include $(SageUtils)/sage.mk
-include $(SageUtils)/step.mk
