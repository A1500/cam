
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<html>
	<head>
		<title>CDC_UNDER_GOVEMNS_INFO明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" >
function init() {	
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/ext/cdc/manage/underGovemnsInfo/cdcundergovemnsinfo_list.jsp';
		var text = '';
		L5.forward(url,text);	 
 }
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.cdc.base.cmd.CdcUnderGovemnsInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo"></model:record>
		<model:params>
			<model:param name="RECORD_ID" value='<%=request.getParameter("recordId")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="下辖村情况基本信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >下辖村名称:</td>
				<td colspan="3" class="FieldInput"><label field="villageName" /> </td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >总人口数:</td>
				<td class="FieldInput"><label field="headCount" /> </td>
			
				<td class="FieldLabel" >总户数:</td>
				<td class="FieldInput"><label field="householdsNum" /> </td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >耕地面积:</td>
				<td class="FieldInput"><label field="agriculturalArea" /> </td>
			
				<td class="FieldLabel" >宅基地面积:</td>
				<td class="FieldInput"><label field="houseArea" /> </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
