<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@page import="java.util.HashMap" %>
<html> 
	<head>
		<title>退役军人伤残抚恤关系迁入审批表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="../../../jsp/cams/bpt/comm/bptComm.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
				<script>
					<%
						String peopleId = request.getParameter("peopleId");
						String applyId = request.getParameter("applyId");
						String familyId = request.getParameter("familyId");
						String serviceType = request.getParameter("serviceType");
						 
						String primaryKey=request.getParameter("primaryKey");
						//System.out.println(primaryKey);
					    if(primaryKey==null)
					    	primaryKey="";
					%>
					<%
						String assignmentId=(String)request.getParameter("assignmentId");
						String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
						String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
						//然调用接口
						WfQuery wfQuery = new WfQuery();
						List<Map> list = wfQuery.getActButtons(actDefUniqueId);
						List<Map> list1=wfQuery.getActFields(actDefUniqueId);
					
						Map actMap = wfQuery.getActivityDefInfoByActDefUniqueId(actDefUniqueId);
						String actDefName = (String)actMap.get("actDefName");
						//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
						//如果域是只读的则显示为只读
						//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
						String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
						//boolean isHidden,isReadOnly,isNotNull;
					%>
					var processId = '<%= (String)request.getParameter("processId")%>';
					var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
					var assignmentId="<%=assignmentId%>";
					var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
					 
					var serviceType = '<%=serviceType%>';
					var peopleId = '<%=peopleId%>';
					var applyId = '<%=applyId%>';
					var familyId = '<%=familyId%>';
					var actDefName = '<%=actDefName%>';
				</script>
				<script type="text/javascript" src="../../../jsp/cams/bpt/flow/disability/assessdisability/disabilityVeterans_Flow.js"></script>
		</head>
<body>
<model:datasets>
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="query" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability">
			<model:field name="name" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="workUnitName" type="string"/>
			<model:field name="disabilityTypeCode" type="string"/>
			<model:field name="disabilityDate" type="string"/>
			<model:field name="disabilityAdd" type="string"/>
			<model:field name="disabilityBody" type="string"/>
			<model:field name="disabilityReason" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="ServiceTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	
	
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 审批条件 -->
	<model:dataset id="ApplyContent" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 上报标示 -->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="false">
<next:Tabs>
	<next:TabPanel id="allPanel" animScroll="true" enableTabScroll="true" width="100%">
<next:Panel width="100%" id="peopleTabPanel" title="基本信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/peopleDetail.jsp?peopleId=<%=peopleId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="typeTabPanel" title="类别信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/disability/veteransshift/veteransTypeDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="menberTabPanel" title="家庭成员信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/memberListDetail.jsp?familyId=<%=familyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html> 
</next:Panel>
<next:Panel width="100%" id="houseTabPanel" title="住房信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/houseDetail.jsp?familyId=<%=familyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
<next:Panel title="审批表" width="100%" height="100%"
				id="ass_dis_appTabPanel" >
				<next:Html>
				  <iframe  id="apptable" src="../../../jsp/cams/bpt/flow/disability/assessdisability/print/ass_disability_apptable.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
					 	frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%" >
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="introductTabPanel" title="介绍信" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/comm/introductionLetterDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="acceptTabPanel" title="受理通知书" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/comm/acceptNoticeDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel title="公示书" width="100%" height="100%"
				id="open_dis_appTabPanel" >
				<next:Html>
				  <iframe  id="openNotice" src="../../../jsp/cams/bpt/flow/disability/assessdisability/openDisabilityUpdate.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
					 	frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%" >
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel title="不予评定决定书" width="100%" height="100%"
				id="decisionLetterTabPanel">
				<next:Html>
				  <iframe id="decisionTabPanel" src="../../../jsp/cams/bpt/flow/disability/assessdisability/decisionLetterUpdate.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel id="exchaTable" width="100%" height="100%" autoScroll="false" title="换证,补证信息">
				<next:Html>
				    <iframe id="exchaTab" src="../../../jsp/cams/bpt/flow/disability/exchacertidisa/print/exchaCertiDisatable.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		<next:Panel id="changeTable" width="100%" height="100%" autoScroll="false" title="残疾人员证件变更">
				<next:Html>
				    <iframe id="changeTab" src="../../../jsp/cams/bpt/flow/disability/changecertidisa/print/changeCertiDistable.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="残疾人员抚恤关系迁入表" width="100%" height="100%" id="intoTable">
				<next:Html>
				    <iframe id="tableFrame" src="../../../jsp/cams/bpt/flow/disability/veteransshift/print/disabilityInfoProvince_table.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>		
