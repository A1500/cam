var page;
if(!page)page = {};
page.execmd={
	INSERT:'addOperation',
	UPDATE:'updateOperation'
};
page.book={
	promptWord:'提示：'
};
page.has_code;
function init() {
	operationTypeDst.load();
	if (method==null||method==""){
		L5.Msg.alert(RES_PROMPT,RES_UNKOWN_CMD);
		return;
	}
	var operationDataset = L5.DatasetMgr.lookup("operationDataset");
	if (method=="INSERT"){
		operationDataset.newRecord({"functionCode":functionCode,"functionName":functionName,"seq":"1"});
		page.menuId = window.parent.page.currentRcd.parentRecord.get('menuId');
		page.oldIsDefault='0';//新增加一个操作，
	} else if (method=="UPDATE"){
		page.menuId = window.parent.page.selectedRcd.parentRecord.get('menuId');
		document.getElementById("operationCodeFld").setAttribute("disabled", "disabled");
		operationDataset.baseParams["OPERATION_CODE@="]=idField;
		var urlDataset = L5.DatasetMgr.lookup("urlDataset");
		urlDataset.on('load',function() {
			if(page.menuId){//获取操作的第一个url
				page.oldIsDefault = operationDataset.getAt(0).get('isDefault');
				page.oldUrl = "";
				page.oldUrl = page.getOldUrl();
			}
		});
		//修改页面时加载完主表数据后再加载从表数据
		operationDataset.on("load", function(){
			urlDataset.load();
			page.oldSeq = operationDataset.getAt(0).get('seq') ;
		});
		operationDataset.load();
		urlDataset.baseParams["OPERATION_CODE@="]=idField;
		urlDataset.baseParams["sort"]='SEQ';
		urlDataset.baseParams["dir"] = 'asc';
		//url中存储的是操作内码和功能内码，页面需要显示名称，直接从已经加载的操作记录中获取，不再向后台发送请求
		urlDataset.on("load", function(){
			var operationName = operationDataset.getCurrent().get("operationName");
			var functionName = operationDataset.getCurrent().get("functionName");
			for(var i = 0; i < urlDataset.getCount(); i++){
				urlDataset.getAt(i).set("operationName", operationName);
				urlDataset.getAt(i).set("functionName", functionName);
			}
			urlDataset.commitChanges();
		});
	}else{
		L5.Msg.alert(RES_PROMPT,RES_UNKOWN_CMD);
	}
	L5.QuickTips.init();
	page.has_code = false;
}
function testCode(){
	var usingCode = document.getElementById('operationCodeFld').value;

	var trimed_code = usingCode.replace(/\s/g,"");
	if(trimed_code.length < 1){
		return;
	}
	var cmd = new L5.Command('org.loushang.bsp.eai.pap.function.cmd.OperationCommand');

	cmd.setParameter('operationCode',usingCode);
	cmd.execute('testCode');
	var hasCode = cmd.getReturn('hasCode');
	if(hasCode != 'n'){
		document.getElementById('operationHint').innerHTML = '*操作编号:'+usingCode+'已被使用';
		page.has_code = true;
		return;
	}else{
		document.getElementById('operationHint').innerHTML = "*";
		page.has_code = false;
	}
	//根据操作的code修改url的operationcode
	var url_ds = urlDataset;
	var leng = url_ds.getCount();
	if(leng < 1) {//没有url 就不用改了
		return ;
	}
	var urls = url_ds.getRange(0,leng-1);
	for(var i=0; i<leng; i++)	{
		urls[i].set('operationCode',usingCode);
	}
}
function brushDefaultUrl(cell,col,record) {
	if(record.get('seq')===0&&cell!="") {
		return '<span style="font-weight:bold">'+cell+'</span>';
	}
	return cell;
}
//设置一条url为默认url
function setDefault(){
	var rcd = urlDataset.getCurrent();
	var url = rcd.get('urlContent')
	if(! /.jsp$/.test(url)) {
		L5.MessageBox.alert(RES_PROMPT,RES_JSP_ONLY);
		return;
	}
	if(!rcd) {
		return;
	}
	if(rcd.get('seq')==="0"){
		return;
	}
	page.clearDefault(rcd);
	rcd.set('seq',"0");
}
//去掉其他的"默认操作"
page.clearDefault=function(newDefaultUrl){
	var leng = urlDataset.getCount();
	var oldDefaultUrl ;
	for(var i=0; i<leng; i++){
		var rcd = urlDataset.getAt(i);
		if(rcd.get('urlCode') != newDefaultUrl.get('urlCode') ){
			if(rcd.get('seq') === 0){
				oldDefaultUrl = rcd;
				break;
			}
		}
	}
	if(oldDefaultUrl){
		oldDefaultUrl.set('seq',newDefaultUrl.get('seq'));
	}
}
function save() {

	var operationRecords = operationDataset.getAllChangedRecords();
	var urlRecords = urlDataset.getAllChangedRecords();
	var urlRcds=urlDataset.getAllRecords();
	if(operationRecords.length<1 && urlRecords.length<1){
		L5.MessageBox.alert(RES_PROMPT,MSG_NO_NEED_SAVE);
		return false;
	}
	var valid = operationDataset.isValidate();
	if(valid !== true){
		L5.MessageBox.alert(RES_PROMPT,valid);
		return false;
	}
	valid  = urlDataset.isValidate();
	if(valid !== true){
		L5.MessageBox.alert(RES_PROMPT,valid);
		return false;
	}
	if(page.has_code===true){
		L5.MessageBox.alert(RES_PROMPT,'操作编号已经被使用');
		return;
	}
	var valid_name_reg = /[#&\?<>\\{}()*\-+\/]/;
	var oprRcd = operationDataset.getCurrent();//获取当前唯一的操作
	var reg_result = valid_name_reg.exec(oprRcd.get('operationCode'));
	if(reg_result !== null){
		L5.MessageBox.alert(RES_PROMPT,'操作编码包含非法字符:'+reg_result[0]);
		return;
	}
	reg_result = valid_name_reg.exec(oprRcd.get('operationName'))
	if(reg_result !== null){
		L5.MessageBox.alert(RES_PROMPT,'操作名称包含非法字符:'+reg_result[0]);
		return;
	}

	page.checkboxFallBack();
	var isDefault = oprRcd.get('isDefault');
	if(isDefault != '1'){//isDefault 非1则0
		oprRcd.set('isDefault','0');
	}
	var command=new L5.Command("org.loushang.bsp.eai.pap.function.cmd.OperationCommand");
	//if(oprRcd.state == '3' ||oprRcd.state == '1') {
	//	command.setParameter("operation",oprRcd);
	//}
	command.setParameter("operation",oprRcd);
	command.setParameter("urls", urlRecords);
	command.setParameter("oprurls",urlRcds);

	//对功能已同步菜单的处理
	if(page.menuId){
		var yynn = page.yynnMaster.findYynn();
		var reqAction = page.yynnMaster.findDefaultUrl();
		page.yynnMaster[yynn](command,reqAction);
		command.setParameter('dftState',yynn);
	}

	command.execute(page.execmd[method]);
	if (command.error) {
		L5.Msg.alert(RES_PROMPT,command.error);
		return;

	}
	//维护操作信息后，刷新相应树节点(树形记录和iframe的dataset不同步)
	var parentWin = window.parent.window;
	var tree = parentWin.L5.getCmp("functiontree");
	if(method=="INSERT") {
		var parentRcd = parentWin.page.currentRcd;
		var node = tree.getNodeByRecord(parentRcd);
		parentRcd.reload({callback:function(){node.expand()}});
	}else if (method=="UPDATE"){

		//修改节点只需要更改树中显示名称，其余不需要同步
		var node = tree.getNodeByRecordId(operationDataset.getCurrent().get("operationCode"), "operationRecord");
		node.record.set("operationName", operationDataset.getCurrent().get("operationName"));
		node.record.commit();
	}
	operationDataset.commitChanges();
	urlDataset.commitChanges();
	L5.Msg.alert(RES_PROMPT,RES_SAVE);
	if(method==='INSERT') {
		method = 'UPDATE';
		document.getElementById('operationCodeFld').disabled = 'disabled';
	}
	page.oldUrl = page.getOldUrl();
	if(page.menuId){
		var yynnState = page.yynnMaster.findYynn();
		if( yynnState ==='yn')  {
			page.oldIsDefault="0";
		} else if( yynnState === 'ny') {
			page.oldIsDefault = "1";
		}
	}
}

/**
 * 事件处理：撤销事件。
 */
function undo(){
	L5.DatasetMgr.lookup("operationDataset").rejectChanges();
	L5.DatasetMgr.lookup("urlDataset").rejectChanges();
}
/**
 * 事件处理：添加url。
 */
function insertUrl(){
	var operationDataset = L5.DatasetMgr.lookup("operationDataset");
	var urlDataset = L5.DatasetMgr.lookup("urlDataset");
	var operationName = operationDataset.getCurrent().get("operationName");
	var functionName = operationDataset.getCurrent().get("functionName");
	var operationCode = operationDataset.getCurrent().get("operationCode");
	var functionCode = operationDataset.getCurrent().get("functionCode");
	var urlsLeng = urlDataset.getCount();
	urlDataset.newRecord({
		"operationCode":operationCode,
		"operationName":operationName,
		"functionCode":functionCode,
		"functionName":functionName,
		"seq":urlsLeng,
		"accessType":"http"});
	//var win=L5.getCmp('urlEdit');
	//win.show(L5.getCmp('urlGridPanel').el.dom);
}

/**
 * 事件处理：修改url。
 */
function updateUrl(){
	var grid=L5.getCmp('urlGridPanel');
//	grid.getSelectionModel().selectLastRow();
	var win=L5.getCmp('urlEdit');
	win.show(grid.el.dom);
}
/**
 * 上移url
 */
function upUrl(){
	var crcd = urlDataset.getCurrent();
	if(!crcd) return;
	var index = urlDataset.indexOf(crcd);
	if(index == 0) return;

	var upRcd = urlDataset.getAt(index-1);
	crcd.set('seq',index-1);
	upRcd.set('seq',index);

	var data = urlDataset.data;
	var tmp = upRcd;

	data.items[index-1] = crcd;
	data.items[index] = tmp;

	data.map[data.keys[index-1]] = crcd;
	data.map[data.keys[index]] = tmp;
	urlDataset.moveTo2(index-1);
}
/**
 * 下移url
 */
function downUrl(){
	var crcd = urlDataset.getCurrent();
	var leng = urlDataset.getCount();
	if(!crcd) return;
	var index = urlDataset.indexOf(crcd);
	if (index >=(leng - 1)) {
		return;
	}
	var downRcd = urlDataset.getAt(index+1);
	crcd.set('seq',index+1);
	downRcd.set('seq',index);

	var data = urlDataset.data;
	var tmp = downRcd;
	data.items[index+1] = crcd;
	data.items[index] = tmp;

	data.map[data.keys[index+1]] = crcd;
	data.map[data.keys[index]] = tmp;
	urlDataset.moveTo2(index+1);
}
/**
 * 事件处理：删除url。
 */
function delUrl(){
	var urlDataset = L5.DatasetMgr.lookup("urlDataset");
	var record = urlDataset.getCurrent();
	if(urlDataset.getCurrent()!=null)
	urlDataset.remove(record);
}
page.oldSeq;
//yyNN:操作的“默认操作”从是到否(yn)  从否到是(ny)
// 从否到否(nn) 从是到是(yy)
page.yynnMaster={
yn:function(cmd,reqAction){// not in insert
		cmd.setParameter('needUpdateAction','y');
		cmd.setParameter('reqAction',"");
},
ny:function(cmd,reqAction){//
	cmd.setParameter('needUpdateAction','y');
	cmd.setParameter('reqAction',reqAction);
},
yy:function(cmd,reqAction){//not in insert
	if(page.oldUrl != reqAction){
		cmd.setParameter('needUpdateAction','y');
		cmd.setParameter('reqAction',reqAction);
	}
},
nn:function(cmd,reqAction){
},
//获取默认的url
findDefaultUrl:function(){
	var leng  =urlDataset.getCount();
	var reqAction="";
	for(var i=0; i<leng; i++){
			var r = urlDataset.getAt(i);
			if(parseInt(r.get('seq'))==0 ){
				reqAction = r.get('urlContent');
			}
	}
	return reqAction;
},
//获取当前操作的“默认操作”的
findYynn:function() {
	var oprRcd = operationDataset.getCurrent();
	var yynn;
	var isDefaultNow = oprRcd.get('isDefault');
		if(page.oldIsDefault != isDefaultNow ){
			if(isDefaultNow ==='1'){
				yynn = 'ny';
			}else {
				yynn = 'yn';
			}
		}else if(page.oldIsDefault === isDefaultNow &&
					page.oldIsDefault === "1"){
			yynn= 'yy';
		}else{
			yynn = 'nn';
		}
		return yynn;
}
}
//不同浏览器对checkbox赋值和前台js框架配合不是很好~~!，为了确保checkbox的值被
//正确地放到record里面，要做这个检查
////make sure that checkbox's value put into record field
page.checkboxFallBack=function(){
		var checked = document.getElementById('isDefaultOpr').checked;
		var oprRcd = operationDataset.getCurrent();
		var isDefaultNow = oprRcd.get('isDefault');
		if(checked){
			if(isDefaultNow != '1'){//选中了checkbox，但是record.isDefaut不是‘1’
				oprRcd.set('isDefault','1');
				return;
			}
		}else{
			if(isDefaultNow =='1'){//没有选中checkbox，但是record.isDefault是‘1’
				oprRcd.set('isDefault','0');
				return;
			}
		}
}
page.getOldUrl = function() {
	var leng  =urlDataset.getCount();
	for(var i=0; i<leng; i++){
		var r = urlDataset.getAt(i);
		if(parseInt(r.get('seq'))==0 ){
			return r.get('urlContent');
		}
	}
}