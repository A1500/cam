var flag = '0';
function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["ID@="]=idField;
		ds.load();
		fillBackSorgName();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var record = ds.getCurrent();
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	var command=new L5.Command("com.inspur.cams.sorg.penalty.correct.cmd.SomPenaltyCorrectCommand"); 
	command.setParameter("record",record);
	if (method=="INSERT"){
		command.execute("insert");	
	}
	if (method=="UPDATE"){
		command.execute("update");	
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			back();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/sorg/penalty/correct/sompenaltycorrect_list.jsp';
		var text = 'SOM_PENALTY_CORRECT';
		L5.forward(url,text);	 
 }

function fillBackSorgName(){
	somOrganDataSet.baseParams["SORG_TYPE@="]=_$("sorgType");
	somOrganDataSet.baseParams["SORG_CODE@="]=_$("sorgCode");
	somOrganDataSet.baseParams["SORG_STATUS@="]='22';
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){
			if(ds.getCount() == 0){
				$("sorgName").innerHTML = "";
				return;
			}else{
				$("sorgName").innerHTML = ds.get("cnName");
			}
		});
}

function printSave(){
	var record = ds.getCurrent();
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	var command=new L5.Command("com.inspur.cams.sorg.penalty.correct.cmd.SomPenaltyCorrectCommand"); 
	command.setParameter("record",record);
	var id;
	if (method=="INSERT"&&flag=='0'){
		command.execute("insert");	
		id = command.getReturn("id");
		flag=1;
	}
	//保存过一次的执行update
	if (method=="INSERT"&&flag!='0'){
		command.execute("update");	
		id = record.get("id");
	}
	if (method=="UPDATE"){
		command.execute("update");	
		id = record.get("id");
	}
	if (!command.error) {
		var sorgName =$("sorgName").innerHTML;
		sorgName = encodeURIComponent(encodeURIComponent(sorgName));
		var printurl=url+"/jsp/cams/sorg/comm/print/penaltyCorrectForPrint.jsp?id="+id+"&sorgName="+sorgName;
		window.open(printurl);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
}