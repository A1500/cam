<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@ page import="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体分支申请成立登记</title>
<next:ScriptManager></next:ScriptManager>
<script>
	<%
		String sorgId=request.getParameter("sorgId");
		if(sorgId==null){
			sorgId="";
		}
	%>
	var sorgId='<%=sorgId%>';
</script>
<script type="text/javascript" src="groupBranchModifyBuild.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="mainSorgCode" type="string" rule="require" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="residence" type="string" rule="length{100}" />
			<model:field name="sorgPost" type="string" rule="length{6}" />
			<model:field name="sorgPhone" type="string" rule="length{30}" />
			<model:field name="business" type="string" rule="length{2000}" />
			<model:field name="appReason" type="string" rule="length{500}" />
			<model:field name="borgName" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_BRANCH_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 组织名称 -->
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 状态 -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="goBack"/>
	</next:TopBar>
	
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="分支/代表机构信息录入" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false"class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='"分支/代表机构名称"' field="cnName" onblur="cnNameUK();" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>分支/代表机构登记证号：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" id="branchSorgCode" onblur="sorgCodeUK();" name='"分支/代表机构登记证号"' field="sorgCode"  style="width:98%" /><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>办公场所：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" name='"办公场所"' field="residence" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:15%"><label>分支/代表机构电话：</label></td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPhone" name='"分支/代表机构电话"' field="sorgPhone" style="width:90%"/></td>
								<td class="FieldLabel" style="width:15%"><label>分支/代表机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='"分支/代表机构邮编"' field="sorgPost" style="width:90%"/></td>
								<td class="FieldLabel" style="width:15%"><label>分支/代表机构类型：</label></td>
								<td class="FieldInput" style="width:17%">
									<select name='"分支/代表机构类型"' field="sorgKind" style="width:90%">
										<option dataset="sorgKindSelect"></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务范围：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10" name='"业务范围"' field="business" style="width:98%"/></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>设立理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='"设立理由"' field="appReason" style="width:98%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">业务主管单位：</td>
								<td class="FieldInput" colspan="3">
								<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
								<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
        								<ul></ul> 
   									</div>
   									<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
								<span style="color:red">*</span></td>
								
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><input type="text" id="buildDate" name='"成立日期"' field="buildDate" onClick="WdatePicker()" style="width:90%"/><label style="color:red">*</label></td>
							</tr>
							<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
						</table>
					</form>
					<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/borg/borgSelectWindow.jsp" flush="true"/> 
</body>
</html>