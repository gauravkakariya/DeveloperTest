public with sharing class XrayProblem {
	
	public string answer{get; set;}
	public boolean check {get; set;}
	
	//First question answer
	public List<Selectoption> getXrayAnswer(){
		
		List<Selectoption> options = new List<Selectoption>();
		options.add(new Selectoption('1','have no idea where money goes'));
		options.add(new Selectoption('2','I know where money goes but I have no control over it'));
		options.add(new Selectoption('3','have no idea where money goes'));
		options.add(new Selectoption('3','have no idea where money goes'));
		
		return options;
	}
	public  XrayProblem()
	{
		check = false;
	}
	public PageReference test() {
		check = true;
        return null;
    }
    
    
}