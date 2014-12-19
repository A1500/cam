//初始化
function init() {
	var grid=L5.getCmp('editGridPanel');
	var ds=L5.DatasetMgr.lookup("jzfamxDataset");
	ds.load();
	//ds.on("load", afterExe);
	L5.DatasetMgr.lookup("jzfaInsertDataset").newRecord();
	
};

function afterExe(){
	var ds = L5.DatasetMgr.lookup("jzfamxDataset");
	//alert(ds.getTotalCount());
	//alert(ds.sum("jzzjxjJe"));
	var ds2 = L5.DatasetMgr.lookup("sjtjDataset");
	ds2.set("PEOPLESUM",ds.getTotalCount());
	ds2.set("MONEYSUM",ds.sum("captial"));
	ds2.set("GOODSSUM",ds.sum("goodsNums"));
	ds2.set("TOTALSUM",ds.sum("totalFund"));
}
//根据组件的id得到组件相应的value值。
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/**
 * 事件处理：点击查询按钮
 */
function query(){
	//jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ASSISTED_NAME@like",getParam("assistedName"));		
	//jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ASSITANCE_DATE@>=",getParam("planBegin"));	
	//jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ASSITANCE_DATE@<=",getParam("planEnd"));
	//jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ASSISTED_TYPE@=",getParam("assistedType"));	
	//jzfamxDataset.setParameter("SAM_PLAN_DETAIL.REG_TIME@>=",getParam("lrrqQ"));	
	//jzfamxDataset.setParameter("SAM_PLAN_DETAIL.REG_TIME@<=",getParam("lrrqZ"));
	//jzfamxDataset.load();
	
	var jzfamxDataset = L5.DatasetMgr.lookup("jzfamxDataset");
	var sjtjDataset = L5.DatasetMgr.lookup("sjtjDataset");
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ASSISTED_NAME@like",getParam("assistedName"));	
	sjtjDataset.setParameter("ASSISTED_NAME",getParam("assistedName"));	
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ASSITANCE_DATE@>=",getParam("planBegin"));	
	sjtjDataset.setParameter("PLAN_BEGIN",getParam("planBegin"));	
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ASSITANCE_DATE@<=",getParam("planEnd"));
	sjtjDataset.setParameter("PLAN_END",getParam("planEnd"));
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ASSISTED_TYPE@=",getParam("assistedType"));	
	sjtjDataset.setParameter("ASSISTED_TYPE",getParam("assistedType"));
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.REG_TIME@>=",getParam("lrrqQ"));	
	sjtjDataset.setParameter("REG_TIMES",getParam("lrrqQ"));	
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.REG_TIME@<=",getParam("lrrqZ"));
	sjtjDataset.setParameter("REG_TIMET",getParam("lrrqZ"));
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.ID_CARD@like",getParam("sfzhquery"));	
	sjtjDataset.setParameter("ID_CARD",getParam("sfzhquery"));
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.DISABILITY_TYPE@=",getParam("disabilityType"));	
	sjtjDataset.setParameter("DISABILITY_TYPE",getParam("disabilityType"));
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.DISABILITY_LEVEL@=",getParam("disabilityLevel"));	
	sjtjDataset.setParameter("DISABILITY_LEVEL",getParam("disabilityLevel"));
	jzfamxDataset.setParameter("SAM_PLAN_DETAIL.HANDICAP_NUM@=",getParam("cjzhquery"));	
	sjtjDataset.setParameter("HANDICAP_NUM",getParam("cjzhquery"));
	
	jzfamxDataset.load();
	sjtjDataset.load();
}

/**
 * 事件处理：点击返回按钮
 */
function retuenPage(){
	var url='jsp/ext/esurey/jzfa/jzfassQuery.jsp';
	var text = '救助方案明细';
	L5.forward(url,text);
}
	
/**
 * 事件处理：窗口确定按钮
 */
