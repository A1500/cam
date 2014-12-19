<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>


<html>
	<head>
	<title>基金会年检信息汇总</title>
	<next:ScriptManager/>
<%
	String taskCode = StrUtil.n2b((String)request.getParameter("taskCode"));
	String year = StrUtil.n2b((String)request.getParameter("year"));
	String CheckStatus = StrUtil.n2b((String)request.getParameter("CheckStatus"));
	String sorgKind = StrUtil.n2b((String)request.getParameter("sorgKind"));
	String ifGridAll = StrUtil.n2b((String)request.getParameter("ifGridAll"));
%>
<style media="print">
	.noprint     { display: none }
</style>
<script language="javascript">
	var sorgKind1='<%=sorgKind%>';
	var taskCode='<%=taskCode%>';
	var year='<%=year%>';
	var CheckStatus='<%=CheckStatus%>';
	var ifGridAll='<%=ifGridAll%>';
	function init(){
		if(ifGridAll == ''){
			ds.setParameter("TASK_CODE",taskCode);
			ds.setParameter("CHECK_YEAR",year);
			ds.load();
		}else{
			ds.setParameter("SORG_KIND",sorgKind1);
			ds.setParameter("CHECK_YEAR",year);
			ds.setParameter("STATUS",CheckStatus);
			ds.setParameter("ifGridAll",ifGridAll);
			ds.setParameter("SORG_TYPE","J");
			ds.load();
		}
		ds.on('load',function(){
			setPerMoney();
			setPerMoneyq();
		});
	}
	function back(){
		var data=new L5.Map();
		data.put("searchYear",year);
		data.put("CheckStatus",CheckStatus);
		url="jsp/cams/sorg/jxcheck/fund/summary/somJXCheckSummaryList.jsp";
		L5.forward(url,'',data);
	}
function setParseFloat(id1,id2){
	var value1 = document.getElementById(id1).innerHTML;
	var value2 = document.getElementById(id2).innerHTML;
	if(!value1){
		value1 = 0;
	}else{
		value1 = parseFloat(value1);
	}
	if(!value2){
		value2 = 0;
	}else{
		value2 = parseFloat(value2);
	}
	return (value1+value2).toFixed(6)*1;
}
function setPerMoney(){
	var value1 = document.getElementById("公益支出").innerHTML;
	var value2 = document.getElementById("调整后的上年度总收入").innerHTML;
	var value3 = document.getElementById("工资支出").innerHTML;
	var value4 = document.getElementById("行政支出").innerHTML;
	var value5 = document.getElementById("本年度总支出").innerHTML;
	if(!value1 || !value2){
		document.getElementById("公益比例").innerHTML="%";
	}else{
		document.getElementById("公益比例").innerHTML=(parseFloat(value1)/parseFloat(value2)*100).toFixed(6)*1+"%";
		if(document.getElementById("公益比例").innerHTML=="Infinity%" || document.getElementById("公益比例").innerHTML=="NaN%"){
			document.getElementById("公益比例").innerHTML="%";
		}
	}
	if((!value3 && !value4) || !value5){
		document.getElementById("福利支出比例").innerHTML="%";
	}else{
		if(!value3){
			value3=0;
		}
		if(!value4){
			value4=0;
		}
		document.getElementById("福利支出比例").innerHTML=(((parseFloat(value3)+parseFloat(value4))/parseFloat(value5)*100).toFixed(6)*1) +'%';
		if(document.getElementById("福利支出比例").innerHTML=="Infinity%" || document.getElementById("福利支出比例").innerHTML=="NaN%"){
			document.getElementById("福利支出比例").innerHTML="%";
		}
	}
}

