<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>修改换证、补证信息</title>
<next:ScriptManager />
<script type="text/javascript">
	var peopleId = '<%= (String)request.getParameter("peopleId")%>';
	var familyId = '<%= (String)request.getParameter("familyId")%>';
	var applyId = '<%= (String)request.getParameter("applyId")%>';
</script>
<script type="text/javascript" src="exchaCertiDisaUpdate.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 伤残审批信息 -->
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="queryAdjustDisability" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability">
			<!-- 人员信息 字段 -->
			<model:field name="familyId" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="nation" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="disabilityNo" type="string"/>
			<!-- 行政区划 字段 -->
			<model:field name="apanageName" type="string"/>
			<!-- 伤残信息 字段 -->
			<model:field name="conscriptDate" type="string"/>
			<model:field name="veteransDate" type="string"/>
			<model:field name="disabilityGenusCode" type="string"/>
			<model:field name="uinitOfDisability" type="string"/>
			<model:field name="disabilityCaseCode" type="string"/>
			<model:field name="disabilityLevelCode" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true" bodyStyle="width:100%" width="100%" >
	<next:TabPanel>
		<next:Tabs>
		
		<next:Panel title="基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="类别信息" width="100%" height="100%"
				id="disabilityTypeTabPanel">
				<next:Html>
				  <iframe id="disabilityType" src="../assessdisability/disabilityTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../../comm/memberList.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../../comm/houseUpdate.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				    <iframe id="upload" src="../../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=13&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

			<next:Panel width="100%" height="100%" autoScroll="false" title="换证、补证或者证件变更信息">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
					<next:ToolBarItem symbol="-" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
					<next:ToolBarItem symbol="-" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
					<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				</next:TopBar>
				<next:Html>
					<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="DisabilityApproveDataset">
					<table border="1" width="99%">
						<tr>
							<td class="FieldLabel" style="width:15%">姓名：</td>
							<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
							<td class="FieldLabel" style="width:15%">性别：</td>
							<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
							<td class="FieldLabel" style="width:15%">身份证号：</td>
							<td class="FieldInput" style="width:15%" nowrap="nowrap"><label name="idCard" field="idCard"/></td>
				   		</tr>
				   		
				   		<tr>
				   			<td class="FieldLabel">民族：</td>
							<td class="FieldInput"><label id="nation" name="nation" field="nation" dataset="NationDataset"></label></td>
				   			<td class="FieldLabel">出生年月：</td>
							<td class="FieldInput" colspan="3"><label id="birthday" name="birthday" field="birthday"/></td>
				   		</tr>
				   		
				   		<tr>
				   			<td class="FieldLabel" nowrap="nowrap">入伍（参加工作）时间：</td>
							<td class="FieldInput"><label id="conscriptDate" name="conscriptDate" field="conscriptDate"/></td>
							<td class="FieldLabel" nowrap="nowrap">退伍（离退休）时间：</td>
							<td class="FieldInput"><label id="veteransDate" name="veteransDate" field="veteransDate"/></td>
							<td class="FieldLabel">伤残属别：</td>
							<td class="FieldInput"><label id="disabilityGenusCode" name="disabilityGenusCode" field="disabilityGenusCode" dataset="DisabilityGenusDataset"></label></td>					
						</tr>
						
				   		<tr>
				   			<td class="FieldLabel">致残时所在单位：</td>
							<td class="FieldInput"><label id="uinitOfDisability" name="uinitOfDisability" field="uinitOfDisability"/></td>
							<td class="FieldLabel">伤残性质：</td>
							<td class="FieldInput"><label id="disabilityCaseCode" name="disabilityCaseCode" field="disabilityCaseCode" dataset="DisabilityCaseDataset"></label></td>
							<td class="FieldLabel">伤残等级：</td>
							<td class="FieldInput"><label id="disabilityLevelCode" name="disabilityLevelCode" field="disabilityLevelCode" dataset="DisabilityLevelDataset"></label></td>
						</tr>
						
				   		<tr>
				   			<td class="FieldLabel">住址行政区划：</td>
							<td class="FieldInput"><label id="apanageName" name="apanageName" field="apanageName"/></td>
							<td class="FieldLabel">地址：</td>
							<td class="FieldInput" colspan="5"><label id="address" name="address" field="address"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">原残疾证件编号：</td>
							<td class="FieldInput" colspan="5"><label id="disabilityNo" name="disabilityNo" field="disabilityNo"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">换证、补证或证件变更原因：</td>
							<td class="FieldInput" colspan="5"><textarea id="exchangeReason" name="exchangeReason" field="exchangeReason" rows="3" style="width:95%"></textarea><font color="red">*</font></td>
						</tr>
						<input type="hidden" id="peopleId" field="peopleId">
						<input type="hidden" id="familyId" field="familyId">
						
						
					</table>
					</form>
					<!-- 打印相关 -->
					<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
					<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/exchacertidisa/print/exchacertidisa_table.doc"/>
					<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="13"/>
					<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
					<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
					<input type="hidden" id="method" value="queryExchaCertiDis"/>
			   </next:Html>
			</next:Panel>	
			<next:Panel title="县级审核" width="100%" height="100%"
				id="townVerify">
				<next:Html>
				  <iframe id="townVerifyTabPanel" src="../common/disablitychangecert_townVerify.jsp?applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
