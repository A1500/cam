<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>工作经费统计图</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyMoneyList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
		var organCode = '<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		var organName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmCompanyMoneyDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyMoneyQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyMoney"/>
	</model:dataset>
	<!-- 字典表的引用 单位所属业务类别  001-->
	<model:dataset id="typeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_JCM_DETAILS"></model:param>        <!-- 需要查询的表 -->
			<model:param name="value" value="CODE"></model:param>     <!-- 查询的内容 -->
			<model:param name="text" value="NAME"></model:param>    <!-- 输出查询的结果 -->
			<model:param name="filterSql" value='DIC_TYPE=001'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:TabPanel id="tabPanel" width="100%" height="100%">
<next:Tabs>
<next:Panel width="100%" border="0" title="各年度工作经费走势图">
	<next:Panel>
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="10%">单位名称：</td>
		            <td class="FieldInput" width="20%">
		            <input type="text"  id="companyName" style="width:40%" onclick="selectPep()" />
		            <input type="hidden"  id="companyId" style="width:20%"/>
		            </td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:Panel id="pan"  width="100%"  hidden="true">
	<next:Html><iframe id="nodeFrame"  name="nodeFrame" width="100%" height="450"></iframe></next:Html>
</next:Panel>
</next:Panel>
<next:Panel title="年度工作经费统计图" width="100%">
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="10%">年度：</td>
		            <td class="FieldInput" width="20%">
		            <input type="text"  id="year" style="width:40%" format="Y"
								onclick="WdatePicker({dateFmt:'yyyy'})" /><font color="red"> *</font>
		            </td>
		            <!-- 
		            <td class="FieldLabel" width="10%">单位所属业务类别：</td>
							            <td class="FieldInput" width="20%"><select type="text" id="companyType"
											class="TextEditor" title="单位所属业务类别" />
											<option dataset="typeDS"/>
										</select></td>
					  -->
					<td class="FieldButton" style="width:20%"><button onclick="query1()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:Panel id="pan1"  width="100%"  hidden="true">
	<next:Html><iframe id="nodeFrame1"  name="nodeFrame" width="100%" height="450"></iframe></next:Html>
</next:Panel>
</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:Panel>
</body>
</html>