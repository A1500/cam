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
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
    var ds = L5.DatasetMgr.lookup("ds");
	var record = ds.getCurrent();
	/*//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	**/
	var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisYearCostSheetCommand"); 
	command.setParameter("record",record);
	if(method=="INSERT"){
		command.execute("insert");	
	}else{
		command.execute("update");	
	}
	
	var disYear = record.get("disYear");
		if(disYear==""||disYear==null){
			L5.Msg.alert('提醒','年度不能为空！');
			return false;
		}
	
			if(disYear.length!=4){
				L5.Msg.alert('提醒','年度格式不正确！');
				return false;
			} 
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
   
}
 function back()
 {	 	var url='jsp/cams/dis/capital/costSheet/costsheet_list.jsp';
		var text = 'DIS_YEAR_COST_SHEET';
		L5.forward(url,text);	 
 }

function test1(){
	var donationForSelf = document.getElementById("donationForSelf").value;
	var reg=/^(\d*\.)?\d+$/;	
	if(!reg.test(donationForSelf)){
		L5.Msg.alert('提示','本级募集救灾捐赠资金必须是数字！');
		return false;
	}
}
function test2(){
	var yearCostSheet = document.getElementById("yearCostSheet").value;
	var reg=/^(\d*\.)?\d+$/;	
	if(!reg.test(yearCostSheet)){
		L5.Msg.alert('提示','本级救灾资金年度预算必须是数字！');
		return false;
	}
}
function test3(){
	var assistanceForSelf = document.getElementById("assistanceForSelf").value;
	var reg=/^(\d*\.)?\d+$/;	
	if(!reg.test(assistanceForSelf)){
		L5.Msg.alert('提示','本级配套灾害救助资金必须是数字！');
		return false;
	}
}
