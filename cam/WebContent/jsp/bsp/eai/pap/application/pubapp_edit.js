var page;
if(!page) page = {};
page.hasCode ;
function init() {
	if (method==null||method==""){
		L5.MessageBox.alert(RES_PROMPT,RES_UNKOWN_CMD);
		return;
	}
	var ds = L5.DatasetMgr.lookup("appDataset");
	tpDataset.on('load',function(){
		if (method=="INSERT"){
			ds.newRecord();
		} else if (method=="UPDATE"){
			document.getElementById('hiddenTR').style.display = 'none';
			document.getElementById("appCodeFld").setAttribute("disabled", "disabled");
			ds.baseParams["appCode"]=idField;
			ds.load();
		} else
		{
			L5.MessageBox.alert(RES_PROMPT,RES_UNKOWN_CMD);
			return;
		}
	});
	tpDataset.load();

	L5.QuickTips.init();
	page.hasCode = false;
}

function save(){
	var ds = L5.DatasetMgr.lookup("appDataset");
	if(appDataset.getAllChangedRecords().length< 1){
		L5.MessageBox.alert(RES_PROMPT,MSG_NO_NEED_SAVE);
		return;
	}
	var rcd = ds.getCurrent();
	if(page.hasCode===true){
		L5.MessageBox.alert(RES_PROMPT,'应用编码已经被使用');
		return;
	}
	var valid_name_reg = /[#&\?<>\\{}()*\-+\/]/;
	var reg_result = valid_name_reg.exec(rcd.get('appName'));
	if(reg_result !== null){
		L5.MessageBox.alert(RES_PROMPT,'应用名称包含非法字符:'+reg_result[0]);
		return;
	}
	rcd.set('uri',page.combineUrl(rcd));
	var valid = ds.isValidate();
	if(valid !== true){
		L5.MessageBox.alert(RES_PROMPT,valid);
		return false;
	}
	
	var port=rcd.get("port");
	if(port.length>6){
		L5.MessageBox.alert(RES_PROMPT,'端口号不得超过4位');
		return;
	}
    var valid_seq_reg=/"^\\d+$/;
    var seq_result = valid_seq_reg.exec(rcd.get('seq'));
    if(seq_result!==null){
    	L5.MessageBox.alert(RES_PROMPT,'序号只能为整数');
		return;
    }
	
	var command=new L5.Command("org.loushang.bsp.eai.pap.application.cmd.AppCommand");
	command.setParameter("record",rcd);

	if(rcd.state=== 1){
		if(document.getElementById('checkbox0').checked){
			command.setParameter('isWithMenu','y');
		}
	}else if(rcd.state === 3){
		if(rcd.get('menuId')){
			command.setParameter('isWithMenu','y');
		}
	}
	command.execute(page.execmd[method]);
	if (command.error) {
		L5.MessageBox.alert(RES_PROMPT,command.error);
		return;

	}
	var reAppCode =command.getReturn("appCode");

	//维护应用信息后，刷新相应树节点(树形记录和iframe的dataset不同步)
	var parentWin = window.parent.window;
	var tree = parentWin.L5.getCmp("functiontree");
	if(method=="INSERT"){
		var parentRcd = parentWin.page.currentRcd;
		var node = tree.getNodeByRecord(parentRcd);
		parentRcd.reload({callback:function(){node.expand()}});
		appDataset.getCurrent().set("appCode",reAppCode);
	}else if (method=="UPDATE"){
		//修改节点只需要更改树中显示名称，其余不需要同步
		var node = tree.getNodeByRecordId(appDataset.getCurrent().get("appCode"), "appRecord");
		node.record.set("appName", ds.getCurrent().get("appName"));
		node.record.commit();
	}
	appDataset.commitChanges();
	if(method=='INSERT'){
		method = 'UPDATE';
	}
	L5.MessageBox.alert(RES_PROMPT,RES_SAVE);
}

function testCode(){
	var usingCode = document.getElementById('appCodeFld').value;

	var trimed_code = usingCode.replace(/\s/g,"");
	if(trimed_code.length < 1){
		return;
	}
	var cmd = new L5.Command('org.loushang.bsp.eai.pap.application.cmd.AppCommand');

//	if(page.trim(usingCode).length < 1){//编码为空不检查
//		return;
//	}
	cmd.setParameter('appCode',usingCode);
	cmd.execute('testCode');
	var hasCode = cmd.getReturn('hasCode');
	if(hasCode != 'n'){
		page.hasCode = true;
		document.getElementById('appHint').innerHTML = '*应用编码:'+usingCode+'已被使用';
		return;
	}else{
		page.hasCode = false;
		document.getElementById('appHint').innerHTML = "*"
	}

}


/**
 * 事件处理：撤销事件。
 */
function undo(){
	L5.DatasetMgr.lookup("appDataset").rejectChanges();
}
var page;
if(!page)page={};
page.execmd={
	INSERT:'insert',
	UPDATE:'update'
}
page.combineUrl=function(rcd){
	var url='';
	var t = rcd.get('transport');
	url+= t;
 	 t = rcd.get('serverHost');
	url+='://'+t;
	 t = rcd.get('port');
	url +=":"+t;
	 t= rcd.get('context') ;
	 url += "/"+t;
	 return url;
}