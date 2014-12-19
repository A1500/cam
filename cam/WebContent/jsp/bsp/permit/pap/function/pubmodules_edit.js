var page;
if(!page) page = {};
page.execmd={
	INSERT:'insert',
	UPDATE:'update'
};
page.hasCode ;
//测试code是否重复
page.trim = function(str){
	return str.replace(/\s/g,"");
};
function testCode(){
	var usingCode = document.getElementById('moduleCodeFld').value;
	
	var trimed_code = usingCode.replace(/\s/g,"");
	if(trimed_code.length < 1){
		return;
	}
	var cmd = new L5.Command('org.loushang.bsp.permit.pap.function.cmd.ModuleCommand');
	
	if(page.trim(usingCode).length < 1){//编码为空不检查
		return;
	}
	cmd.setParameter('moduleCode',usingCode);
	cmd.execute('testCode');
	var hasCode = cmd.getReturn('hasCode');
	if(hasCode != 'n'){
		page.hasCode = true;
		document.getElementById('moduleHint').innerHTML = '*模块编码:'+usingCode+'已被使用';
		return;
	}else{
		page.hasCode = false;
		document.getElementById('moduleHint').innerHTML = "*"
	}
	
}

function init() {
	if (method==null||method==""){
		L5.Msg.alert(RES_PROMPT,RES_UNKOWN_CMD);
		return;
	}
	if(appCode=='null'){
		appCode='-1';
	}
	var ds = L5.DatasetMgr.lookup("moduleDataset");
	if (method=="INSERT"){
		var command=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.ModuleCommand");
		command.setParameter("appCode",appCode);
		if(!parentModuleCode || parentModuleCode == "null"){
			command.setParameter("parentId","-1");
			command.execute("getSubordinateCount");
			var seq =command.getReturn("seq");
			ds.newRecord({
				"moduleAppCode":appCode,
				"appName":appName,
				"parentModuleCode":"-1",
				"parentModuleName":"-1",
				"seq":seq});
		} else {
			command.setParameter("parentId",parentModuleCode);
			command.execute("getSubordinateCount");
			var seq =command.getReturn("seq");
			ds.newRecord({
				"moduleAppCode":appCode,
				"appName":appName,
				"parentModuleCode":parentModuleCode,
				"parentModuleName":parentModuleName,
				"seq":seq});
		}
		//如果上级没有同步菜单这里不需要选
		if(withMenu == 'n'){
			document.getElementById('hiddenTR').style.display = 'none';
			document.getElementById('checkbox0').checked = false;
		}

	} else if (method=="UPDATE"){
		
		document.getElementById('hiddenTR').style.display = 'none';
		document.getElementById("moduleCodeFld").setAttribute("disabled", "disabled");
		document.getElementById("isLeafFld").setAttribute("disabled", "disabled");
		ds.baseParams["moduleCode"]=idField;
		ds.on('load',function(){
			ds.getAt(0).set('appName',appName);
			ds.commitChanges();
			var parentModuleName = ds.getAt(0).get('parentModuleName');
			if(parentModuleName== '-1'){
				parentModuleName = ds.getAt(0).get('moduleName');
			}
			document.getElementById('parentModuleId').value= parentModuleName;
		});
		ds.load();
	} else {
		L5.Msg.alert(RES_PROMPT,RES_UNKOWN_CMD);
		return;
	}
	L5.QuickTips.init();
	page.hasCode = false;
}
function save(){
	var ds = L5.DatasetMgr.lookup("moduleDataset");
	var l = ds.getAllChangedRecords();
	if(!l || l.length < 1){
		L5.Msg.alert(RES_PROMPT,MSG_NO_NEED_SAVE);
		return;
	}
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert(RES_PROMPT,valid);
		return false;
	}
	if(page.hasCode===true){
		L5.MessageBox.alert(RES_PROMPT,'模块编码已经被使用');
		return;
	}
	
	var valid_name_reg = /[#&\?<>\\{}()*\-+\/]/;
	var rcd = ds.getCurrent();
	var reg_result = valid_name_reg.exec(rcd.get('moduleCode'));
	if(reg_result !== null){
		L5.MessageBox.alert(RES_PROMPT,'模块编码包含非法字符:'+reg_result[0]);
		return;
	}
	reg_result = valid_name_reg.exec(rcd.get('moduleName'))
	if(reg_result !== null){
		L5.MessageBox.alert(RES_PROMPT,'模块名称包含非法字符:'+reg_result[0]);
		return;
	}
	var command=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.ModuleCommand");
	
	command.setParameter("record",rcd);
	var isLeaf = rcd.get('isLeafModule');
		
	if(isLeaf != '1'){
		rcd.set('isLeafModule','0');
	}
	if(rcd.state== '1'){//增加
		if(document.getElementById('checkbox0').checked){
			command.setParameter('isWithMenu','y');
		}
		if(pmenuId !== null){
			rcd.set('menuId',pmenuId);
		}	
	}else if(rcd.state == '3'){//修改
		if(rcd.get('menuId')){
			command.setParameter('isWithMenu','y');
		}
	}
	command.execute(page.execmd[method]);
	if (command.error) {
		L5.Msg.alert(RES_PROMPT,command.error);
		return;
	
	}
	
	//维护模块信息后，刷新相应树节点(树形记录和iframe的dataset不同步)
	var parentWin = window.parent.window;
	var tree = parentWin.L5.getCmp("functiontree");
	if(method=="INSERT"){
		var parentRcd = parentWin.page.currentRcd;
		var node = tree.getNodeByRecord(parentRcd);
		parentRcd.reload({callback:function(){node.expand()}});
	}else if (method=="UPDATE"){
		
		//修改节点只需要更改树中显示名称，其余不需要同步
		var node = tree.getNodeByRecordId(ds.getCurrent().get("moduleCode"), "moduleRecord");
		node.record.set("moduleName", ds.getCurrent().get("moduleName"));
		node.record.commit();
	}
	
	moduleDataset.commitChanges();
	if(method=="INSERT"){
		   method ="UPDATE";
		   document.getElementById('moduleCodeFld').disabled = 'disabled';
		   document.getElementById('isLeafFld').disabled = 'disabled';
	}
	L5.Msg.alert(RES_PROMPT,RES_SAVE);
}
function checkSeq(args){
	var val1 = document.getElementById("seq").value;
	if(isNaN(val1)){
		return "必须为整数值";
	}else{
		return true;
	}
}
/**
 * 事件处理：撤销事件。
 */
function undo(){
	L5.DatasetMgr.lookup("moduleDataset").rejectChanges();
}


