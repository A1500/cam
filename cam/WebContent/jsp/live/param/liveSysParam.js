function getParam(obj){
	return document.getElementById(obj).value;
}

//增加系统参数
function sysWndShow(){
	var wnd = L5.getCmp("paramWnd");
	wnd.show();
}
function addParam(){
	if(!checkValidate())
		return;
	var newRecord = sysParamDs.newRecord();
	newRecord.set("parmCode" , getParam("parmCode"));
	newRecord.set("parmName" , getParam("parmName"));
	newRecord.set("parmValue" , getParam("parmValue"));
	//默认为停用
	newRecord.set("stat" , "0");
	newRecord.set("parmLevel" , 'S');
	//重置数据
	resetParamForm();
	var wnd = L5.getCmp("paramWnd");
	wnd.hide();
}
function resetParamForm(){
	document.getElementById("parmCode").value = "";
	document.getElementById("parmName").value = "";
	document.getElementById("parmValue").value = "";
}
 
//保存系统参数
function saveSysParam(){
	var isValidate = sysParamDs.isValidate();
	if(isValidate != true){
		L5.Msg.alert("校验未通过，不能保存" , isValidate);
		return;
	}
	var records = sysParamDs.getAllChangedRecords();
	if(records.length){
		var command = new L5.Command("org.loushang.live.param.cmd.LiveParmsCommand");
		command.setParameter("records", records);
		command.execute("modifyParams");
		if(!command.error){
			L5.Msg.alert("提示" , "保存成功");
			sysParamDs.commitChanges();
			sysParamDs.load();
		}else{
			L5.Msg.alert("错误" , command.error);
		}
	}
}
//删除系统参数
function delSysParam(){
	var grid  = L5.getCmp("sysParamGrid");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var cell = sm.getSelections();
	if(cell.length){
		L5.MessageBox.confirm("提示","确认删除?",
		function(sta){
			if(sta == 'yes'){
				var records = [];
				for(var i=0; i<cell.length; i++){
					sysParamDs.remove(cell[i]);
					//设置为删除状态
					cell[i].state = 2;;
					records.push(cell[i]);
				}
				var command = new L5.Command("org.loushang.live.param.cmd.LiveParmsCommand");
				command.setParameter("records", records);
				command.execute("modifyParams");
				if(command.error){
					L5.Msg.alert("错误" , command.error);
				}
			}
		});
	}else{
		L5.Msg.alert("提示" , "请选择一条记录");
	}
}
//验证函数
function checkValidate(){
	var paramCode = getParam("parmCode");
	var paramName =  getParam("parmName");
	var paramValue = getParam("parmValue");
	var status = false;
	if(paramCode == ""){
		L5.Msg.alert("提示" , "参数代码不能为空!");
		return false;
	}else{
		status = L5.Validator["lengthUTF8"](paramCode , null , 32);
		if(status != true){
			L5.Msg.alert("提示" , "参数代码"+status);
			return false;
		}
		//中文全角字符
		var regx = /[^\x00-\xff]/;
		if(paramCode.match(regx) || paramCode.match(/[#'=]/)){
			L5.Msg.alert("提示" , "参数代码包含非法字符")
			return false;
		}		
	}
	if(paramName == ""){
		L5.Msg.alert("提示" , "参数描述不能为空!");
		return false;
	}else{
		status = L5.Validator["lengthUTF8"](paramName , null , 50);
		if(status != true){
			L5.Msg.alert("提示" , "参数描述"+status);
			return false;
		}	
	}
	if(paramValue==""){
		L5.Msg.alert("提示" , "参数值不能为空!");
		return false;
	}else{
		status = L5.Validator["lengthUTF8"](paramValue , null , 512);
		if(status != true){
			L5.Msg.alert("提示" , "参数值"+status);
			return false;
		}	
	}
	return true;
}
//查询系统参数
function querySysParam(){
	var parmCode = getParam("sysParmCode");
	var parmName = getParam("sysParmName");
	if(!checkQueryParm())
		return;
	sysParamDs.setParameter("parmCode" , parmCode);
	sysParamDs.setParameter("parmName" , parmName);
	sysParamDs.load();
}
//撤消操作
function undoSysParam(){
	sysParamDs.rejectChanges();
}
//过滤查询条件
function checkQueryParm(){
	var parmCode = getParam("sysParmCode");
	var parmName = getParam("sysParmName");
	//移除'
	if(parmCode.match(/'/) ||  parmName.match(/'/)){
		return false;
	}
	return true;
}