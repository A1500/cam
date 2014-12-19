<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村社区服务填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcServiceInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var userStatus = "vcdcServiceInfoEdit.jsp";
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceModeQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceMode"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R20'/>
			<model:param name="organType" value='N'/>
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
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
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
<legend>社区服务情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="2">公共服务</td>
			<td class="FieldLabel" style="width:18%">公共服务内容：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="publicContent" field="publicContent" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:16%" >公共服务人数：</td>
			<td class="FieldInput" style="width:30%"><input type="text" id="publicPeopleNum" field="publicPeopleNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="2">志愿服务</td>
			<td class="FieldLabel" style="width:18%">志愿服务内容：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="voluntContent" field="voluntContent" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >志愿服务人数：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="voluntPeopleNum" field="voluntPeopleNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="3">商业服务</td>
			<td class="FieldLabel" style="width:18%">商业服务名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="commerceName" field="commerceName" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >商业服务内容：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="commerceContent" field="commerceContent" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >商业服务地址：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="commerceAddress" field="commerceAddress" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="3">服务方式</td>
			<td class="FieldLabel" style="width:18%">是否提供全程代办代理服务：</td>
			<td class="FieldInput" style="width:36%"><select id="ifService" field="ifService" ><option dataset ="YorN"></option> </select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >社区电话服务热线(座机)：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="servicePhone" field="servicePhone" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >社区网络服务平台：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="serviceWeb" field="serviceWeb" maxlength="30" /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>