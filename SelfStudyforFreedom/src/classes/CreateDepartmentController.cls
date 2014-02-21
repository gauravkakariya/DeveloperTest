public with sharing class CreateDepartmentController
{
    private ApexPages.StandardController controller;
	String sfurl = '';
	
	public CreateDepartmentController(ApexPages.StandardController controller)
	{
		this.controller = controller;
		sfurl = URL.getSalesforceBaseUrl().toExternalForm();
	}
	
	
	public PageReference redirect() 
	{
		String userId = UserInfo.getUserId();
		String userName = UserInfo.getName();
		
		String Url =sfurl+'/a0F/e?nooverride=1&CF00N900000073RWA='+userName+'&CF00N900000073RWA_lkid='+userId+'&retURL=%2Fa0F%2Fo';
		PageReference returnURL = New PageReference(Url);
		returnURL.setRedirect(false);
		return returnURL;
			
	}
    
   
}