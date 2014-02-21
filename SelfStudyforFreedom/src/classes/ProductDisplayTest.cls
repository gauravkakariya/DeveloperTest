/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ProductDisplayTest {


	     	
 //check for all records
    static testMethod void ProductDisplayTest()
     {
        
         PageReference ref= Page.ProductDetails;
	     	Test.setCurrentPageReference(ref);
	     	
	     	Product2 productObj=new Product2(Name='test1',ProductCode='101');
	     	
	     	test.startTest();
	     	
	     	insert productObj;
	     	
	     	ProductDisplay productDisplayObj=new ProductDisplay();	     	
	     	
	     	
	     	productDisplayObj.prodView='RecentlyModified';
	     	productDisplayObj.Search();
	     	

	      List<Product2>  productList1=[select ProductCode, Name from Product2 where Name='test1'];
	      
	     	productDisplayObj.Search();
	     	productDisplayObj.getLink();
	     	
	      List<Product2> productList= productDisplayObj.lstProduct;
	     
	     
	      
	     	test.stopTest();
	     	
         system.assert(productList.get(0).Name==productList1.get(0).Name);
        
    }//end of ProductDisplayTest()
    
    
    //check for add rowtest
     static testMethod void addRowTest()
     {
     		PageReference ref= Page.ProductDetails;
	     	Test.setCurrentPageReference(ref);
	     	
     		test.startTest();
     		
 	      ProductDisplay productDisplayObj=new ProductDisplay();
 	      
 	    
     		Product2 productObj=new Product2(Name='test3',ProductCode='102');
     		
     		List<Product2> productList=new List<Product2>();
     		productList.add(productObj);
     		
     		productDisplayObj.products=productList;
     		
     		productDisplayObj.save();
     		productDisplayObj.addrow();
     		
     		Product2 productObj1=[select Name,ProductCode from Product2 where Name='test3'];
     		system.assert(productObj1.Name=='test3');
     	      system.assert(productList.Size()==2);
     		
     		test.stopTest();
     	
     }//end of addRowTest()
     
     
     //check for delete rowtest
      static testMethod void delRowTest()
     {
     		PageReference ref= Page.ProductDetails;
	     	Test.setCurrentPageReference(ref);
	     	
     		
     		test.startTest();
 	      ProductDisplay productDisplayObj=new ProductDisplay();
 	      Product2 productObj=new Product2(Name='test3',ProductCode='102');
 	      List<Product2> tempList=new List<Product2>();
 	      tempList.add(productObj);
 	      productDisplayObj.products=tempList;
 	  
 	    	productDisplayObj.save();
 	      Product2 newObj=[select Name from Product2 where Name='test3'];
 	    	productDisplayObj.del();
     		productDisplayObj.delrow();
     		//productDisplayObj.save();
     		List<Product2> delObj=[select Name from Product2 where Name='test3'];
     		
     		test.stopTest();
     		
     		system.assertEquals(newObj.Name,'test3');
     		system.assertEquals(delObj.Size(),0);
     	
     	
     }//end of delRowTest()
    
}//end of class