<next:Panel  title="伤残申请审批" height="100%" width="100%" id="approveTabPanel" autoScroll="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<% 
			//从后台获取环节按钮权限，显示要显示按钮
			for(int i=0;i<list.size();i++){
				Map map=(Map)list.get(i);
				String buttonName=(String)map.get("buttonName");
				String buttonFunName=(String)map.get("buttonFunName");
				%>			 
				<next:ToolBarItem iconCls="submit" text="<%=buttonName %>" handler="<%=buttonFunName %>" />
				<%
			}
		%>
		<next:ToolBarItem iconCls="submit" text="添加到黑名单" handler="addBlackList" />
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="DisabilityApproveDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="0"  width="99%" >
			<div>
				<table width="99%">
					<tr>
						<td class="FieldLabel" width="15%" align="right">姓名</td>
						<td class="FieldInput" width="15%"><label name="name" field="name"/></td>
						<td class="FieldLabel" width="15%">出生年月</td>
						<td class="FieldInput" width="15%"><label type="birthday" name="birthday" field="birthday"/></td>
						<td class="FieldLabel" width="15%">类别</td>
						<td class="FieldInput" ><label type="text" name="disabilityTypeCode" field="disabilityTypeCode" dataset="DisabilityTypeCodeEnum"/></td>
					</tr>
					<tr>
			   			<td class="FieldLabel">工作单位</td>
						<td class="FieldInput" colspan="5"><label name="address" field="address" /></td>
					</tr>
					<tr>
			   			<td class="FieldLabel">住址</td>
						<td class="FieldInput" colspan="5"><label name="workUnitName" field="workUnitName" /></td>
					</tr>
			   		<tr>
			   			<td class="FieldLabel">业务类型</td>
						<td class="FieldInput"><label name="serviceType" field="serviceType" dataset="ServiceTypeDataset"/></td>
						<td class="FieldLabel">申请机构</td>
						<td class="FieldInput" colspan="3"><label type="text" name="approveOrganId" field="approveOrganId"/></td>
					</tr>
					<tr id="adjust">
						<td colspan="6">
							<table width="100%">
								<!--  <tr>	
									<td class="FieldLabel" colspan="2" style="width:20%">调整伤残等级原因：</td>
									<td class="FieldInput" colspan="3"><label name="adjustReason" field="adjustReason" rows="3" style="width:90%"/></label></td>
								</tr>
								-->
								<tr>
									<td class="FieldLabel" colspan="2" tyle="width:20%">致残时间：</td>
									<td class="FieldInput" colspan="3"><label name="disabilityDate" field="disabilityDate"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2">致残地点：</td>
									<td class="FieldInput" colspan="3"><label name="disabilityAdd" field="disabilityAdd"></label></td>
								</tr>
								<tr>	
									<td class="FieldLabel" colspan="2">致残情况：</td>
									<td class="FieldInput" colspan="3"><label name="disabilityBody" field="disabilityBody"/></label></td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2">致残原因：</td>
									<td class="FieldInput" colspan="3"><label name="disabilityReason" field="disabilityReason"></label></td>	
								</tr>
							</table>
						</td>
					</tr>
					<tr id="exchacerti">
						<td colspan="6">
							<table width="100%">
								<tr>
									<td class="FieldLabel" colspan="2" style="width:20%">换证、补证原因：</td>
									<td class="FieldInput" colspan="3"><label id="exchangeReason" name="exchangeReason" field="exchangeReason"></label></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr id="changecertidisa">
						<td colspan="6">
							<table width="100%">
								<tr>
									<td class="FieldLabel" colspan="2" style="width:20%">需变更原因及内容：</td>
									<td class="FieldInput" colspan="3"><label id="changeReasonContent" name="changeReasonContent" field="changeReasonContent"></label></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<br>
			<div id="TownVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="4" nowrap="nowrap">县级审核</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><input disabled="disabled" type="text" name="townAduitIncharge" field="townAduitIncharge" readonly="readonly" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input disabled="disabled" type="text" name="townAduitApproveDate" field="townAduitApproveDate" readonly="readonly"  /> </td>
					</tr>
					
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
							<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput">
									<select style="width:90px;"  name="townFlag" id="TownVerifyFlag" field="townFlag" onchange="changeAppDiv('TownVerify')">
										<option dataset="ApplyContent"></option>
									</select>
								</td>
								<td class="FieldInput">
									<div id="TownVerifyPass" style="display:none">伤残性质：
										<select disabled="disabled" name="townAduitDisabilityNature" field="townAduitDisabilityNature">
											<option dataset="DisabilityCaseDataset"></option>
										</select> 
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<select disabled="disabled"  name="townAduitDisabilityLevel" field="townAduitDisabilityLevel">
											<option dataset="DisabilityLevelDataset"></option>
										</select> 
									</div>
									<div id="TownVerifyEnd" disabled="disabled" style="display:none">
										是否上报：
										<select name="townReport" id="townReport" field="townReport" >
											<option dataset="ReportFlagEnum"></option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<textarea disabled="disabled" name="townAduitAdvice" field="townAduitAdvice" style="width:80%" rows="2"></textarea> </td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</div>
			<br>
			<div id="CityVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="2" nowrap="nowrap">市级审核</td>
			   			<td  class="FieldLabel" style="width:10%">负责人</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="市级审核负责人" name="cityAduitIncharge" field="cityAduitIncharge" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="时间"format="Y-m-d" style="width: 100px; name="cityAduitApproveDate" field="cityAduitApproveDate" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
			   		<tr>
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
							<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput">
									<select style="width:90px;" name="cityFlag" 
									validateType="cityAduitDisabilityNature:cityAduitDisabilityLevel:cityReport"
									 validateName="审批意见" id="CityVerifyFlag" field="cityFlag" onchange="changeAppDiv('CityVerify')">
										<option dataset="ApplyContent"></option>
									</select>
								</td>
								<td class="FieldInput">
									<div id="CityVerifyPass" style="display:none">伤残性质： 
										<select name="cityAduitDisabilityNature" validateType="disabilityCaseCode"  field="cityAduitDisabilityNature">
											<option dataset="DisabilityCaseDataset"></option>
										</select>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<select name="cityAduitDisabilityLevel" validateType="disabilityLevelCode"  field="cityAduitDisabilityLevel">
											<option dataset="DisabilityLevelDataset"></option>
										</select>	
									</div>
									<div id="CityVerifyEnd"  style="display:none">
										是否上报：
										<select name="cityReport" id="cityReport" field="cityReport" >
											<option dataset="ReportFlagEnum"></option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<textarea type="text" name="cityAduitAdvice" field="cityAduitAdvice" style="width:80%" rows="2"></textarea>
								</td>
							</tr>
						</table>
						 </td>
					</tr>
				</table>
			</div>
				<br>
				
			<div id="ProvinceAccept" style="display:none">
				<table width="99%">
					<tr>
						<td  class="FieldLabel" rowspan="6" nowrap="nowrap">省级审批</td>			   			
			   			<td  class="FieldLabel" nowrap="nowrap">受理人员</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="受理人员" name="provinceCheckPeopleId" field="provinceCheckPeopleId" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="时间" format="Y-m-d" style="width: 100px; name="provinceCheckDate" field="provinceCheckDate" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">负伤时间</td>
						<td class="FieldInput" style="width:30%"><label name="disabilityDate" field="disabilityDate" ></label> </td>
						<td  class="FieldLabel" nowrap="nowrap">负伤地点</td>
						<td class="FieldInput" style="width:30%"><label   name="disabilityAdd" field="disabilityAdd" ></label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">负伤部位</td>
						<td class="FieldInput" style="width:30%"><label  name="disabilityBody" field="disabilityBody" ></label> </td>
						<td  class="FieldLabel" nowrap="nowrap">负伤原因</td>
						<td class="FieldInput" style="width:30%"><label  name="disabilityReason" field="disabilityReason" ></label> </td>
					</tr>
			   		<tr>
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
							<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput">
									<select style="width:90px;"  name="proCheckFlag" 
									validateType="provinceCheckDisNature:provinceCheckDisLevel:null"
									validateName="审批意见" id="ProvinceAcceptFlag" field="proCheckFlag" onchange="changeAppDiv('ProvinceAccept')">
										<option dataset="ApplyContent"></option>
									</select>
								</td>
								<td class="FieldInput">
									<div id="ProvinceAcceptPass" style="display:none">伤残性质：
										<select name="provinceCheckDisNature" validateType="disabilityCaseCode"  field="provinceCheckDisNature">
											<option dataset="DisabilityCaseDataset"></option>
										</select>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<select name="provinceCheckDisLevel" validateType="provinceCheckDisLevel" field="provinceCheckDisLevel">
											<option dataset="DisabilityLevelDataset"></option>
										</select>
									</div>
									<!-- <div id="ProvinceAcceptEnd"  style="display:none">
										是否上报：
										<select name="proCheckReport" id="proCheckReport" field="proCheckReport" >
											<option dataset="ReportFlagEnum"></option>
										</select>
									</div> -->
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<textarea type="text" name="provinceCheckAdvice" field="provinceCheckAdvice" style="width:80%" rows="2"></textarea> 
								</td>
							</tr>
						</table>
						</td>
					</tr>
					
				</table>
			</div>
		</table>
		</form>
   </next:Html>
