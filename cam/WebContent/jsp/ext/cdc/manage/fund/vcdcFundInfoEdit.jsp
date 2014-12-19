<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村社区经费情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcFundInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var fundId='<%=request.getParameter("fundId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="fundDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFundInfoQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFundInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R05'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fundDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:36%">填报单位：</td>
			<td class="FieldInput" style="width:20%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:24%">填报日期：</td>
			<td class="FieldInput" style="width:20%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区经费情况</legend>
		<table border="1"  width="100%" >
	   		<tr>
	   			<td  class="FieldLabel" style="width:18%" rowspan="4" >社区年度办公经费</td>
				<td  class="FieldLabel" style="width:18%" colspan="2">办公经费总额</td>
				<td class="FieldInput"  colspan="3"><label  name ="办公经费总额" field="offMon" renderer="reRender"/> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel"  rowspan="3">办公经费来源</td>
				<td  class="FieldLabel" >财政拨款</td>
				<td class="FieldInput" style="width:20%"><input type="text" name = "办公经费来源财政拨款"  id="offFinanceMon" field="offFinanceMon" onchange="forcheck(this)"  />&nbsp;万元<font color="red">*</font> </td>
			
				<td  class="FieldLabel" style="width:24%" >自筹</td>
				<td class="FieldInput"><input type="text" name = "办公经费来源自筹"  id="offSelfMon" field="offSelfMon" onchange="forcheck(this)" />&nbsp;万元<font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >社会捐助</td>
				<td class="FieldInput"><input type="text" name = "办公经费来源社会捐助"  id="offEnbowMon" field="offEnbowMon" onchange="forcheck(this)"  />&nbsp;万元<font color="red">*</font> </td>
			
				<td  class="FieldLabel" >费随事转</td>
				<td class="FieldInput"><input type="text" name = "费随事转"  id="feeAlongMon" field="feeAlongMon" onchange="forcheck(this)"/>&nbsp;万元<font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >其他</td>
				<td class="FieldInput" colspan="3"><input type="text" name = "其他"  id="offOtherMon" field="offOtherMon" onchange="forcheck(this)"/>&nbsp;万元<font color="red">*</font> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" rowspan="5" >社区年度专项经费</td>
				<td  class="FieldLabel"  colspan="2">专项经费总额</td>
				<td class="FieldInput" colspan="3"><label name = "专项经费总额"  id="sepMon" field="sepMon" renderer="reRender" /> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel"  rowspan="2">专项经费来源</td>
				<td  class="FieldLabel" >财政拨款</td>
				<td class="FieldInput"><input type="text" name = "专项经费来源财政拨款"  id="sepFinanceMon" field="sepFinanceMon" onchange="forzxcheck(this)"   />&nbsp;万元<font color="red">*</font> </td>
			
				<td  class="FieldLabel" >自筹</td>
				<td class="FieldInput"><input type="text" name = "专项经费来源自筹"  id="sepSelfMon" field="sepSelfMon" onchange="forzxcheck(this)"  />&nbsp;万元<font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >社会捐助</td>
				<td class="FieldInput"><input type="text" name = "专项经费来源社会捐助"  id="sepEnbowMon" field="sepEnbowMon" onchange="forzxcheck(this)"  />&nbsp;万元<font color="red">*</font> </td>
			
				<td  class="FieldLabel" >其他</td>
				<td class="FieldInput"><input type="text" name = "专项经费来源其他"  id="sepOtherMon" field="sepOtherMon" onchange="forzxcheck(this)" />&nbsp;万元<font color="red">*</font> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel"  rowspan="2">专项经费用途</td>
				<td  class="FieldLabel" >基础设施建设</td>
				<td class="FieldInput"><input type="text" name = "专项经费用途基础设施建设"  id="useBuildMon" field="useBuildMon"  onchange="forytcheck(this)"/>&nbsp;万元<font color="red">*</font> </td>
			
				<td  class="FieldLabel" >各项活动</td>
				<td class="FieldInput"><input type="text" name = "专项经费用途各项活动"  id="useActionMon" field="useActionMon"  onchange="forytcheck(this)"/>&nbsp;万元<font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >购买服务</td>
				<td class="FieldInput"><input type="text" name = "专项经费用途购买服务"  id="useServiceMon" field="useServiceMon"  onchange="forytcheck(this)"/>&nbsp;万元<font color="red">*</font> </td>
			
				<td  class="FieldLabel" >其他</td>
				<td class="FieldInput"><input type="text" name = "专项经费用途其他"  id="useOtherMon" field="useOtherMon"  onchange="forytcheck(this)"/>&nbsp;万元<font color="red">*</font> </td>
			</tr>
		</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>