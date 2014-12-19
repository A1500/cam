<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>城市社区基础设施情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcOwnFacilitiesReportEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<%
String organLevel="";
if(ExtBspInfo.getUserInfo(request)!=null){
	
	ComExtUser user = ExtBspInfo.getUserInfo(request);
	organLevel=user.getOrganType();
}else{
	organLevel=BspUtil.getCorpOrgan().getOrganType();
}
%>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var organLevel='<%=organLevel%>';
	userStatus="cdcOwnFacilitiesReportEdit.jsp";
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="fReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFacilitiesReport"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R06'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='AREA_CODE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ownPropertiesDataSet" enumName="CDC.OWN_PROPERTIES" global="true" autoLoad="true"  />
	<model:dataset id="buildPropertiesDataSet" enumName="CDC.BUILD_PROPERTIES" global="true" autoLoad="true"  />
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区基础设施情况</legend>
		<table border="1"  width="100%" >
	   		<tr>
	   			<td  class="FieldLabel"  rowspan="3">社区办公服务用房</td>
	   			
				<td  class="FieldLabel" colspan="2">办公服务用房数量</td>
				<td class="FieldInput"  ><input type="text" name = "办公服务用房数量"  id="offNum" field="offNum"  onchange="forcheck(this)" />&nbsp;间</td>
				<td  class="FieldLabel" >办公服务用房建筑面积</td>
				<td class="FieldInput"><input type="text" name = "办公服务用房建筑面积"  id="offArea" field="offArea" onchange="fordecimalcheck(this)"  />&nbsp;㎡</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" colspan="2">办公服务用房投入资金</td>
				<td class="FieldInput"><input type="text" name = "办公服务用房投入资金"  id="offMon" field="offMon"  onchange="fordecimalcheck(this)" />&nbsp;万元</td>
				<td  class="FieldLabel" >投入使用年份</td>
				<td class="FieldInput" ><input type="text" name = "投入使用年份"  id="offYear" field="offYear"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" colspan="2">所有性质</td>
				<td class="FieldInput" ><select name = "所有性质"  id="offKind" ><option dataset ="ownPropertiesDataSet" /></select> </td>
				<td  class="FieldLabel" >建筑性质</td>
				<td class="FieldInput" ><select name = "建筑性质"  id="offBuild"><option dataset="buildPropertiesDataSet" /></select>  </td>
			</tr>
			<%if(!"JD".equals(organLevel)){ %>
	   		<tr>
	   			<td  class="FieldLabel"  rowspan="2">社区室外活动场地</td>
				<td  class="FieldLabel" colspan="2">室外活动室数量</td>
				<td class="FieldInput" ><input type="text" name = "室外活动室数量"  id="outNum" field="outNum"  onchange="forcheck(this)" />&nbsp;个</td>
			
				<td  class="FieldLabel" >室外活动室面积</td>
				<td class="FieldInput" ><input type="text" name = "室外活动室面积"  id="outArea" field="outArea" onchange="fordecimalcheck(this)"  />&nbsp;㎡</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">投入资金</td>
				<td class="FieldInput" ><input type="text" name = "室外活动室投入资金"  id="outMon" field="outMon" onchange="fordecimalcheck(this)"  />&nbsp;万元</td>
				<td  class="FieldLabel" >投入使用年份</td>
				<td class="FieldInput"  ><input type="text" name = "室外活动室投入使用年份"  id="outYear" field="outYear"  /> </td>
			</tr>
			<%} %>
		</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>