component implements="cfflow.models.implementation.interfaces.IWorkflowInstanceStorage" {

	public boolean function instanceExists( required struct instanceArgs ){ return false; }

	public void function createInstance( required struct instanceArgs ){}

	public struct  function getState( required struct instanceArgs ){ return {}; }

	public void function setState( required struct instanceArgs, required struct state ){}

	public void function appendState( required struct instanceArgs, required struct state ){}

	public string function getStepStatus( required struct instanceArgs, required string step ){ return "pending"; }

	public void function setStepStatus( required struct instanceArgs, required string step, required string status ){}

	public struct function getAllStepStatuses( required struct instanceArgs ){ return {}; }

}