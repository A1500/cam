
/**
*事件处理：初始化。
*/
function init() {
	var grid=L5.getCmp('editGridPanel');
	var ds=L5.DatasetMgr.lookup("jzfamxDataset");
	ds.setParameter("sort","ASSISTED_NAME");	
	ds.setParameter("dir","asc");
	ds.load();
	
	//ds.on("load", afterExe);
	L5.DatasetMgr.lookup("jzfaInsertDataset").newRecord();
	
	
	//var jtcyDataset=L5.DatasetMgr.lookup("jtcyDataset");
	//jtcyDataset.load();
	var sjtjDataset=L5.DatasetMgr.lookup("sjtjDataset");
	sjtjDataset.load();
	
}

function afterExe(){
	var ds = L5.DatasetMgr.lookup("jzfamxDataset");
	var ds2 = L5.DatasetMgr.lookup("sjtjDataset");
	ds2.set("PEOPLESUM",ds.getTotalCount());
	ds2.set("MONEYSUM",ds.sum("captial"));
	ds2.set("GOODSSUM",ds.sum("goodsNums"));
	ds2.set("TOTALSUM",ds.sum("totalFund"));
}
//根据组件的Id得到组件的value值
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
	
	jzfamxDataset.load();
	sjtjDataset.load();
}
/**
*事件处理：点击增加按钮
*/
function forInsert(){
	var ds = L5.DatasetMgr.lookup("jzfaInsertDataset");
	ds.newRecord();
	
	var win=L5.getCmp("jzfamxWin");
	
	win.show(this);
}
/**
 * 事件处理：点击删除按钮
 */
function forRemove(){
	var jzfamxGrid=L5.getCmp('editGridPanel');
	var selected=jzfamxGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert('删除','请选择要删除的记录');
		return false;
	}
	L5.MessageBox.confirm('警告', '确定要删除选中的记录吗？',
		function(sta){
			if(sta=="yes"){
				var jzfamxids=[];
				for(var i=0;i<selected.length;i++){
					jzfamxids[i]=selected[i].get("detailId");
				}
				var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
				command.setParameter("jzfamxids", jzfamxids);
				command.setParameter("jzfaid", planId);
				command.execute("deleteJzfamx");
				if (!command.error) {
					for(var i=0;i<selected.length;i++){
						jzfamxDataset.remove(selected[i]);
					}
					L5.DatasetMgr.lookup('sjtjDataset').load();
				}else{
					L5.MessageBox.alert('警告',command.error);
				}
			} else return ;
		});
}
/**
 * 事件处理：点击返回按钮
 */
function retuenPage(){
	var url='jsp/sdmz/jzfa/jzfaQuery.jsp';
	var text = '救助方案明细';
	L5.forward(url,text);
}
/**
 * 事件处理：点击返回按钮
 */
function rePage(){
	var url='jsp/sdmz/jzfa/jzfafxQuery.jsp';
	var text = '救助方案分析';
	L5.forward(url,text);
}
	
/**
 * 事件处理：窗口确定按钮
 */