function setPerMoneyq(){
	var value1 = document.getElementById("公益支出q").innerHTML;
	var value2 = document.getElementById("上年度基金余额q").innerHTML;
	var value3 = document.getElementById("工资支出q").innerHTML;
	var value4 = document.getElementById("行政支出q").innerHTML;
	var value5 = document.getElementById("本年度总支出q").innerHTML;
	if(!value1 || !value2){
		document.getElementById("公益比例q").innerHTML="%";
	}else{
		document.getElementById("公益比例q").innerHTML=((parseFloat(value1)/parseFloat(value2)*100).toFixed(6)*1) +'%';
		if(document.getElementById("公益比例q").innerHTML=="Infinity%" || document.getElementById("公益比例q").innerHTML=="NaN%"){
			document.getElementById("公益比例q").innerHTML="%";
		}
	}
	if((!value3 && !value4) || !value5){
		document.getElementById("福利支出比例q").innerHTML="%";
	}else{
		if(!value3){
			value3=0;
		}
		if(!value4){
			value4=0;
		}
		document.getElementById("福利支出比例q").innerHTML=(((parseFloat(value3)+parseFloat(value4))/parseFloat(value5)*100).toFixed(6)*1) + '%';
		if(document.getElementById("福利支出比例q").innerHTML=="Infinity%" || document.getElementById("福利支出比例q").innerHTML=="NaN%"){
			document.getElementById("福利支出比例q").innerHTML="%";
		}
	}

}
/*
展示基本信息的具体数值
item:具体字段
value：当前字段的值
title:标题即列名
*/
var fileName="";
function showbaseWin(item,value,title){
	if( value == "0"){
		return;
	}
	baseInfoDs.removeAll();
	baseInfoDs.setParameter("SORG_TYPE","J");
	baseInfoDs.setParameter("ITEM",item);
	baseInfoDs.setParameter("TASK_CODE",taskCode);
	baseInfoDs.setParameter("CHECK_YEAR",year);
	baseInfoDs.load();
	L5.getCmp("baseShowList").setVisible(true);
	L5.getCmp("baseShowList").setTitle(title);
	var colModel = L5.getCmp("baseShowListGrid").getColumnModel();
	fileName=title;
}
var isparty=false;
function showWin(value,field,tableName,columnName){
	isparty=false;
	if( value == "0"){
		return;
	}
	detailDs.removeAll();
	if(field.slice(field.length-2,field.length) == '_A'){
		field=field.slice(0,field.length-2);
		detailDs.setParameter("ifBuildParty","0");
	}
	if(field.indexOf('CURRENT_TOTAL') != -1 || field.indexOf('IN_TOTAL')!=-1 || field.indexOf('OFF_TOTAL')!=-1){
		if(field.slice(field.length-1,field.length) == '1'){
			detailDs.setParameter("IF_OPEN","1");
			field = field.slice(0,field.length-1);
		}else if(field.slice(field.length-1,field.length) == '2'){
			detailDs.setParameter("IF_OPEN","2");
			field = field.slice(0,field.length-1);
		}else{
			detailDs.setParameter("IF_OPEN","0");
		}
	}else if(('1234567890').indexOf(field.slice(field.length-1,field.length))!=-1){
		if(field.indexOf('NO_BUILD_PARTY_RESON') != -1){
			detailDs.setParameter("ifBuildParty","0");
		}else if(field.indexOf('IF_PARTY_OFFICER') != -1){
			detailDs.setParameter("ifBuildParty","0");
		}
		detailDs.setParameter("sqlfield",field.slice(field.length-1,field.length));
		field = field.slice(0,field.length-1);
		isparty=true;
	}
	detailDs.setParameter("SORG_TYPE","J");
	detailDs.setParameter("FIELD",field);
	detailDs.setParameter("TABLE_NAME",tableName);
	detailDs.setParameter("TASK_CODE",taskCode);
	detailDs.setParameter("CHECK_YEAR",year);
	detailDs.load();
	/*
	detailDs.on('load',function (){
		detailDs.filterBy(function(record, id){
			if(record.get(field) != '0'){
				return record;
			}
		});
	});
	*/
	L5.getCmp("showList").setVisible(true);
	L5.getCmp("showList").setTitle(columnName);
	var colModel = L5.getCmp("showListGrid").getColumnModel();
	if(isparty){
		colModel.setHidden(3,true);
	}else{
		colModel.setColumnHeader(3,columnName);
		colModel.setDataIndex(3,field);
		colModel.setHidden(3,false);
	}
	fileName=columnName;
	L5.getCmp("showList").setPosition(L5.getCmp("showList").getPosition[0],getScrollTop()+30);
}
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("baseInfoDs");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
//	dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,"/jsp/cams/sorg/jxcheck/fund/summary/somJXCheckSummaryToExcelBaseInfo.jsp?title="+fileName);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function exportDetailExcel(){

	var dataset=L5.DatasetMgr.lookup("detailDs");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	if(isparty){
		L5.dataset2excel(dataset,"/jsp/cams/sorg/jxcheck/fund/summary/somJXCheckSummaryToExcelBaseInfo.jsp?title="+fileName);
	}else{
		L5.dataset2excel(dataset,"/jsp/cams/sorg/jxcheck/fund/summary/somJXCheckSummaryToExcelDetail.jsp?title="+fileName+"&field="+L5.getCmp("showListGrid").getColumnModel().getDataIndex(3));
	}
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function closeBaseWin(){
	L5.getCmp("baseShowList").hide();
}
function closeWin(){
	L5.getCmp("showList").hide();
}
//获取滚动条高度
function getScrollTop()
	{
	var scrollTop=0;
	if(document.documentElement&&document.documentElement.scrollTop)
	{
	scrollTop=document.documentElement.scrollTop;
	}
	else if(document.body)
	{
	scrollTop=document.body.scrollTop;
	}
	return scrollTop;
}
function printJ(){
	document.execCommand("Print",true,false);
}

</script>
<script language="javascript">
function exportWord(){
	ExcelSheet = new ActiveXObject('Word.Application');
    ExcelSheet.Application.Visible = true;
    var mydoc=ExcelSheet.Documents.Add('',0,0);
    myRange =mydoc.Range(0,1);
    myRange =mydoc.Range(myRange.End-1,myRange.End);//设定起始点
    var sel=document.body.createTextRange();
    var Layer1 = document.getElementById("Layer1");
    sel.moveToElementText(Layer1);
    sel.select();
    document.execCommand('Copy');
    sel.moveEnd('character');
    myRange.Paste();
    myRange =mydoc.Range(myRange.End-1,myRange.End);
    myRange.InsertAfter("\n");
    ExcelSheet.ActiveWindow.View.TableGridlines = false;
}
</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" method="queryFundCheckReport" global="true">
	</model:dataset>

	<model:dataset id="baseInfoDs" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" method="queryCheckBaseAnalyse" global="true">
	</model:dataset>

	<model:dataset id="detailDs" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" method="queryCheckAnalyse" global="true">
	</model:dataset>

	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_fund_kind'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel  border="0">
<next:Panel id="panel" cls="noprint" border="0">
	<next:TopBar>
			<next:ToolBarItem text='' id="displayItem"/>
			<next:ToolBarItem symbol="基金会年检信息汇总"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="打印" iconCls="print" handler="printJ"></next:ToolBarItem>
			<next:ToolBarItem text="导出WORD" iconCls="print" handler="exportWord"></next:ToolBarItem>
			<next:ToolBarItem text="返回" iconCls="return" handler="back"></next:ToolBarItem>
	</next:TopBar>
</next:Panel>
	<next:Html>
		<div  id="Layer1" align=center>
		<form method="post" onsubmit="return false" class="L5form" dataset="ds" >
