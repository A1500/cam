var page;
if(!page) page = {};
page.execmd={
	INSERT:'insert',
	UPDATE:'update'
};
page.has_code;
function init() {
	if (method==null||method==""){
		L5.MessageBox.alert(RES_PROMPT,RES_UNKOWN_CMD);
		return;
	}
	var ds = L5.DatasetMgr.lookup("functionDataset");
	ds.on('load',function(){
		page.oldSeq = ds.getAt(0).get('seq');
		ds.getAt(0).set('moduleName',
			window.parent.page.selectedRcd.parentRecord.get('moduleName'));
		ds.commitChanges();
		});
	if (method=="INSERT"){
		var command=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.FunctionCommand");
		command.setParameter("parentId",moduleCode);
		command.execute("getSubordinateCount");
		var seq =command.getReturn("seq");
		ds.newRecord({"moduleCode":moduleCode,"moduleName":moduleName,"seq":seq});
			//如果上级没有同步菜单这里不需要选
		if(withMenu == 'n'){
			document.getElementById('hiddenTR').style.display = 'none';
			document.getElementById('checkbox0').checked = false;
		}
	} else if (method=="UPDATE"){
		
		document.getElementById('hiddenTR').style.display = 'none';
		document.getElementById("functionCodeFld").setAttribute("disabled", "disabled");
		ds.baseParams["functionCode"]=idField;
		ds.load();
	} else{
		L5.MessageBox.alert(RES_PROMPT,RES_UNKOWN_CMD);
		return;
	}
	L5.QuickTips.init();
	page.has_code = false;
}
//测试code是否重复
function testCode(){
	var usingCode = document.getElementById('functionCodeFld').value;
	var trimed_code = usingCode.replace(/\s/g,"");
	if(trimed_code.length < 1){
		return;
	}
	var cmd = new L5.Command('org.loushang.bsp.permit.pap.function.cmd.FunctionCommand');
	cmd.setParameter('functionCode',usingCode);
	cmd.execute('testCode');
	var hasCode = cmd.getReturn('hasCode');
	if(hasCode != 'n'){
		page.has_code = true;
		document.getElementById('functionHint').innerHTML = '*功能编号:'+usingCode+'已被使用';
		return;
	}else{
		page.has_code = false;
		document.getElementById('functionHint').innerHTML = "*"
	}
	
}
function save(){
	var l = functionDataset.getAllChangedRecords();
	if(l.length < 1){
		L5.MessageBox.alert(RES_PROMPT,MSG_NO_NEED_SAVE);
		return;
	}
	var ds = L5.DatasetMgr.lookup("functionDataset");
	var valid = ds.isValidate();
	if(valid != true){
		L5.MessageBox.alert(RES_PROMPT,valid);
		return false;
	}
	if(page.has_code===true){
		L5.MessageBox.alert(RES_PROMPT,'模块编号已经被使用');
		return;
	}
	var valid_name_reg = /[#&\?<>\\{}()*\-+\/]/;
	var rcd = ds.getCurrent();
	var reg_result = valid_name_reg.exec(rcd.get('functionCode'))
	if(reg_result !== null){
		L5.MessageBox.alert(RES_PROMPT,'功能编码包含非法字符:'+reg_result[0]);
		return;
	}
	reg_result = valid_name_reg.exec(rcd.get('functionName'))
	if(reg_result !== null){
		L5.MessageBox.alert(RES_PROMPT,'功能名称包含非法字符:'+reg_result[0]);
		return;
	}
	var command=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.FunctionCommand");
	
	command.setParameter("record", ds.getCurrent());
	if(rcd.state== '1'){
		if(document.getElementById('checkbox0').checked){
			command.setParameter('isWithMenu','y');
		}
			
		if(pmenuId !== null){
			rcd.set('menuId',pmenuId);
		}	

	}else if(rcd.state == '3'){
		if(rcd.get('menuId'))
			command.setParameter('isWithMenu','y');
	}
	command.execute(page.execmd[method]);
	if (command.error) {
		L5.MessageBox.alert(RES_PROMPT,command.error);
		return;
		
	}
	//维护功能信息后，刷新相应树节点(树形记录和iframe的dataset不同步)
	var parentWin = window.parent.window;
	var tree = parentWin.L5.getCmp("functiontree");
	if(method=="INSERT"){
		var parentRcd = parentWin.page.currentRcd;
		var node = tree.getNodeByRecord(parentRcd);
		parentRcd.reload({callback:function(){node.expand()}});
	}else if (method=="UPDATE"){
		//修改节点只需要更改树中显示名称，其余不需要同步
		var node = tree.getNodeByRecordId(ds.getCurrent().get("functionCode"), "functionRecord");
		node.record.set("functionName", ds.getCurrent().get("functionName"));
		node.record.commit();
	}
	L5.MessageBox.alert(RES_PROMPT,RES_SAVE);
		functionDataset.commitChanges();
	if(method==='INSERT'){
			method = 'UPDATE';
			document.getElementById('functionCodeFld').disabled = 'disabled';
	}
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
	L5.DatasetMgr.lookup("functionDataset").rejectChanges();
}
