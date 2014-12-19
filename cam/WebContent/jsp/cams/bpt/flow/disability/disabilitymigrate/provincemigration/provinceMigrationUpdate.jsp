<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
	var peopleId = '<%=request.getParameter("peopleId")%>';
	var applyId = '<%=request.getParameter("applyId")%>';
</script>
<html>
<head>
<title> 修改伤残人员省内迁移信息</title>
<next:ScriptManager />
<script type="text/javascript" src="provinceMigrationUpdate.js"></script>
<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 伤残人员省内迁移 -->
	<model:dataset id="ProvinceMigrationDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand" method="queryDisaUpdateRecord" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
			<model:field name="idCard" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="disabilityCaseCode" type="string"/>
			<model:field name="disabilityLevelCode" type="string"/>
			<model:field name="disabilityNo" type="string"/>
			<model:field name="disabilityTypeCode" type="string"/>
			<model:field name="ingoingName" type="string"/>
			<model:field name="domicileName" type="string"  />
			<model:field name="apanageName" type="string"  />
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
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%" >
	<next:TabPanel>
		<next:Tabs>
		
		<next:Panel title="基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="类别信息" width="100%" height="100%"
				id="disabilityTypeTabPanel">
				<next:Html>
				  <iframe id="disabilityType" src="../../assessdisability/disabilityTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
			
		<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				    <iframe id="upload" src="../../../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=16&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

			<next:Panel width="100%" height="100%" autoScroll="false" title="迁移信息">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem symbol="-" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
					<next:ToolBarItem symbol="-" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
					<next:ToolBarItem symbol="-" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="disable"  text="关闭" handler="func_Close"/>
					<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				</next:TopBar>
				<next:Html>
					<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="ProvinceMigrationDataSet">
					<table border="1" width="99%">
						<tr>
							<td class="FieldLabel" style="width:20%">身份证号:</td>
							<td class="FieldInput" style="width:15%" nowrap="nowrap"><label type="text" style="width:135" name="idCard" field="idCard"/></td>
							<td class="FieldLabel" style="width:15%">姓名:</td>
							<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
							<td class="FieldLabel" style="width:15%">性别:</td>
							<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
				   		</tr>
				   		<tr>
				   			<td class="FieldLabel">残疾人员类别:</td>
							<td class="FieldInput"><label id="disabilityTypeCode" name="disabilityTypeCode" field="disabilityTypeCode" dataset="DisabilityTypeCodeEnum"/></td>
							<td class="FieldLabel">残疾性质:</td>
							<td class="FieldInput"><label id="disabilityCaseCode" name="disabilityCaseCode" field="disabilityCaseCode" dataset="DisabilityCaseDataset"></label></td>
							<td class="FieldLabel">残疾等级:</td>
							<td class="FieldInput"><label id="disabilityLevelCode" name="disabilityLevelCode" field="disabilityLevelCode" dataset="DisabilityLevelDataset"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">残疾证号:</td>
							<td class="FieldInput" colspan="5"><label id="disabilityNo" name="disabilityNo" field="disabilityNo"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">迁入地民政局:</td>
							<td class="FieldInput"><input type="hidden" id="ingoingCode" name="ingoingCode" field="ingoingCode"/>
												   <input type="text" id="ingoingName" readonly="readonly" name="ingoingName" field="ingoingName" onclick="func_Ingoing()"/>
							<font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">残疾抚恤金已发至:</td>
							<td class="FieldInput"><input type="text" id="allowanceMonth" name="allowanceMonth" field="allowanceMonth" format="Y-m" style="width: 100px;" maxlength="10"/><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话:</td>
							<td class="FieldInput" ><input type="text" name="outTownCheckPhone" field="outTownCheckPhone"/></td>
						</tr>
						<tr>
							
							<td class="FieldLabel" >迁入地户口薄(行政区划):</td>
									   <td class="FieldInput" colspan="5" >
									       <input type="text" id="domicileName" style="width:300px;" name="domicileName" field="domicileName" title="属地行政区划" onclick="func_ForInDomicileSelect()" readonly="readonly"/><font color="red">*</font>
									       <input type="hidden" id="domicileCode" name="domicileCode" field="inDomicileCode" title="属地行政区划"/> 
							  			&nbsp;&nbsp;&nbsp;地址: 
									    <input type="text" style="width:300px;" id="inDomicileAddress" name="inDomicileAddress" field="inDomicileAddress" title="户口薄住址" ></td>      
						</tr>
						<tr>
							<td class="FieldLabel">迁入地实际居住(行政区划):</td> 
										<td class="FieldInput" colspan="5"><input type="text" style="width:300px;" id="apanageName" name="apanageName" field="apanageName" title="行政区划" readonly="readonly" onclick="func_ForInApanageSelect()"/><font color="red">*</font>
										<input type="hidden" name="apanageCode" field="inApanageCode" title="行政区划"/>       
							         &nbsp;&nbsp;&nbsp;地址: 
										 <input type="text" style="width:300px;" id="inApanageAddress" name="inApanageAddress" field="inApanageAddress" title="实际居住地址"  ></td>  
						</tr>
						<input type="hidden" id="peopleId" field="peopleId">
						<input type="hidden" id="familyId" field="familyId">
						<!-- 打印相关 -->
						<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
						<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/disabilitymigrate/provincemigration/print/disabilityProvinceMigration_table.doc"/>
						<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
						<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
						<input type="hidden" id="method" value="queryProvinceMigration"/>
						<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="16"/>
					</table>
					</form>
			   </next:Html>
			</next:Panel>
			<next:Panel title="县级审核" width="100%" height="100%"
				id="eTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../comm/townProvinceMigratApprove.jsp?applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>	
			</next:Tabs>
	</next:TabPanel>
</next:Panel>
			
<script type="text/javascript">
	function print() {
		var url="../../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</body>
</html>
