function init() {
   if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
	}
	else if(method=="INSERT"){
		prssoldiersArmyDataset.newRecord();
	}
	else if (method=="UPDATE"){
		prssoldiersArmyDataset.setParameter("SOLDIERS_ID",idField);
		prssoldiersArmyDataset.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
	}
	L5.QuickTips.init(); 
}

function save(){

	var prssoldiersArmyDataset=L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	var records = prssoldiersArmyDataset.getCurrent()
	var valid = prssoldiersArmyDataset.isValidate();
		
	if(valid !== true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.prs.prssoldiersarmy.cmd.PrsSoldiersArmyCommand"); 
	command.setParameter("records",records);
	if(method=="INSERT"){
	}else if(method =="UPDATE"){
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function back()
{	
 	history.go(-1);
}
function changeLevel(){
	var ifmental = document.getElementById("mentalGrade").value;
	var injuringGrade = document.getElementById("injuringGrade");
	if(ifmental =="1" ){
		injuringGrade.options.length = 0;
		var varItem = new Option("请选择... ","");      
        injuringGrade.options.add(varItem); 
		var varItem = new Option("一级","1");      
        injuringGrade.options.add(varItem); 
       	var varItem = new Option("二级","2");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("三级","3");   
        injuringGrade.options.add(varItem);  
        var varItem = new Option("四级","4");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("五级","5");      
        injuringGrade.options.add(varItem);  
       	var varItem = new Option("六级","6");      
        injuringGrade.options.add(varItem);      
	}else if(ifmental =="0"){
		injuringGrade.options.length = 0;
		var varItem = new Option("请选择... ","");      
        injuringGrade.options.add(varItem);
		var varItem = new Option("一级","1");      
        injuringGrade.options.add(varItem); 
       	var varItem = new Option("二级","2");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("三级","3");   
        injuringGrade.options.add(varItem);  
        var varItem = new Option("四级","4"); 
        injuringGrade.options.add(varItem);      
	}
}
function ifReceiveChanges(){
	var ifReceive = document.getElementById("ifReceive").value;
	if(ifReceive=="0"){
		 document.getElementById("receiveTimeL").style.display="none";
		 document.getElementById("receiveTime").style.display="none";
		 document.getElementById("noReceiveReasonL").style.display="";
		 document.getElementById("noReceiveReason").style.display="";
	}else{
		document.getElementById("receiveTimeL").style.display="";
		 document.getElementById("receiveTime").style.display="";
		 document.getElementById("noReceiveReasonL").style.display="none";
		 document.getElementById("noReceiveReason").style.display="none";
	}
}