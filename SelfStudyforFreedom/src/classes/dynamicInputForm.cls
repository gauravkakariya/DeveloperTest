public with sharing class dynamicInputForm
{
    public dynamicInputForm(Apexpages.standardController ctlr)
    {
        //constructor code
    }
  
    //Create a page block dynamically
    public Component.Apex.PageBlock getActionForm()
    {
        Component.Apex.PageBlock pb = new Component.Apex.PageBlock();
        system.debug('Hi 1');
        //creating an input field dynamically
        Component.Apex.InputField name = new Component.Apex.InputField();
        name.expressions.value = '{!Account.Name}';
        name.id = 'name';
        Component.Apex.OutputLabel label = new Component.Apex.OutputLabel();
        label.value = 'Name';
        label.for = 'name';
        //Use the above block to create other input fields
      
        Component.Apex.CommandButton save = new Component.Apex.CommandButton();
        save.value = 'Save';
        save.expressions.action = '{!Save}';


        pb.childComponents.add(label);
        pb.childComponents.add(name);
        pb.childComponents.add(save);
        return pb;
    }

  
    //Create Section Header dynamically
    public Component.Apex.SectionHeader getSectionHeader()
    {
    	system.debug('Hi 2');
        Component.Apex.SectionHeader sh = new Component.Apex.SectionHeader();
        sh.title = 'Create Account';
        return sh;
    }
}