<p class=MsoNormal align="center"><span style='font-size: 15.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	基金会年检信息汇总</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<table width="650">
	<tr>
		<td class="FieldInput" width="80%">基金会年检信息基金会已经上报的总数为</td>
		<td class="FieldInput" width="20%"><label name="基金会年检信息基金会已经上报的总数"
			field="TOTAL" onclick="showbaseWin('1',this.innerHTML,this.name)" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">基金会年检信息基金会已经上报的审批完成数为</td>
		<td class="FieldInput" width="20%"><label name="基金会年检信息基金会已经上报的审批完成数"
			field="CHECK_PASS" onclick="showbaseWin('2',this.innerHTML,this.name)" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">基金会年检信息基金会已经上报的未审批完成数为</td>
		<td class="FieldInput" width="20%"><label name='基金会年检信息基金会已经上报的未审批完成数'
			field="CHECK_NO_PASS" onclick="showbaseWin('3',this.innerHTML,this.name)" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">基金会年检信息中年检合格的基金会个数为</td>
		<td class="FieldInput" width="20%"><label name='基金会年检信息中年检合格的基金会个数'
			field="CHECK_OK" onclick="showbaseWin('4',this.innerHTML,this.name)" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">基金会年检信息中年检基本合格的基金会个数为</td>
		<td class="FieldInput" width="20%"><label name="基金会年检信息中年检基本合格的基金会个数"
			field="CHECK_BASAL_OK" onclick="showbaseWin('5',this.innerHTML,this.name)" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">基金会年检信息中年检不合格的基金会个数为</td>
		<td class="FieldInput" width="20%"><label name="基金会年检信息中年检不合格的基金会个数"
			field="CHECK_NOT_OK" onclick="showbaseWin('6',this.innerHTML,this.name)" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">基金会年检信息中一年未年检的基金会个数为</td>
		<td class="FieldInput" width="20%"><label name="基金会年检信息中一年未年检的基金会个数"
			field="ONE_YEAR" onclick="showbaseWin('7',this.innerHTML,this.name)" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">基金会年检信息中两年未年检的基金会个数为</td>
		<td class="FieldInput" width="20%"><label name="基金会年检信息中两年未年检的基金会个数"
			field="TWO_YEAR" onclick="showbaseWin('8',this.innerHTML,this.name)" style="cursor: hand; color: blue"></label></td>
	</tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（一）基本情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
		<table width="650">
			<tr>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>原始基金数额</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput" colspan="3"><label field="INITIAL_FUND" style="width: 93%" name='原始基金数额'  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue"/></td>
			</tr>
			<tr>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>理事数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="SYNDIC_NUM" style="width: 93%" name='理事数'  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue"/></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>监事数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="AUDITOR_NUM" style="width: 93%" name='监事数'  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue"/></td>
			</tr>
			<tr>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>负责人数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="PRINCIPAL_NUM" style="width: 93%" name='负责人数'  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue"/></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>负责人中现任国家工作人员的人数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="PRINCIPAL_GOV_NUM" style="width: 93%" name='负责人中现任国家工作人员的人数' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue" /></td>
			</tr>
			<tr>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>负责人中担任过省部级及以上领导职务的人数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="PRINCIPAL_PROVINCE_NUM" name='负责人中担任过省部级及以上领导职务的人数' style="width: 93%"  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue"/></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>分支机构数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="RAMUS_NUM" style="width: 93%" name='分支机构数' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue" /></td>
			</tr>
			<tr>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>代表机构数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="DELEGATE_NUM" style="width: 93%" name='代表机构数'  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue"/></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>专职工作人员数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="FULLTIME_NUM" style="width: 93%" name='专职工作人员数' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue" /></td>
			</tr>
			<tr>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>专项基金数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="SPECIAL_FUNDS" style="width: 93%" name='专项基金数' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue" /></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label>志愿者数</label></td>
				<TD  class="FieldInput" width="20%" class="FieldInput"><label field="POSTULAND_NUM" style="width: 93%" name='志愿者数'  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK',this.name)" style="cursor: hand; color: blue"/></td>
			</tr>
			<tr>
		<td class="FieldInput" width="25%">从业人员中担任党代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任党代表人数')"field="ABOVE_COUNTY_NUM"></label></td>
		<td class="FieldInput" width="25%">从业人员中担任省级及以下党代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任省级及以下党代表人数')"field="PARTY_NUM_PROVINCE"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任全国性党代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任全国性党代表人数')"field="PARTY_NUM_NATION"></label></td>

		<td class="FieldInput" width="25%">从业人员中担任人大代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任人大代表人数')"field="NPC_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任省级及以下人大代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任省级及以下人大代表人数')"field="NPC_NUM_PROVINCE"></label></td>

		<td class="FieldInput" width="25%">从业人员中担任全国性人大代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任全国性人大代表人数')"field="NPC_NUM_NATION"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任政协委员人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任政协委员人数')"field="CPPCC_NUM"></label></td>

		<td class="FieldInput" width="25%">从业人员中担任省级及以下政协委员人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任省级及以下政协委员人数')"field="CPPCC_NUM_PROVINCE"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任全国性政协委员人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任全国性政协委员人数')"field="CPPCC_NUM_NATION"></label></td>

		<td class="FieldInput" width="25%"></td>
		<td class="FieldInput" width="25%"></td>
	</tr>
		</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（二）党建情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<table width="650">
	<tr>
		<td  width="25%" align="center" colspan="4" style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
			已建党组织<label field="IF_BUILD_PARTY1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','已建党组织')"
			style="cursor: hand; color: blue"></label>
			个，专职党务工作者人数<label field="PARTY_WORKER_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','专职党务工作者人数')"
			 style="cursor: hand; color: blue"></label> 个。</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="6">党组织形式</td>
		<td class="FieldInput" width="25%">党委<label field="PARTY_TYPE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党委')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%" rowspan="6">党组织隶属关系</td>
		<td class="FieldInput" width="25%">业务主管单位党组织<label field="PARTY_RELATION_TYPE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','业务主管单位党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">党总支<label field="PARTY_TYPE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党总支')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">挂靠单位党组织<label field="PARTY_RELATION_TYPE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','挂靠单位党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">党支部<label field="PARTY_TYPE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党支部')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">属地党组织<label field="PARTY_RELATION_TYPE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','属地党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">临时支部<label field="PARTY_TYPE4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','临时支部')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">行业党组织<label field="PARTY_RELATION_TYPE4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','行业党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">联合支部<label field="PARTY_TYPE5"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','联合支部')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">其他党组织<label field="PARTY_RELATION_TYPE5"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其他形式<label field="PARTY_TYPE6"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他形式党组织隶属关系')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%"></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="6">党组织活动场所</td>
		<td class="FieldInput" width="25%">单独设立<label field="PARTY_SPACE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','单独设立')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%" rowspan="6">年度活动经费</td>
		<td class="FieldInput" width="25%">总额：<label field="PARTY_ACTIVITY_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','总额')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">办公场所合用<label field="PARTY_SPACE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','办公场所合用')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">党费：<label field="PARTY_DUES_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党费')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">与社区组织活动场所共用<label field="PARTY_SPACE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','与社区组织活动场所共用')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">上级党组织支持：<label field="PARTY_SUPPORT_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','上级党组织支持')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其他<label field="PARTY_SPACE4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他党组织活动场所')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">业务经费：<label field="PARTY_BUSINESS_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','业务经费')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">无场所<label field="PARTY_SPACE5"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','无场所')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">财政支持：<label field="PARTY_FINANCE_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','财政支持')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%"></td>
		<td class="FieldInput" width="25%">其他形式：<label field="PARTY_OTHER_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他形式活动经费')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="4">党组织负责人</td>
		<td class="FieldInput" width="25%" rowspan="2">担任社会组织主要负责人<label field="PARTY_PEOPLE_TYPE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','担任社会组织主要负责人')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">35岁以下<label field="PARTY_PEOPLE_AGE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','35岁以下')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">留学归国人员<label field="PARTY_PEOPLE_EDU4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','留学归国人员')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">36—50岁<label field="PARTY_PEOPLE_AGE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','36—50岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">硕士及以上<label field="PARTY_PEOPLE_EDU3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','硕士及以上')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">担任专职党务干部<label field="PARTY_PEOPLE_TYPE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','担任专职党务干部')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">51-60岁<label field="PARTY_PEOPLE_AGE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','51-60岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">本科或专科<label field="PARTY_PEOPLE_EDU2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本科或专科')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其他人员<label field="PARTY_PEOPLE_TYPE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他人员')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">60岁以上<label field="PARTY_PEOPLE_AGE4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','60岁以上')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">中专及以下<label field="PARTY_PEOPLE_EDU1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','中专及以下')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="6">党员情况</td>
		<td class="FieldInput" width="25%">总数<label field="PARTY_MEMBER_TOTAL"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','总数')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">35岁以下<label field="PARTY_UNDER_THIRTY_FIVE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','35岁以下')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">留学归国人员<label field="PARTY_ABROAD_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','留学归国人员')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">领导班子中党员<label field="LEGAL_PARTY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','领导班子中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">36—50岁<label field="PARTY_ABOVE_THIRTY_FIVE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','36—50岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">硕士及以上<label field="PARTY_MASTER_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','硕士及以上')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中党员<label field="PARTY_PRACTITIONER_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','从业人员中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">51-60岁<label field="PARTY_UNDER_SIXTY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','51-60岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">本科或专科<label field="PARTY_BACHELOR_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本科或专科')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">专职人员中党员<label field="PARTY_FULL_TIME_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','专职人员中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">60岁以上<label field="PARTY_ABOVE_SIXTY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','60岁以上')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">中专及以下<label field="PARTY_SENIOR_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','中专及以下')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度发展新党员<label field="NEW_PARTY_PEOPLE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本年度发展新党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%"> </td>
		<td class="FieldInput" width="25%"> </td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">离退休党员<label field="PARTY_RETIRE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','离退休党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%"> </td>
		<td class="FieldInput" width="25%"> </td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="6">党员学习教育方式</td>
		<td class="FieldInput" width="25%">个人自学<label field="PARTY_STUDY_WAY_SELF1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','个人自学')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%" rowspan="6">党员组织隶属关系</td>
		<td class="FieldInput" width="25%">社会组织党组织<label field="PARTY_PARTY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','社会组织党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">支部学习讨论<label field="PARTY_STUDY_WAY_TALK1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','支部学习讨论')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">业务主管单位党组织<label field="PARTY_BORG_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','业务主管单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">听辅导报告或专题讲座<label field="PARTY_STUDY_WAY_CHAIR1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','听辅导报告或专题讲座')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">挂靠单位党组织<label field="PARTY_LINKED_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','挂靠单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">外出交流参观<label field="PARTY_STUDY_WAY_VISIT1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','外出交流参观')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">属地党组织<label field="PARTY_COLONY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','属地党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">组织文艺活动<label field="PARTY_STUDY_WAY_ART1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','组织文艺活动')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">原工作单位党组织<label field="PARTY_WORK_SPACE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','原工作单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其他形式<label field="PARTY_STUDY_WAY_OTHER1"
		 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党员学习教育方式其他形式')" 	style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">其他党组织<label field="PARTY_OTHER_SUBJECTION_NUM"
		 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他党组织')" 	style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td  width="25%" align="center" colspan="4" style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
			本年度共开展党员活动<label field="PARTY_ACTIVITY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本年度共开展党员活动')" style="cursor: hand; color: blue"></label>
			次，为群众办实事、办好事<label field="ACTIVITY_GOOD_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','为群众办实事、办好事')"
			style="cursor: hand; color: blue"></label> 件。</td>
	</tr>
	<tr>
		<td  width="25%" align="center" colspan="4" style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
			未建党组织的社会组织<label field="IF_BUILD_PARTY0"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','未建党组织的社会组织')"
			style="cursor: hand; color: blue"></label>
			个，党建指导员<label field="IF_PARTY_OFFICER1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党建指导员')" style="cursor: hand; color: blue"></label> 人。</td>
	</tr>
	<tr>
		<td  width="25%" align="center" colspan="4" style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
			应建未建<label field="NO_BUILD_PARTY_RESON1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','应建未建')"
			style="cursor: hand; color: blue"></label>
			 个，有党员但不符合建立党组织条件<label field="NO_BUILD_PARTY_RESON2"
			  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','有党员但不符合建立党组织条件')"
			  style="cursor: hand; color: blue"></label> 个，
			无党员<label field="NO_BUILD_PARTY_RESON3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','无党员')"
			style="cursor: hand; color: blue"></label> 个。
			</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="4">党员情况</td>
		<td class="FieldInput" width="25%">从业人员中党员<label field="PARTY_PRACTITIONER_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','从业人员中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">35岁以下<label field="PARTY_UNDER_THIRTY_FIVE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','35岁以下')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">留学归国人员<label field="PARTY_ABROAD_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','留学归国人员')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">专职人员中党员<label field="PARTY_FULL_TIME_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','专职人员中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">36—50岁<label field="PARTY_ABOVE_THIRTY_FIVE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','36—50岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">硕士及以上<label field="PARTY_MASTER_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','硕士及以上')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">离退休党员<label field="PARTY_RETIRE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','离退休党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">51-60岁<label field="PARTY_UNDER_SIXTY_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','51-60岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">本科或专科<label field="PARTY_BACHELOR_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本科或专科')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度发展新党员<label field="NEW_PARTY_PEOPLE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本年度发展新党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">60岁以上<label field="PARTY_ABOVE_SIXTY_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','60岁以上')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">中专及以下<label field="PARTY_SENIOR_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','中专及以下')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="5">党员组织隶属关系</td>
		<td class="FieldInput" width="25%" colspan="3">业务主管单位党组织<label field="PARTY_BORG_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','业务主管单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" colspan="3">挂靠单位党组织<label field="PARTY_LINKED_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','挂靠单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" colspan="3">属地党组织<label field="PARTY_COLONY_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','属地党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" colspan="3">原工作单位党组织<label field="PARTY_WORK_SPACE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','原工作单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" colspan="3">其他党组织<label field="PARTY_OTHER_SUBJECTION_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党员组织隶属关系为其他党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