function jzfamxInsert(){
	var ds=L5.DatasetMgr.lookup('jzfaInsertDataset');
    var target=ds.getCurrent();
    var value=document.getElementById("totalFund").value;
    target.set("jzzjhjJe",value);
	var szdxmc=record.get("assistedName");
	var szdxlxdm=record.get("assistedType");
	var sfzh=record.get("idCard");
	var jzrq=record.get("assitanceDate");
	var jzzjxjJe=record.get("captial");
	var jzwpmc=record.get("goodsName");
	var jzwpsl=record.get("goodsNum");
	var jzwpzjJe=record.get("goodsNums");
	var jzfx=record.get("assistedSide");
	if(szdxmc==""){
		L5.MessageBox.alert('提示',"受助对象名称为空！");
	}
	if(szdxlxdm==""){
		L5.MessageBox.alert('提示',"受助对象类型为空！");
	}
	if(sfzh==""){
		L5.MessageBox.alert('提示',"身份证号为空！");
	}
	if(jzrq==""){
		L5.MessageBox.alert('提示',"受助日期为空！");
	}
	if(jzzjxjJe==""){
		L5.MessageBox.alert('提示',"救助资金现金金额为空！");
	}
	if(jzwpmc==""){
		L5.MessageBox.alert('提示',"救助物品名称为空！");
	}
	if(jzwpsl==""){
		L5.MessageBox.alert('提示',"救助物品数量为空！");
	}
	if(jzwpzjJe==""){
		L5.MessageBox.alert('提示',"救助物品折价金额为空！");
	}
	
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
	command.setParameter("jzfamx",ds.getCurrent().toBean("com.inspur.sdmz.jzfa.data.Detail"));
	command.setParameter("jzfaid", planId);
	command.execute("addJzfamx");
	if (!command.error) {
		var win=L5.getCmp("jzfamxWin");
		win.hide(this);
		L5.MessageBox.alert('提示',"录入成功！");
		L5.DatasetMgr.lookup("jzfamxDataset").load();
		L5.DatasetMgr.lookup("sjtjDataset").load();
		
	}else{
		L5.MessageBox.alert('警告',command.error);
	}
}
/**
 * 事件处理：窗口取消按钮
 */
function hide(){
var win=L5.getCmp('jzfamxWin');
win.hide();
}
function hideUpdate(){
var win=L5.getCmp('jzfamxUpdateWin');
win.hide();
}
/**
 * 事件处理：点击增加按钮
 */
function forInsert(){
	var ds = L5.DatasetMgr.lookup("jzfaInsertDataset");
	ds.newRecord();
	
	var win=L5.getCmp("jzfamxWin");
	
	win.show(this);
	
}
 
 /**
 * 事件处理：点击修改按钮
 */
 function forUpdate(){
 var jzfaGrid=L5.getCmp('editGridPanel');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.MessageBox.alert('提示','请选择要修改的一条记录');
		return false;
	}
	var ds = L5.DatasetMgr.lookup("jzfaUpdateDataset");
	ds.setParameter("DETAIL_ID@=",selected[0].get("detailId"));
	ds.load();
	
	var win=L5.getCmp("jzfamxUpdateWin");
	win.show(this);
 }
 /**
 * 事件处理：点击修改按钮
 */
 function jzfamxUpdate(){
	var ds=L5.DatasetMgr.lookup('jzfaUpdateDataset');
    var target=ds.getCurrent();
     var value=document.getElementById("totalFund").value;
    target.set("jzzjhjJe",value);
	var szdxmc=record.get("assistedName");
	var szdxlxdm=record.get("assistedType");
	var sfzh=record.get("IdCard");
	var jzrq=record.get("assitanceDate");
	var jzzjxjJe=record.get("captial");
	var jzwpmc=record.get("goodsName");
	var jzwpsl=record.get("goodsNum");
	var jzwpzjJe=record.get("goodsNums");
	if(szdxmc==""){
		L5.MessageBox.alert('提示',"受助对象名称为空！");
	}
	if(szdxlxdm==""){
		L5.MessageBox.alert('提示',"受助对象类型为空！");
	}
	if(sfzh==""){
		L5.MessageBox.alert('提示',"身份证号为空！");
	}
	if(jzrq==""){
		L5.MessageBox.alert('提示',"受助日期为空！");
	}
	if(jzzjxjJe==""){
		L5.MessageBox.alert('提示',"救助资金现金金额为空！");
	}
	if(jzwpmc==""){
		L5.MessageBox.alert('提示',"救助物品名称为空！");
	}
	if(jzwpsl==""){
		L5.MessageBox.alert('提示',"救助物品数量为空！");
	}
	if(jzwpzjJe==""){
		L5.MessageBox.alert('提示',"救助物品折价金额为空！");
	}
	
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
	command.setParameter("jzfamx",ds.getCurrent().toBean("com.inspur.sdmz.jzfa.data.Detail"));
	command.execute("updateJzfamx");
	if (!command.error) {
		var win=L5.getCmp("jzfamxUpdateWin");
		win.hide(this);
		L5.MessageBox.alert('提示',"修改成功！");
		L5.DatasetMgr.lookup("jzfamxDataset").load();
		L5.DatasetMgr.lookup("sjtjDataset").load();
		
	}else{
		L5.MessageBox.alert('警告',command.error);
	}
}
 //计算钱数的合计 包裹现金金额 和 物品折价金额的总和