function jzfamxInsert(){
	var ds=L5.DatasetMgr.lookup('jzfaInsertDataset');
	var record = ds.getCurrent();

	var assistedName=record.get("assistedName");
	var assistedType=record.get("assistedType");
	var idCard=record.get("idCard");
	var assitanceDate=record.get("assitanceDate");
	var captial=record.get("captial");
	var goodsName=record.get("goodsName");
	var goodsNum=record.get("goodsNum");
	var goodsNums=record.get("goodsNums");
	var assistedSide=record.get("assistedSide");
	
	if(assistedSide==""){
		L5.MessageBox.alert('提示',"救助方向为空！");
		return;
	}
	if(assitanceDate<jzrqQ){
	L5.Msg.alert('提示',"救助方案过期！");
		return;
	}
	if(assitanceDate>jzrqZ){
	L5.Msg.alert('提示',"救助方案过期！");
		return;
	}
	
	if(assistedName==""){
		L5.Msg.alert('提示',"受助对象名称为空！");
		return;
	}
	if(assistedName.length>50)
	{
	L5.MessageBox.alert('提示',"受助对象名称过长！");
		return;
	}
	if(assistedType==""){
		L5.MessageBox.alert('提示',"受助对象类型为空！");
		return;
	}
	
	if(assitanceDate==""){
		L5.MessageBox.alert('提示',"受助日期为空！");
		return;
	}
	
	if(captial==""){
		if(captial=="0"){
		record.set("captial",0);
		}
		else{
		L5.MessageBox.alert('提示',"救助资金现金金额为空！");
		return;
		}
	}
	if(goodsName==""){
		L5.MessageBox.alert('提示',"救助物品名称为空！");
		return;
	}
	if(goodsNum==""){
		if(goodsNum=="0"){
			record.set("goodsNum",0);
		}
		else{
		L5.MessageBox.alert('提示',"救助物品数量为空！");
		return;
		}
	}
	if(goodsNums==""){
		if(goodsNums=="0"){
			record.set("goodsNums",0.00);
		}
		else{
		L5.MessageBox.alert('提示',"救助物品折价金额为空！");
		return;
		}
	}
	if(captial=="0" && goodsNums=="0"){
		L5.MessageBox.alert('提示',"救助物品合计金额不能为零");
		document.getElementById("jzzjxjJeInsert").value="";
		document.getElementById("jzwpzjJeInsert").value="";
		return;
	}
	
if(assistedType!="2"){
	if(idCard==""){
		L5.MessageBox.alert('提示',"身份证号为空！");
		return;
	}
	
	var jzzjhjJe=document.getElementById("jzzjhjJeInsert").value;
	record.set("totalFund",jzzjhjJe);
	/*******************************************************************/
	//初期数据未审核不能实施救助，特此先去除审核校验。后期正式录入在设置校验 licb  20110616
	/***
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.JzfaCmd"); 
	var sfzh=document.getElementById("sfzh").value;
	var bean = record.toBean("com.inspur.sdmz.jzfa.data.Jzfamx");
	command.setParameter("jzfamx",bean);
	command.setParameter("jzfaid", jzfaid);
	command.setParameter("sfzh", sfzh);
	command.execute("addJzfamx");
	var szdxId=command.getReturn("szdxId");
	if(szdxId==""){
	document.getElementById("sfzh").value="";
	L5.MessageBox.alert('提示',"此人未进行困难户登记或登记未审核！")
	return;
	}**/
    var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
	var idCard=document.getElementById("idCard").value;
	var bean = record.toBean("com.inspur.sdmz.jzfa.data.Detail");
	command.setParameter("jzfamx",bean);
	command.setParameter("jzfaid", planId);
	command.setParameter("sfzh", idCard);
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
   /***********************************************************************/
 
}else{
	
	var jzzjhjJe=document.getElementById("jzzjhjJeInsert").value;
	record.set("totalFund",jzzjhjJe);
	
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
	var sfzh=document.getElementById("idCard").value;
	var bean = record.toBean("com.inspur.sdmz.jzfa.data.Detail");
	command.setParameter("jzfamx",bean);
	command.setParameter("jzfaid", planId);
	command.setParameter("szdxlxdm",assistedType);
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
    
    var value1=document.getElementById("jzzjhjJeUpdate").value;
    target.set("totalFund",value1);

	var assistedName=target.get("assistedName");
	var assistedType=target.get("assistedType");
	var idCard=target.get("idCard");
	var assitanceDate=target.get("assitanceDate");
	var captial=target.get("captial");
	var goodsName=target.get("goodsName");
	var goodsNum=target.get("goodsNum");
	var goodsNums=target.get("goodsNums");
	var assistedSide=target.get("assistedSide");
	if(assistedSide==""){
		L5.MessageBox.alert('提示',"救助方向为空！");
		return;
	}
	if(assitanceDate<jzrqQ){
	L5.Msg.alert('提示',"救助方案过期！");
		return;
	}
	if(assitanceDate>jzrqZ){
	L5.Msg.alert('提示',"救助方案过期！");
		return;
	}
	
	if(assistedName==""){
		L5.MessageBox.alert('提示',"受助对象名称为空！");
		return;
	}
	if(assistedName.length>50)
	{
	L5.MessageBox.alert('提示',"受助对象名称过长！");
		return;
	}
	if(assistedType==""){
		L5.MessageBox.alert('提示',"受助对象类型为空！");
		return;
	}
	
	if(assitanceDate==""){
		L5.MessageBox.alert('提示',"受助日期为空！");
		return;
	}
	if(captial==""){
		if(captial=="0"){
		target.set("captial",0);
		}
		else{
		L5.MessageBox.alert('提示',"救助资金现金金额为空！");
		return;
		}
	}
	if(goodsName==""){
		L5.MessageBox.alert('提示',"救助物品名称为空！");
		return;
	}
	if(goodsNum==""){
		if(goodsNum=="0"){
		  document.getElementById("jzwpslUpdate").value=0;
		}
		else{
		L5.MessageBox.alert('提示',"救助物品数量为空！");
		return;
		}
	}
	if(goodsNums==""){
		if(goodsNums=="0"){
			document.getElementById("jzwpzjJeUpdate").value=0;
		}
		else{
		L5.MessageBox.alert('提示',"救助物品折价金额为空！");
		return;
		}
	}
	if(captial=="0" && goodsNums=="0"){
		L5.MessageBox.alert('提示',"救助物品合计金额不能为零");
		document.getElementById("jzzjxjJeInsert").value="";
		document.getElementById("jzwpzjJeInsert").value="";
		return;
	}
	
if(assistedType!="2"){
	if(idCard==""){
		L5.MessageBox.alert('提示',"身份证号为空！");
		return;
	}
	
	
	var jzwpzjJeUpdate=document.getElementById("jzwpzjJeUpdate").value;
	var jzzjxjJeUpdate=document.getElementById("jzzjxjJeUpdate").value;
	var jzzjhjJe=decimalRound(parseFloat(jzzjxjJeUpdate),2)+decimalRound(parseFloat(jzwpzjJeUpdate),2);
	target.set("totalFund",jzzjhjJe);
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
	
	command.setParameter("jzfamx",ds.getCurrent().toBean("com.inspur.sdmz.jzfa.data.Detail"));
	command.setParameter("jzfaid", planId);
	command.setParameter("sfzh", idCard);
	command.execute("updateJzfamx");
	//初期数据未审核不能实施救助，特此先去除审核校验。后期正式录入在设置校验 zhangdd  20110801
	/***var szdxId=command.getReturn("szdxId");
	if(szdxId==""){
	document.getElementById("idCard2").value="";
	L5.MessageBox.alert('提示',"此人未进行困难户登记或登记未审核！")
	
	return;
	}**/
	if (!command.error) {
		var win=L5.getCmp("jzfamxUpdateWin");
		win.hide(this);
		L5.MessageBox.alert('提示',"修改成功！");
		L5.DatasetMgr.lookup("jzfamxDataset").load();
		L5.DatasetMgr.lookup("sjtjDataset").load();
		
	}else{
		L5.MessageBox.alert('警告',command.error);
	}
	
}else
	{
	var jzwpzjJeUpdate=document.getElementById("jzwpzjJeUpdate").value;
	var jzzjxjJeUpdate=document.getElementById("jzzjxjJeUpdate").value;
	var jzzjhjJe=decimalRound(parseFloat(jzzjxjJeUpdate),2)+decimalRound(parseFloat(jzwpzjJeUpdate),2);
	//alert(jzzjhjJe);
	target.set("totalFund",jzzjhjJe);
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
	
	command.setParameter("jzfamx",ds.getCurrent().toBean("com.inspur.sdmz.jzfa.data.Detail"));
	command.setParameter("jzfaid", planId);
	command.setParameter("sfzh", idCard);
	command.setParameter("szdxlxdm",assistedType);
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
}
 //计算救助资金合计总额（包括救助资金和物品折价）
function countMoney(jzzjxjJe,jzwpzjJe,etc){
	var value1=document.getElementById(jzzjxjJe).value;
	var value2=document.getElementById(jzwpzjJe).value;
	//var reg=new RegExp("^[0-9]{0,}$");
	//if(!reg.test(value1)){
	//L5.MessageBox.alert('提示','请输入正确的数字格式！');
	//document.getElementById("jzzjxjJe").value="";
	//return;
	//}
	//if(!reg.test(value2)){
	//L5.MessageBox.alert('提示','请输入正确的数字格式！');
	//document.getElementById("jzwpzjJe").value="";
	//return;
	//}
	/*if(value1=="0"&&value2=="0"){
	L5.MessageBox.alert('提示','救助资金合计金额不能等于零');
	document.getElementById("jzzjxjJe").value="";
	document.getElementById("jzwpzjJe").value="";
	return;
	}*/
	var num1=decimalRound(parseFloat(value1),2);
	var num2=decimalRound(parseFloat(value2),2);
	if(value1!=""){
		if(value2==""){
		document.getElementById(etc).value=num1;
		}else{
		document.getElementById(etc).value=num1+num2;
		}
	}else{
		if(value2!=""){
		document.getElementById(etc).value=num2;
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

//输入救助物品数量的校验
function judge1(){
	var value1=document.getElementById("jzwpslInsert").value;
	var reg=new RegExp("^[0-9]{0,}$");
	if(!reg.test(value1)){
	L5.MessageBox.alert('提示','请输入正确的数字格式！');
	document.getElementById("jzwpslInsert").value="";
	return;
	}
}
//输入救助物品数量的校验
function judge(){
	var value1=document.getElementById("jzwpslUpdate").value;
	var reg=new RegExp("^[0-9]{0,}$");
	if(!reg.test(value1)){
	L5.MessageBox.alert('提示','请输入正确的数字格式！');
	document.getElementById("jzwpslUpdate").value="";
	return;
	}
}
//资金金额的校验
function judgeJe(Je){
	//var re = /(0|[1-9]\d*)(\.\d+)?$/;
	var re=/^(([1-9]+[0-9]*.{1}[0-9]+)|([0].{1}[1-9]+[0-9]*)|([1-9][0-9]*)|([0][.][0-9]+[1-9]*))$/;
	var value1=document.getElementById(Je).value;
	if(!re.test(value1)){
	L5.MessageBox.alert('提示','请输入正确的金额格式！');
	document.getElementById(Je).value="";
	return;
	}
  
}
function doZfloat(id)
{
var obj=document.getElementById(id);
var re = /(0|[1-9]\d*)(\.\d+)?$/;　//正浮点数验证  /^-?[1-9]*(\.\d*)?$|^-?d^(\.\d*)?$/
     if (!re.test(obj.value))
    {
        if(isNaN(obj.value))
        {      
        obj.value="";                
        return false;
        }
    }
	
}


//导入导出救助方案明细Excel相关Added by fujw,2011-05-11.
//救助方案明细导出Excel 
function exportJzfamxExcel() {
	var planId = document.all.planId.value;
	L5.dataset2excel(jzfamxDataset, "/jsp/sdmz/jzfa/exportJzfamxExcel.jsp?planId="+planId);
}

//转向导入救助方案明细页面
function forImportJzfamxExcel() {
	var jzfaid = document.all.planId.value;
	var returnJsp="jzfamxQuery.jsp"
	var url = "/jsp/sdmz/jzfa/forImportJzfamxExcel.jsp?planId="+jzfaid+"&returnJsp="+returnJsp;
	var text = "导入救助方案明细";
	L5.forward(url, text);
}

function importJzfamxTemplate() {
	L5.dataset2excel(jzfamxDataset, "/jsp/sdmz/jzfa/importJzfamxTemplate.jsp");
}

function forItemHelp(ele){
	
	var multi=L5.getCmp("jtcy_help");
	multi.show();
	multi.afterExecute=function(){
		setItemValue(multi.getReturn());
	}
}

function setItemValue(record){
	var itemDataSet=L5.DatasetMgr.lookup('jzfaInsertDataset');
    var target=itemDataSet.getCurrent();
    target.set("assistedName",record.get('NAME'));
    target.set("idCard",record.get('FAMILY_CARD_NO'));
    target.set("assistedId",record.get('FAMILY_ID'))
    var value1=document.getElementById("jzzjxjJeInsert").value;
	var value2=document.getElementById("jzwpzjJeInsert").value;
	
	var num1=decimalRound(parseFloat(value1),2);
	var num2=decimalRound(parseFloat(value2),2);
	if(value1!=""){
		if(value2==""){
		document.getElementById("jzzjhjJeInsert").value=num1;
		}else{
		document.getElementById("jzzjhjJeInsert").value=num1+num2;
		}
	}else{
		
		if(value2!=""){
		document.getElementById("jzzjhjJeInsert").value=num2;
		}
	}
     //countMoney(jzzjxjJe,jzwpzjJe,etc);
}

/**
 * 事件处理：救助物品名称填写无时联动处理

function checkJzwpmc(){
	var jzwpmcInsert=document.getElementById("jzwpmcInsert").value;
	if(jzwpmcInsert=="无"){
	document.getElementById("jzwpslInsert").disabled=disabled;
	document.getElementById("jzwpzjJeInsert").disabled=disabled;
	}
}
 */
 
 function emptySfzh(){
 
 
	var szdxlxdm=document.getElementById("assistedType1").value;
	
 	
 if(szdxlxdm=="2"){
	document.getElementById("idCard").disabled="disabled";
	document.getElementById("idCard").value="";
	
	}else{
	
	document.getElementById("idCard").disabled="";
	}
 }
 function emptySfzh1(){
 
	var szdxlxdm=document.getElementById("assistedType2").value;
	
	if(szdxlxdm=="2"){
	document.getElementById("idCard2").disabled="disabled";
	document.getElementById("idCard2").value="";
	}else{
	document.getElementById("idCard2").disabled="";
	}
 }
 
 /**
 * 事件处理：判断并查询受助人是否被救助
 */
 function ifAssisted(value,cellmeta,record,rowindex,colindex,dataset){
 	var idCardInfo = record.get("idCard");
 	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd");
 	command.setParameter("idCard",idCardInfo);
 	command.execute("ifAssisted");
	var num = command.getReturn("num");
	if(num == 1){
		return '<a>'+'否'+'</a>';
	}else if(num > 1){
 		return '<a href="javascript:ifAssistedURL(\'' + dataset.indexOf(record) + '\')">' + '点击查看' + '</a>';
 	}else{
 		return '<a>'+''+'</a>';
 	}
 }
 function ifAssistedURL(index){
 	var detailIdInfo = jzfamxDataset.getAt(index).get("detailId");
 	var idCardInfo = jzfamxDataset.getAt(index).get("idCard");
 	jzfamxDatasetWin.setParameter("detailId",detailIdInfo);
 	jzfamxDatasetWin.setParameter("idCard",idCardInfo);
 	jzfamxDatasetWin.load();
 	var win = L5.getCmp("otherAssistedWin");
 	win.show();
 }