</table>
		<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
			lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（三）分支机构、代表机构、专项基金机构、办事机构、经营性实体基本情况</span></p>

		<p class=MsoNormal style='mso-outline-level: 1'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 黑体; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>

		<table width="650">
			<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 19.4pt'>
				<TD  class="FieldInput"  class="FieldInput" width=109 rowspan=2
					style='width: 82.0pt; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.4pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>分支机构总数<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				<TD  class="FieldInput"  class="FieldInput" width=109 rowspan=2
					style='width: 82.0pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.4pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="RAMUS_NUM_A" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','分支机构总数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b> <b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.4pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度新设<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.4pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="RAMUS_NEW_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度新设分支机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 1; height: 19.4pt'>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度注销<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="RAMUS_CANCEL_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度注销分支机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span><span
					style='mso-spacerun: yes'></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 2; height: 18.45pt'>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>代表机构总数<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="DELEGATE_NUM_A" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','代表机构总数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span><span
					style='mso-spacerun: yes'></span><span style='mso-spacerun: yes'></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度新设<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="DELEGATE_NEW_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度新设代表机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 3; height:19.4pt'>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度注销<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="DELEGATE_CANCEL_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度注销代表机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 4; height: 18.45pt'>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>专项基金管理机构总数<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="SPECIAL_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','专项基金管理机构总数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span><span
					style='mso-spacerun: yes'></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度新设<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="SPECIAL_NEW_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度新设专项基金管理机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span><span
					style='mso-spacerun: yes'></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 5; height:19.4pt'>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度注销<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="SPECIAL_CANCEL_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度注销专项基金管理机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 6; height: 18.45pt'>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>办事机构总数<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="OFFICE_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','办事机构总数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度新设<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="OFFICE_NEW_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度新设办事机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span><span
					style='mso-spacerun: yes'></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 7; height:19.4pt'>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度注销<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="OFFICE_CANCEL_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度注销办事机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 8; height: 18.45pt'>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>实体机构总数<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="ENTITY_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','实体机构总数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度新设<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="ENTITY_NEW_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度新设实体机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span><span
					style='mso-spacerun: yes'></span><span style='mso-spacerun: yes'></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>
			<tr style='mso-yfti-irow: 9; mso-yfti-lastrow: yes; height:19.4pt'>
				 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>本年度注销<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
				 <TD  class="FieldInput" class="FieldInput"width=72
					style='width: 53.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height:19.4pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="ENTITY_CANCEL_NUM" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ORGAN_BASIC','本年度注销实体机构个数')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>

			</tr>




						<tr style='mso-yfti-irow: 8; height: 18.45pt'>
				 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>年度所获资金<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
		 <TD  class="FieldInput" class="FieldInput"width=109 rowspan=2
					style='width: 82.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal align=center><b
					style='mso-bidi-font-weight: normal'><span lang=EN-US
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><span
					style='mso-spacerun: yes'><label field="CAPITAL" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ACTIVITY','年度所获资金')" style="cursor: hand; color: blue"
					style="width: 50; text-align: center" /></span></span></b><b
					style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'>个<span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>


		 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'> <span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
		 <TD  class="FieldInput" class="FieldInput"width=88
					style='width: 66.1pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.45pt'>
				<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
					style='mso-bidi-font-size: 10.5pt; font-family: 宋体'> <span
					lang=EN-US><o:p></o:p></span></span></b></p>
				</td>
		</table>

		<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
			lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（四）业务活动情况</span></p>
	<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（1）接受捐赠情况（公募基金会）</span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	单位：人民币元</span></p>
