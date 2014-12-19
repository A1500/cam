<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市社区基础设施情况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="fReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFacilitiesReport"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R06'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" >填报日期：</td>
			<td class="FieldInput" ><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" >上报日期：</td>
			<td class="FieldInput" ><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区基础设施情况</legend>
	<table border="1"  width="100%" >
	   		<tr>
	   			<td  class="FieldLabel"  rowspan="3">社区办公服务用房</td>
				<td  class="FieldLabel" colspan="2">办公服务用房数量</td>
				<td class="FieldInput"  ><label id="offNum" field="offNum"  renderer="jRender"/></td>
			
				<td  class="FieldLabel" >办公服务用房建筑面积</td>
				<td class="FieldInput"><label id="offArea" field="offArea"  renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" colspan="2">办公服务用房投入资金</td>
				<td class="FieldInput"><label  id="offMon" field="offMon"  renderer="reRender"/></td>
				<td  class="FieldLabel" >投入使用年份</td>
				<td class="FieldInput" ><label id="offYear" field="offYear"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" colspan="2">所有性质</td>
				<td class="FieldInput" ><label id="offKind"/> </td>

				<td  class="FieldLabel" >建筑性质</td>
				<td class="FieldInput" ><label id="offBuild" /> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel"  rowspan="2">社区室外活动场地</td>
	   			
				<td  class="FieldLabel" colspan="2">室外活动室数量</td>
				<td class="FieldInput" ><label id="outNum" field="outNum"  renderer="gRender"/></td>
			
				<td  class="FieldLabel" >室外活动室面积</td>
				<td class="FieldInput" ><label id="outArea" field="outArea"  renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">投入资金</td>
				<td class="FieldInput" ><label id="outMon" field="outMon"   renderer="reRender" /></td>
				<td  class="FieldLabel" >投入使用年份</td>
				<td class="FieldInput"  ><label id="outYear" field="outYear"  /> </td>
			</tr>
		</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
	var ds=L5.DatasetMgr.lookup("fReportDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	ds.on("load",function(){
			var record=ds.getCurrent();
			if(record.get("offKindSelf")!=0){
				document.getElementById("offKind").innerHTML = "自有"
			}else if(record.get("offKindLease")!=0){
				document.getElementById("offKind").innerHTML = "租赁"
			}else if(record.get("offKindLend")!=0){
				document.getElementById("offKind").innerHTML = "借用"
			}else if(record.get("offKindOther")!=0){
				document.getElementById("offKind").innerHTML = "其他"
			}
			
			if(record.get("offBuildNew")!=0){
				document.getElementById("offBuild").innerHTML = "新建"
			}else if(record.get("offBuildChange")!=0){
				document.getElementById("offBuild").innerHTML = "扩改建"
			}else if(record.get("offKindLend")!=0){
				document.getElementById("offBuild").innerHTML = "其他"
			}
			
		});
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function reRender(val){
	if(val==''){
	return "0 万元";
	}
	return val+" 万元";
}
function gRender(val){
	if(val!="")
	return val+" 个";
}
function jRender(val){
	if(val!="")
	return val+" 间";
}
function aRender(val){
	if(val!="")
	return val+" ㎡";
}
</script>