<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>导出信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var applyIds = '<%=request.getParameter("applyIds")%>';
	var tableName = '<%=request.getParameter("tableName")%>';
</script>
<script type="text/javascript">
var disDateStart="";
var disDateEnd="";
var empDateStart="";
var empDateEnd="";
var expDateStart="";
var expDateEnd="";
var checkDate="";
function exportExcel(){
	if(applyIds){
		var dataset=L5.DatasetMgr.lookup("exportDataSet");
		dataset.setParameter("applyIds",applyIds);
		dataset.setParameter("tableName",tableName);
		dataset.load();
		var pageSize = dataset.pageInfo.pageSize;
		var pageIndex = dataset.pageInfo.pageIndex;
		var startCursor = dataset.pageInfo.startCursor;
		dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
		dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
		dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
		L5.dataset2excel(dataset, "/jsp/cams/drel/export/commExcel.jsp?disDateStart="+disDateStart+"&disDateEnd="+disDateEnd+"&empDateStart="+empDateStart+"&empDateEnd="+empDateEnd+"&expDateStart="+expDateStart+"&expDateEnd="+expDateEnd+"&checkDate="+checkDate);
		//?disDateStart="+disDateStart+"&disDateEnd="+disDateEnd+"&empDateStart="+empDateStart+"&empDateEnd="+empDateEnd+"&expDateStart="+expDateStart+"&expDateEnd="+expDateEnd+"&checkDate="+checkDate
		dataset.baseParams["excelType"]="reset"; //重置导出类型

	}else{
		L5.Msg.alert("提示","请至少选择一条记录！");
	}
}
function getParam(id){
	return document.getElementById(id).value;
}
function confirm(){
	disDateStart=getParam("disDateStart");
	disDateEnd=getParam("disDateEnd");
	empDateStart=getParam("empDateStart");
	empDateEnd=getParam("empDateEnd");
	expDateStart=getParam("expDateStart");
	expDateEnd=getParam("expDateEnd");
	checkDate=getParam("checkDate");
	exportExcel();
}
function cancel(){
	window.close();
}
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
</script>
</head>
<body>
<model:datasets>
	<!-- 业务信息 test-->
	<model:dataset id="exportDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryExport" global="true"  pageSize="20" >
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="yes" text="确定" handler="confirm()"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="取消" handler="cancel()"></next:ToolBarItem>
</next:TopBar>
<next:Html>
<form id="form1" method="post" onsubmit="return false" class="L5form">
	<fieldset>
	<legend>导出信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:25%">可支配收入核定起始日期：</td>
			<td class="FieldInput" style="width:25%" ><input id="disDateStart" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" /></td>
			<td class="FieldLabel" style="width:25%">可支配收入核定截至日期：</td>
			<td class="FieldInput" style="width:25%" ><input id="disDateEnd" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:25%">就业状态起始日期：</td>
			<td class="FieldInput" style="width:25%" ><input  id="empDateStart" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" /></td>
			<td class="FieldLabel" style="width:25%">就业状态截至日期：</td>
			<td class="FieldInput" style="width:25%" ><input id="empDateEnd" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:25%">支出起始日期：</td>
			<td class="FieldInput" style="width:25%" ><input id="expDateStart" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" /></td>
			<td class="FieldLabel" style="width:25%">支出截至日期：</td>
			<td class="FieldInput" style="width:25%" ><input  id="expDateEnd" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:25%">财产核定日期：</td>
			<td class="FieldInput" style="width:25%" colspan="3"><input id="checkDate" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>