<TABLE width='650' align=center>
								<TBODY>
									<TR>
										<TD  class="FieldInput"  align=middle width='60%' >项 目</TD>
										<TD  class="FieldInput"  align=middle width='40%' >合计</TD>
									</TR>
							<TR>
								<TD  class="FieldInput"  >一、本年捐赠收入</TD>
								<TD  class="FieldInput"  ><label
									name='query$form$0$JJHNJ_REPORT2$heji1' value='' ID='合计1'
									MAXLENGTH='16'  SIZE='16' isMoney='true' field='CURRENT_TOTAL' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','本年捐赠收入')" style="cursor: hand; color: blue"
									style='text-align: right' readonly></TD>
							</TR>
							<TR>
								<TD  class="FieldInput"  >（一）来自境内的捐赠</TD>
								<TD  class="FieldInput"  ><label
									name='query$form$0$JJHNJ_REPORT2$heji2' value='' ID='合计2'
									MAXLENGTH='16'  SIZE='16' isMoney='true' field='IN_TOTAL' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','来自境内的捐赠')" style="cursor: hand; color: blue"
									style='text-align: right' readonly></TD>
							</TR>
							<TR>
								<TD  class="FieldInput"  >（二）来自境外的捐赠</TD>
								<TD  class="FieldInput"  ><label
									name='query$form$0$JJHNJ_REPORT2$heji5' value='' ID='合计5'
									MAXLENGTH='16'  SIZE='16' isMoney='true'field='OFF_TOTAL' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','来自境外的捐赠')" style="cursor: hand; color: blue"
									style='text-align: right' readonly></TD>
							</TR>

						</TBODY>
					</TABLE>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（2）公开募捐情况表（公募基金会）</span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	单位：人民币元</span></p>
					<TABLE width='650' align=center>
								<TBODY>
									<TR>
										<TD  class="FieldInput"  align=middle width='60%' >项 目</TD>
										<TD  class="FieldInput"  align=middle width='40%' >合计</TD>
									</TR>
									<TR>
										<TD  class="FieldInput"  >一、本年度组织开展募捐活动(<label
										 	field='ITEM_NUM' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','开展募捐活动项数')" style="cursor: hand; color: blue" style='text-align: center'></label>)项，募捐取得的收入</TD>
										<TD  class="FieldInput"  align=middle ><label
											name='query$form$0$JJHNJ_REPORT2$heji9' value=''  field='CURRENT_TOTAL1' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','募捐取得的收入')" style="cursor: hand; color: blue"
											MAXLENGTH='16'  SIZE='16' isMoney='true'
											style='text-align: right' readonly></TD>
									</TR>
									<TR>
										<TD  class="FieldInput"  >（一）来自境内的捐赠</TD>
										<TD  class="FieldInput"  align=middle ><label
											name='query$form$0$JJHNJ_REPORT2$heji10' value='' field='IN_TOTAL1' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','来自境内的捐赠')" style="cursor: hand; color: blue"
											MAXLENGTH='16'  SIZE='16' isMoney='true'
											style='text-align: right' readonly></TD>
									</TR>

									<TR>
										<TD  class="FieldInput"  >（二）来自境外的捐赠</TD>
										<TD  class="FieldInput"  align=middle ><label
											name='query$form$0$JJHNJ_REPORT2$heji13' value='' field='OFF_TOTAL1' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','来自境外的捐赠')" style="cursor: hand; color: blue"
											MAXLENGTH='16'  SIZE='16' isMoney='true'
											style='text-align: right' readonly></TD>
									</TR>

								</TBODY>
							</TABLE>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（3）公益支出情况（公募基金会）</span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	单位：人民币元</span></p>
					<TABLE  width='650' align=center >

										<TR>
											<TD  class="FieldInput"  align=middle width='60%' >项
											目</TD>
											<TD  class="FieldInput"  align=middle width='40%' >数额</TD>
										</TR>
										<TR>
											<TD  class="FieldInput"  >上年度实际收入合计</TD>
											<TD  class="FieldInput"  align=middle ><label
												name='query$form$0$JJHNJ_REPORT2$shouruheji' field='COMM_LAST_SUM' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','上年度实际收入合计')" style="cursor: hand; color: blue"
												ID='上年度实际收入合计' MAXLENGTH='8' size='14' CLASS='boder-0'
												isMoney='true' style='text-align: right' ></TD>
										</TR>
										<TR>
											<TD  class="FieldInput"  >调整后的上年度总收入</TD>
											<TD  class="FieldInput"  align=middle ><label
												name='query$form$0$JJHNJ_REPORT2$zongshouru' field='COMM_LAST_TOTAL' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','调整后的上年度总收入')" style="cursor: hand; color: blue"
												ID='调整后的上年度总收入' MAXLENGTH='8' size='14' CLASS='boder-0'
												isMoney='true' style='text-align: right'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
										</TR>
										<TR>
											<TD  class="FieldInput"  >本年度总支出</TD>
											<TD  class="FieldInput"  align=middle ><label
												name='query$form$0$JJHNJ_REPORT2$zongzhichu' field='COMM_EXPENDITURE' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','本年度总支出')" style="cursor: hand; color: blue"
												ID='本年度总支出' size='14' MAXLENGTH='8' CLASS='boder-0'
												isMoney='true' style='text-align: right'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
										</TR>
										<TR>
											<TD  class="FieldInput"  >本年度用于公益事业的支出</TD>
											<TD  class="FieldInput"  align=middle ><label
												name='query$form$0$JJHNJ_REPORT2$gongyizhichu' field='COMM_EXP_PUB' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','本年度用于公益事业的支出')" style="cursor: hand; color: blue"
												ID='公益支出' MAXLENGTH='20' size='14' CLASS='boder-0'
												isMoney='true' style='text-align: right'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
										</TR>
										<TR>
											<TD  class="FieldInput"  >工作人员工资福利支出</TD>
											<TD  class="FieldInput"  align=middle ><label
												name='query$form$0$JJHNJ_REPORT2$fulizhichu' field='COMM_EXP_PER' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','工作人员工资福利支出')" style="cursor: hand; color: blue"
												ID='工资支出' size='14' MAXLENGTH='20' CLASS='boder-0'
												isMoney='true' style='text-align: right'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
										</TR>
										<TR>
											<TD  class="FieldInput"  >行政办公支出</TD>
											<TD  class="FieldInput"  align=middle ><label
												name='query$form$0$JJHNJ_REPORT2$xingzhengzhichu' field='COMM_EXP_OFF' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','行政办公支出')" style="cursor: hand; color: blue"
												ID='行政支出' MAXLENGTH='20' size='14' CLASS='boder-0'
												isMoney='true' style='text-align: right'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
										</TR>
										<TR>
											<TD  class="FieldInput"  >公益事业支出占上年度总收入的比例</TD>
											<TD  class="FieldInput"  align=left >&nbsp;&nbsp;<label
												name='query$form$0$JJHNJ_REPORT2$gongyibili' value=''
												ID='公益比例' MAXLENGTH='14'  SIZE='15'
												style='text-align: right' readonly> %</TD>
										</TR>
										<TR>
											<TD  class="FieldInput" class=unnamed4 >工作人员工资福利和行政办公支出占总支出的比例</TD>
											<TD  class="FieldInput"  align=left >&nbsp;&nbsp;<label
												name='query$form$0$JJHNJ_REPORT2$fulibili' value=''
												ID='福利支出比例' MAXLENGTH='18'  SIZE='15'
												style='text-align: right'></label> </TD>
										</TR>
									</TBODY>
								</TABLE>
<p class=MsoNormal align="center" style="width:650"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	说明：公益事业支出包括直接用于受助人的支出和开展公益项目时发生的项目直接成本，调整后的上年度总收入=上年度实际收入合计-上年收入中时间限定为上年不得使用的限定性收入+于上年解除时间限定的净资产。</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（4）接受捐赠情况（非公募基金会）</span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	单位：人民币元</span></p>
<TABLE width='650' align=center>
								<TBODY>
									<TR>
										<TD  class="FieldInput"  align=middle width='60%' >项 目</TD>
										<TD  class="FieldInput"  align=middle width='40%' >合计</TD>
									</TR>
								<TR>
									<TD  class="FieldInput"  >一、本年捐赠收入</TD>

									<TD  class="FieldInput"  ><label
										name='query$form$0$JJHNJ_REPORT_THR$heji1'  field='CURRENT_TOTAL2' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','本年捐赠收入')" style="cursor: hand; color: blue"
										MAXLENGTH='16'  isMoney='true'
										style='text-align: right' SIZE='16' readonly></TD>
								</TR>
								<TR>
									<TD  class="FieldInput"  >（一）来自境内的捐赠</TD>

									<TD  class="FieldInput"  ><label
										name='query$form$0$JJHNJ_REPORT_THR$heji2'  field='IN_TOTAL2' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','来自境内的捐赠')" style="cursor: hand; color: blue"
										MAXLENGTH='16' isMoney='true' style='text-align: right'
										 SIZE='16' readonly></TD>
								</TR>

								<TR>
									<TD  class="FieldInput"  >（二）来自境外的捐赠</TD>

									<TD  class="FieldInput"  ><label
										name='query$form$0$JJHNJ_REPORT_THR$heji5' field='OFF_TOTAL2' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CONTRIBUTE','来自境外的捐赠')" style="cursor: hand; color: blue"
										MAXLENGTH='16'  isMoney='true'
										style='text-align: right' SIZE='16' readonly></TD>
								</TR>

							</TBODY>
						</TABLE>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（5）公益支出完成情况（非公募基金会）</span></p>
<p class=MsoNormal align="center"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	单位：人民币元</span></p>

						<TABLE width='650' align=center>

										<TBODY>
											<TR align='center'>
												<TD  class="FieldInput"  width='60%' >项 目</TD>
												<TD  class="FieldInput"  width='40%' >数额</TD>
											</TR>
											<TR>
												<TD  class="FieldInput"  >上年度基金余额</TD>
												<TD  class="FieldInput"  align=middle ><label
													name='query$form$0$JJHNJ_REPORT_THR$nianduzongshou'
													field='BALANCE' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','上年度基金余额')" style="cursor: hand; color: blue" ID='上年度基金余额q' MAXLENGTH='8' size='13' CLASS='boder-0'
													isMoney='true' style='text-align: right'
													onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
											</TR>
											<TR>
												<TD  class="FieldInput"  >本年度总支出</TD>
												<TD  class="FieldInput"  align=middle ><label
													name='query$form$0$JJHNJ_REPORT_THR$zongzhichu' field='EXPENDITURE' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','本年度总支出')" style="cursor: hand; color: blue"
													ID='本年度总支出q' MAXLENGTH='8' size='13' isMoney='true'
													style='text-align: right' CLASS='boder-0'
													onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
											</TR>
											<TR>
												<TD  class="FieldInput"  >本年度用于公益事业的支出</TD>
												<TD  class="FieldInput"  align=middle ><label
													name='query$form$0$JJHNJ_REPORT_THR$gongyizhichu' field='EXP_PUB' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','本年度用于公益事业的支出')" style="cursor: hand; color: blue"
													ID='公益支出q' MAXLENGTH='8' isMoney='true' size='13'
													style='text-align: right' CLASS='boder-0'
													onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
											</TR>
											<TR>
												<TD  class="FieldInput"  >工作人员工资福利支出</TD>
												<TD  class="FieldInput"  align=middle ><label
													name='query$form$0$JJHNJ_REPORT_THR$gongzizhichu' field='EXP_PER' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','工作人员工资福利支出')" style="cursor: hand; color: blue"
													ID='工资支出q' MAXLENGTH='8' size='13' isMoney='true'
													style='text-align: right' CLASS='boder-0'
													onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
											</TR>
											<TR>
												<TD  class="FieldInput"  >行政办公支出</TD>
												<TD  class="FieldInput"  align=middle ><label
													name='query$form$0$JJHNJ_REPORT_THR$xingzhengzhichu'
													field='EXP_OFF' onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_EXPENDITURE','行政办公支出')" style="cursor: hand; color: blue" ID='行政支出q' MAXLENGTH='8' isMoney='true' size='13'
													style='text-align: right' CLASS='boder-0'
													onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" ></TD>
											</TR>
											<TR>
												<TD  class="FieldInput"  >公益事业支出占上年度基金余额的比例<font
													color=red></font></TD>
												<TD  class="FieldInput"  align=left >&nbsp;&nbsp;<label
													name='query$form$0$JJHNJ_REPORT_THR$gongyibili' value=''
													ID='公益比例q' MAXLENGTH='14'
													style='text-align: right' SIZE='14' readonly> %</TD>
											</TR>
											<TR>
												<TD  class="FieldInput" class=unnamed4 >工作人员工资福利和行政办公支出占总支出的比例<font
													color=red></font></TD>
												<TD  class="FieldInput"  align=left >&nbsp;&nbsp;<label
													name='query$form$0$JJHNJ_REPORT_THR$fulizhichubili'
													value='' ID='福利支出比例q' MAXLENGTH='18'
													style='text-align: right' SIZE='14' readonly> %</TD>
											</TR>
										</TBODY>
									</TABLE>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
<p class=MsoNormal align="center" style="width:650"><span style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	说明：公益事业支出包括直接用于受助人的支出和开展公益项目时发生的项目直接成本，上年基金余额为上年末净资产。</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（六）资产负债表</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<table width="650">
	<tr>
		<td class="FieldInput" width="25%">货币资金年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="CA_MONEYFUNDS_S"></label></td>
		<td class="FieldInput" width="25%">货币资金期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="CA_MONEYFUNDS_E"  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','货币资金期末数（元）')" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">流动资产合计年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="CA_SUM_S"></label></td>
		<td class="FieldInput" width="25%">流动资产合计期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="CA_SUM_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','流动资产合计期末数（元）')" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">固定资产原价年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_PRIME_COST_S"></label></td>
		<td class="FieldInput" width="25%">固定资产原价期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_PRIME_COST_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','固定资产原价期末数（元）')" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">累计折旧年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_ACCUMULATED_DEPRECIATION_S"></label></td>
		<td class="FieldInput" width="25%">累计折旧期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_ACCUMULATED_DEPRECIATION_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','累计折旧期末数（元）')" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">固定资产合计年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_SUM_S"></label></td>
		<td class="FieldInput" width="25%">固定资产合计期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_SUM_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','固定资产合计期末数（元）')" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">资产总计年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="ASSETS_SUM_S"></label></td>
		<td class="FieldInput" width="25%">资产总计期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="ASSETS_SUM_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','资产总计期末数（元）')" style="cursor: hand; color: blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">净资产合计年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="NET_ASSETS_SUM_S"></label></td>
		<td class="FieldInput" width="25%">净资产合计期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="NET_ASSETS_SUM_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','净资产合计期末数（元）')" style="cursor: hand; color: blue"></label></td>
	</tr>
</table>
		</form>
		</div>
	</next:Html>
</next:Panel>
<!-- 基本情况列表 -->
<next:Window id="baseShowList"  closable="close" title="基本情况列表" width="780" height="300" autoScroll="true" modal="true">
	<next:EditGridPanel id="baseShowListGrid" width="98%" stripeRows="true" height="88%" dataset="baseInfoDs">
		<next:TopBar>
			<next:ToolBarItem  symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="导出为EXCEL" handler="exportExcel"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeBaseWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:Column header="登记证号" width="20%" field="SORG_CODE" editable="false" align="center"><next:TextField /></next:Column>
			<next:Column header="社会会组织名称" width="20%" field="CN_NAME" editable="false" align="center"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
		<next:PagingToolBar dataset="baseInfoDs"/>
	</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!-- 基本情况列表 -->
<next:Window id="showList"  closable="close" title="基本情况列表" width="780" height="300" modal="true">
	<next:EditGridPanel id="showListGrid" width="98%" stripeRows="true" height="88%" dataset="detailDs" >
		<next:TopBar>
			<next:ToolBarItem  symbol="->"></next:ToolBarItem>
			<next:ToolBarItem  iconCls="detail"  text="导出为EXCEL" handler="exportDetailExcel"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:Column header="登记证号" width="15%" field="SORG_CODE" editable="false" align="center"><next:TextField /></next:Column>
			<next:Column header="社会会组织名称" width="20%" field="CN_NAME" editable="false" align="center"><next:TextField /></next:Column>
			<next:Column header="项目名称" width="20%" field="field" editable="false" sortable="true" align="center" ><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
		<next:PagingToolBar dataset="detailDs"/>
	</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>