function countMoney(){
	var value1=document.getElementById("captial").value;
	var value2=document.getElementById("goodsNums").value;
	var reg=new RegExp("^[0-9]{0,}$");
	if(!reg.test(value1)){
	L5.MessageBox.alert('提示','请输入正确的数字格式！');
	document.getElementById("captial").value="";
	return;
	}
	if(!reg.test(value2)){
	L5.MessageBox.alert('提示','请输入正确的数字格式！');
	document.getElementById("goodsNums").value="";
	return;
	}
	var num1=decimalRound(parseFloat(value1),2);
	var num2=decimalRound(parseFloat(value2),2);
	if(value1!=""){
		if(value2==""){
		document.getElementById("totalFund").value=num1;
		}else{
		document.getElementById("totalFund").value=num1+num2;
		}
	}else{
		if(value2!=""){
		document.getElementById("totalFund").value=num2;
		}else{
		document.getElementById("totalFund").value="";
		}
	}
}
// 小数截取
function decimalRound(num,decimalNum){
    var decimal2 = 1;
	while(decimalNum > 0){
		decimal2 = 10 * decimal2;
		decimalNum = decimalNum - 1;
	}
	return Math.round(num*decimal2)/decimal2;
}
//救助物品数量的校验
function judge(){
	var value1=document.getElementById("goodsNum").value;
	var reg=new RegExp("^[0-9]{0,}$");
	if(!reg.test(value1)){
	L5.MessageBox.alert('提示','请输入正确的数字格式！');
	document.getElementById("goodsNum").value="";
	return;
	}
}

//导入导出救助方案明细Excel相关Added by fujw,2011-05-11.
//救助方案明细导出Excel 
function exportJzfamxExcel() {
	var jzfaid = document.all.planId.value;
	L5.dataset2excel(jzfamxDataset, "/jsp/ext/esurey/jzfa/exportJzfamxExcel.jsp?planId="+jzfaid);
}

//转向导入救助方案明细页面
function forImportJzfamxExcel() {
	var jzfaid = document.all.jzfaid.value;
	var returnJsp="jzfassmxQuery.jsp";
	var url = "/jsp/ext/esurey/jzfa/forImportJzfamxExcel.jsp?planId="+jzfaid+"&returnJsp="+returnJsp;
	var text = "导入救助方案明细";
	L5.forward(url, text);
}

function importJzfamxTemplate() {
	L5.dataset2excel(jzfamxDataset, "/jsp/ext/esurey/jzfa/importJzfamxTemplate.jsp");
}
//通用帮助按钮
function forItemHelp(ele){
	var multi=L5.getCmp("jtxx_help");
	multi.show();
	multi.afterExecute=function(){
		setItemValue(multi.getReturn());
	}
}
//数据的回填方法
function setItemValue(record){
	var itemDataSet=L5.DatasetMgr.lookup('jzfaInsertDataset');
    var target=itemDataSet.getCurrent();
    target.set("assistedName",record.get('familyName'));
    target.set("IdCard",record.get('familyCardNo'));
    target.set("assistedId",record.get('familyId'))
}