</next:Panel>
<next:Panel id="bptApplyHistory" width="100%" height="100%" autoScroll="false" title="审批历史记录">
				<next:Html>
				    <iframe id="history" src="../../../jsp/cams/bpt/flow/disability/assessdisability/disabilityAppHistory.jsp?applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
   
	</next:TabPanel>
</next:Tabs>

</next:Panel>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="reguIdentiApp/reguIdentiAppPrintDao"/>
<input type="hidden" id="objectType" name="printQuery" queryData="queryData" value="" />
<input type="hidden" id="ntkoPrintapplyId" queryData="queryData"  value=""/>
<input type="hidden" id="printYear" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="printMonth" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="changeContent" name="printMark" printMark="printMark" value="" />
<input type="hidden"  id="docPath" printMark="printMark" value="" />
<input type="hidden" id="bptQueryPathServiceType" value=""/>

<%-- 
<input type="hidden" id="ntkoPrintapplyId" queryData="queryData"  value="<%=applyId%>"/>
--%>
</body>
<script>
var ifApplyActive = true;
function init() {
	setPanel(); 
	var approveTabPanel = L5.getCmp("approveTabPanel");
	approveTabPanel.setTitle('<%=actDefName%>');
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	DisabilityApproveDataset.setParameter("APPLY_ID",'<%=applyId%>');
	DisabilityApproveDataset.setParameter("serviceType",serviceType);
	DisabilityApproveDataset.load();
	var intoTable = L5.getCmp("intoTable");
	intoTable.on("activate",getApproveDoc);
	var uploadTabPanel = L5.getCmp("uploadTabPanel");
	uploadTabPanel.on("activate",setFrameUrl);
	var tabpanel = L5.getCmp("approveTabPanel");
	tabpanel.on("activate",setHide);
}

