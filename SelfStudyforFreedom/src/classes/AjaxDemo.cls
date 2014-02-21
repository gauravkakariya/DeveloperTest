public with sharing class AjaxDemo {
	
	public string currTime{get;set;}
	
	public AjaxDemo(ApexPages.StandardController stdController){
		 //this.Contact = (Contact)stdController.getRecord();
	}
		 	
		   public Component.Apex.PageBlockTable getPageBlockDate(){
		            List<Contact> lstContact = [select id,Name,FirstName,LastName from Contact];
		            Component.Apex.PageBlockTable pbTable = new Component.Apex.PageBlockTable();
		            pbTable.value = lstContact ;
		            pbTable.var = 'x';
		            pbTable.columns =3;
		            pbTable.border= '10' ;          
		            Component.Apex.Column firstNameCol = new Component.Apex.Column();
		            firstNameCol.expressions.value = '{!x.FirstName}';
		            Component.Apex.Column firstNameCol1 = new Component.Apex.Column();
		            firstNameCol1.expressions.value = '{!x.Id}';
		            pbTable.childComponents.add(firstNameCol);
		            pbTable.childComponents.add(firstNameCol1);
		            return pbTable;
	        }
	       
	   
	        public Component.Apex.SectionHeader getHeaderWithDueDateCheck() {
		        date dueDate = date.newInstance(2011, 7, 4);
		        boolean overdue = date.today().daysBetween(dueDate) < 0;
		 
		        Component.Apex.SectionHeader sectionHeader = new Component.Apex.SectionHeader();
		        if (overdue) {
		            sectionHeader.title = 'This Form Was Due On ' + dueDate.format() + '!';
		            return sectionHeader;
		        }
		        else{
		            sectionHeader.title = 'Form Submission';
		            return sectionHeader;
		        }
	        }  
		    
	/*
	public void setCurrentTime(){
		
		currTime = System.now().format('EEEE, MMMM d, yyyy - hh:mm:ss');
	}
	public string getCurrentTime(){
		return currTime;
	}
	
		public Component.Apex.TabPanel getMyTabs(){
			
			 //create parent panel 
			 Component.Apex.TabPanel myTabPanel = new Component.Apex.TabPanel();  
			
			 for (integer i=0;i<3;i++)  {
			 	Component.Apex.Tab myTab = new Component.Apex.Tab();
			 	myTab.Label = 'Tab ' + string.valueOf(i+1);
			   	//add child tabs to the parent
			   	myTabPanel.childComponents.add(myTab);
			 }
			  return myTabPanel;
		 }
	*/	 
		 
}