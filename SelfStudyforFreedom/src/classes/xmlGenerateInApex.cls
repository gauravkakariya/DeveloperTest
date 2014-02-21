public with sharing class xmlGenerateInApex {
	
	 public static String getXml() {
	 	
	 	Xmlstreamwriter xmlW = new Xmlstreamwriter();
        xmlW.writeStartDocument('utf-8','1.0');
        
        xmlW.writeStartElement(null,'Account', null); 
           
        xmlW.writeStartElement(null,'Name',null);
        xmlW.writeCharacters('zxc');
        xmlW.writeEndElement();
        
        xmlW.writeStartElement(null,'First_Name',null);
        xmlW.writeCharacters('gaurav');
        xmlW.writeEndElement();
        
        xmlW.writeStartElement(null,'Last_Name', null);
        xmlW.writeCharacters('espl');
        xmlW.writeEndElement();
        
        xmlW.writeEndElement(); 
       
        xmlW.writeEndDocument();
        String xmlStringxmlRes = xmlW.getXmlString();
        System.debug('The XML :'+xmlW.getXmlString());     
        xmlW.close();
        
        return xmlStringxmlRes;
        
	 	/*
          XmlStreamWriter w = new XmlStreamWriter();
          w.writeStartDocument('utf-8','1.0');
          w.writeStartElement('Account',null, null);
        
          
          w.writeStartElement(null, null, 'name');
          w.writeCharacters('abc');
          w.writeEndElement();
          
          w.writeStartElement(null, null, 'First_Name');
          w.writeCharacters('abc');
          w.writeEndElement();
          
          w.writeStartElement(null, null, 'Last_Name');
          w.writeCharacters('pqr');
          w.writeEndElement();
          
          w.writeStartElement(null, 'Email', null);
          w.writeCharacters('pqr@gmail.com');
          w.writeEndElement();
         
          w.writeEndElement();
    	  w.writeEndDocument();
		  String xmlStringxmlRes = w.getXmlString();
          System.debug('The XML :'+w.getXmlString());     
	      w.close();
        return xmlStringxmlRes;
        
        */
	 }   
}