//获得退役军人伤残抚恤关系doc路径
function getApproveDoc(){
	document.getElementById("tableFrame").src = "../../../jsp/cams/bpt/flow/disability/veteransshift/print/disabilityInfoProvince_table.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
}


//设置环节域的隐藏
function setHide(approveTabPanel){
		if(ifApplyActive) {
		document.getElementById("TownVerifyFlag").disabled=true;
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=applyId%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
		
		var serviceType = '<%=serviceType%>';
		var peopleId = '<%=peopleId%>';
		if(serviceType=="11"){
			document.getElementById("adjust").style.display = "none";
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		} else if(serviceType=="12"){
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		} else if(serviceType=="13"){
			document.getElementById("adjust").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		} else if(serviceType=="14"){
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("adjust").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		} else if(serviceType=="18"){
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("adjust").style.display = "none";
		}
		
		//取得伤残性质和伤残等级
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
		command.setParameter("peopleId", peopleId);
		command.execute("queryByPeopleId");
		
		if(command.getReturn("disabilityCaseCode") !=undefined){
			disabilityCaseCode = command.getReturn("disabilityCaseCode");
		}
		if(command.getReturn("disabilityLevelCode") !=undefined){
			disabilityLevelCode = command.getReturn("disabilityLevelCode");
		}
	<%
	//遍历list1
	for(int i=0;i<list1.size();i++){
		Map map1=(Map)list1.get(i);
		fieldId=(String)map1.get("fieldId");
	 
		isHidden=(String)map1.get("isHidden");
		isReadOnly=(String)map1.get("isReadOnly");
		 
		//如果需要隐藏，则设置隐藏域的style为none
	%>
				var fieldId = '<%=fieldId%>';
				var isHidden = '<%=isHidden%>';
				var isReadOnly = '<%=isReadOnly%>';
			 	var target=document.getElementById("<%=fieldId%>");
				if(target){
					target.style.display="";
				}	
			 
			 	sip(DisabilityApproveDataset,fieldId,isHidden,isReadOnly);
				
			if(isHidden == "1") { // 判断是否为隐藏
				if(!ifback) { // 判断是否为退回操作
					var target=document.getElementById("<%=fieldId%>");
						if(target){
							target.style.display="none";
						}	
				} else {
					isReadOnly = "1";
				}				 		     
		} 
				if(isReadOnly == "1") {
				var target=document.getElementById("<%=fieldId%>");		
				if(target){
					var txts = target.getElementsByTagName("input");
					for(var i=0;i<txts.length;i++)
					{
					  	if(txts[i].type=="text"||txts[i].type=="textarea")
						{
						  txts[i].disabled=true;
						}
						
					}
					var txts = target.getElementsByTagName("textarea");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
					}
					var txts = target.getElementsByTagName("select");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
					}
				}		
						
				 
			}
	<%	
	}
	%>
		ifApplyActive = false;	
	}
}


//校验非空的域是否为空
function validateNotNull(record,ifback){
	<%
	for(int i=0;i<list1.size();i++){
		Map map1=(Map)list1.get(i);
		fieldId=(String)map1.get("fieldId");
		fieldName=(String)map1.get("fieldName");
		isNotNull=(String)map1.get("isNotNull");
		//如果限制为非空，未输入值点击按钮时弹出提示框
		if("1".equals(isNotNull)){
			%>
			var target=document.getElementById("<%=fieldId%>");
			currentField = "<%=fieldId%>";
			if(target){
				var inputs = target.getElementsByTagName("input"); // 验证input标签
				for(var i=0;i<inputs.length;i++) {
					 if(inputs[i].type=="text") {
					 	  var inputValue = inputs[i].value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(inputs[i].getAttribute("validateName")+"不能为空!");
						  	  return false;
						  }
						  if(inputs[i].getAttribute("validateName")=="时间"){
						  	if(!validateDateFormat(inputs[i].value)){
						  		alert("时间格式错误!");
						  	  return false;
						  	}
						  }
					 }
				}
				if(ifback != "back") {
				var selects = target.getElementsByTagName("select");// 验证select标签
				for(var i=0;i<selects.length;i++) {	
						  var selectObj = selects[i];
						  var validateName = selectObj.getAttribute("validateName");
						  if(validateName != null && validateName != "") {
						 	  var inputValue = selectObj.value;
							  if(inputValue == null || inputValue == "") {
							  	  alert(validateName+"不能为空!");
							  	  return false;
							  } else {
							  	  	 applyFlag = inputValue;
							  	  	 var typeCode = selectObj.getAttribute("validateType");
							  	  	 return validateSelect(typeCode,inputValue,record);
							  }
						  }	  
				}
				}
			}
			<%			
		}		
	}
	%>	
	return true;
}
</script>

</html>
