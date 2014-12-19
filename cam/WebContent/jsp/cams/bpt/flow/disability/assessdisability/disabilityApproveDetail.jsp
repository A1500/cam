<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@page import="java.util.HashMap" %>
<html>
	<head>
		<title>优抚_申请_伤残申请_审批编辑</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
				<script>
					<%
						String peopleId = request.getParameter("peopleId");
						String applyId = request.getParameter("applyId");
						String familyId = request.getParameter("familyId");
						String serviceType = request.getParameter("serviceType");
						
						String primaryKey=request.getParameter("primaryKey");
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
						List<Map> list1= wfQuery.getActFields(actDefUniqueId);
						
						Map actMap = wfQuery.getActivityDefInfoByActDefUniqueId(actDefUniqueId);
						String actDefName = (String)actMap.get("actDefName");
						//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
						//如果域是只读的则显示为只读
						//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
						String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
						//boolean isHidden,isReadOnly,isNotNull;
					%>
					var serviceType = '<%= serviceType%>';
					var processId = '<%= (String)request.getParameter("processId")%>';
					var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
					var assignmentId="<%=assignmentId%>";
					var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
				</script>
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
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/comm/disabilityTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>"
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
				    <iframe id="upload" src="../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId=<%=peopleId%>&serviceType=<%=serviceType%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="acceptTabPanel" title="受理通知书" height="100%">
				<next:Html>
					<iframe id="instanceaccept" src="../../../jsp/cams/bpt/flow/disability/assessdisability/acceptNoticeDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>

<next:Panel width="100%" id="introductTabPanel" title="介绍信" height="100%">
				<next:Html>
					<iframe id="instanceIntroduct" src="../../../jsp/cams/bpt/flow/disability/assessdisability/introductionLetterDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>

<next:Panel title="公示书" width="100%" height="100%"
				id="open_dis_appTabPanel" >
				<next:Html>
				  <iframe  id="openNotice" src="../../../jsp/cams/bpt/flow/disability/assessdisability/openDisabilitydetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>&serviceType=<%=serviceType%>"
					 	frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%" >
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel title="矽肺病鉴定体检表" width="100%" height="100%"
				id="physical" >
				<next:Html>
				  <iframe  id="physicalFrame" src="../../../jsp/cams/bpt/flow/disability/assessdisability/bptphysicalexamination/bptphysicalexamination_deatil.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
					 	frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%" >
	   				</iframe>
				</next:Html>
</next:Panel>

<next:Panel title="参试人员体检表" width="100%" height="100%"
				id="physicale">
				<next:Html>
				  <iframe id="physicaleFrame" src="../../../jsp/cams/bpt/flow/disability/assessdisability/bptexamination/bptexamination_deatil.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
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
<next:Panel title="审批信息" height="100%" width="100%" id="approveTabPanel" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="DisabilityApproveDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="0"  width="99%">
			<div>
				<table width="99%">
					<tr>
						<td class="FieldLabel" width="15%" align="right">姓名</td>
						<td class="FieldInput" width="15%"><label name="name" field="name"/></td>
						<td class="FieldLabel" width="15%">出生年月</td>
						<td class="FieldInput" width="15%"><label  name="birthday" field="birthday"/></td>
						<td class="FieldLabel" width="15%">类别</td>
						<td class="FieldInput" ><label  name="disabilityTypeCode" field="disabilityTypeCode" dataset="DisabilityTypeCodeEnum"/></td>
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
						<td class="FieldInput" ><label name="serviceType" field="serviceType"  dataset="ServiceTypeDataset"/></td>
						<td class="FieldLabel" >申请机构</td>
						<td class="FieldInput" colspan="3" ><label type="text" name="approveOrganId" field="approveOrganId"/></td>
					</tr>
					<tr id="adjust">
						<td colspan="6">
							<table width="100%">
								<tr>	
									<td class="FieldLabel" colspan="2" style="width:20%">调整伤残等级原因：</td>
									<td class="FieldInput" colspan="3"><label name="adjustReason" field="adjustReason" rows="3" style="width:90%"/></label></td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2">致残时间：</td>
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
						<td colspan="5">
							<table width="100%">
								<tr>
									<td class="FieldLabel" colspan="2" style="width:20%">换证、补证原因：</td>
									<td class="FieldInput" colspan="3"><label id="exchangeReason" name="exchangeReason" field="exchangeReason"></label></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr id="changecertidisa">
						<td colspan="5">
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
			</br>
			<div id="TownVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="4" nowrap="nowrap">县级审核</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><label  name="townAduitIncharge" field="townAduitIncharge" readonly="readonly" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label   name="townAduitApproveDate" field="townAduitApproveDate" readonly="readonly"  /> </td>
					</tr>
			   		<tr>
			   			<td  class="FieldLabel" >公示结果</td>
						<td class="FieldInput" colspan="3"><label    name="townAduitBulletinResult" field="townAduitBulletinResult" ></label> </td>
			   		</tr>
					
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
							<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审核意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;"  name="townFlag"  dataset="ApplyContent" field="townFlag" >
									</label>
								</td>
								<td class="FieldInput">
									<div id="TownVerifyPass" style="display:none">伤残性质：
										<label dataset="DisabilityCaseDataset" name="townAduitDisabilityNature" field="townAduitDisabilityNature">
										</label> 
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label  dataset="DisabilityLevelDataset" name="townAduitDisabilityLevel" field="townAduitDisabilityLevel">
										</label> 
									</div>
									<div id="TownVerifyEnd" disabled="disabled" style="display:none">
										是否上报：
										<label name="townReport" id="townReport"  dataset="ReportFlagEnum" field="townReport" >
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="townAduitAdvice" field="townAduitAdvice"></label>  
								</td>
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
			   			<td class="FieldLabel" rowspan="2" nowrap="nowrap">市级审核</td>
			   			<td class="FieldLabel" style="width:10%">负责人</td>
						<td class="FieldInput" style="width:30%"><label name="cityAduitIncharge" field="cityAduitIncharge"/></td>
						<td class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label name="cityAduitApproveDate" field="cityAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审核意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;" name="cityFlag" 
									 id="CityVerifyFlag" field="cityFlag" dataset="ApplyContent">
									</label>
								</td>
								<td class="FieldInput">
									<div id="CityVerifyPass" style="display:none">伤残性质： 
										<label dataset="DisabilityCaseDataset" name="cityAduitDisabilityNature"  field="cityAduitDisabilityNature">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label dataset="DisabilityLevelDataset" name="cityAduitDisabilityLevel"   field="cityAduitDisabilityLevel">
										</label>	
									</div>
									<div id="CityVerifyEnd"  style="display:none">
										是否上报：
										<label name="cityReport" id="cityReport" dataset="ReportFlagEnum" field="cityReport" >
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="cityAduitAdvice" field="cityAduitAdvice"></label>
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
						<td class="FieldLabel" rowspan="5" nowrap="nowrap">省级初审</td>			   			
			   			<td class="FieldLabel" nowrap="nowrap">受理人员</td>
						<td class="FieldInput" style="width:30%"><label name="provinceCheckPeopleId" field="provinceCheckPeopleId"/></td>
						
						<td class="FieldLabel" style="width:20%">受理时间</td>
						<td class="FieldInput" style="width:30%"><label name="provinceCheckDate" field="provinceCheckDate"/></td>
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
						<td  class="FieldLabel" nowrap="nowrap">简要残情</td>
						<td class="FieldInput" colspan="3">
							<label  name="briefDisability" field="briefDisability" ></label> 
						</td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">初审意见：
								</td>
								<td class="FieldInput"> 
									<label style="width:90px;"  name="proCheckFlag"  dataset="ApplyContent"
									id="ProvinceAcceptFlag" field="proCheckFlag" >
									</label>
								</td>
								<td class="FieldInput">
									<div id="ProvinceAcceptPass" style="display:none">伤残性质：
										<label name="provinceCheckDisNature" dataset="DisabilityCaseDataset"  field="provinceCheckDisNature">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label name="provinceCheckDisLevel" dataset="DisabilityLevelDataset" field="provinceCheckDisLevel">
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="provinceCheckAdvice" field="provinceCheckAdvice"></label> 
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</div>
				<br>
			<div id="ProvinceVerify" style="display:none">
				<table width="99%">
			   		<tr>
						<td class="FieldLabel" rowspan="2" nowrap="nowrap">省级复审</td>
						<td class="FieldLabel" style="width:10%">负责人</td>  
						<td class="FieldInput" style="width:30%"><label name="provinceAduitIncharge" field="provinceAduitIncharge"/></td>
						<td class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label name="provinceAduitApproveDate" field="provinceAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">复审意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;" name="proAduitFlag"  
									dataset="ApplyContent" id="ProvinceVerifyFlag" field="proAduitFlag" onchange="changeAppDiv('ProvinceVerify')">
									</label>
								</td>
								<td class="FieldInput">
									<div id="ProvinceVerifyPass" style="display:none">伤残性质：
										<label name="provinceAduitDisabilityNatu" dataset="DisabilityCaseDataset"  field="provinceAduitDisabilityNatu">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label name="provinceAduitDisabilityLeve" dataset="DisabilityLevelDataset" field="provinceAduitDisabilityLeve">
										</label>	
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="provinceAduitAdvice" field="provinceAduitAdvice"></label>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</div>
				<br>
			<div id="ProvinceApprove" style="display:none">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel"  rowspan="3" nowrap="nowrap">省级审批</td>
			   			<td class="FieldLabel" style="width:10%">负责人</td>
						<td class="FieldInput" style="width:30%"><label name="provinceIncharge" field="provinceIncharge"/></td>
						
						<td class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label name="provinceApproveDate" field="provinceApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;" name="proFlag"  
									 id="proFlag" field="proFlag"  dataset="ApplyContent">
									</label>
								</td>
								<td class="FieldInput">
									<div id="ProvinceApprovePass" style="display:none">伤残性质：
										<label name="provinceVerifyDisabilityNat" dataset="DisabilityCaseDataset"  field="provinceVerifyDisabilityNat">
										</label>
										&nbsp;&nbsp;&nbsp;
										审批等级：
										<label name="provinceLevel" dataset="DisabilityLevelDataset"  field="provinceLevel">
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="provinceAdvice" field="provinceAdvice"></label>
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
<next:Panel title="审批表" width="100%" height="100%"
				id="ass_dis_appTabPanel" >
				<next:Html>
				  <iframe  id="apptable" src=""
					 	frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%" >
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel title="不予评定决定书" width="100%" height="100%"
				id="decisionLetterTabPanel">
				<next:Html>
				  <iframe id="decisionTabPanel" src="../../../jsp/cams/bpt/flow/disability/assessdisability/decisionLetterDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
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
</body>
<script>
var updateFlag = true;
var applyFlag = true;
var updateUrl = "../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>&serviceType=";
function init() {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPhysicalExaminationCommand");
	command.setParameter("peopleId",'<%=peopleId%>');
	command.setParameter("applyId",'<%=applyId%>');
	command.execute("queryIsNull");
	var flag= command.getReturn("flag");
	if(!flag){
		var physical = L5.getCmp("physical");
		var allPanel = L5.getCmp("allPanel");
		allPanel.remove(physical);
	}else{
		var physical = L5.getCmp("physical");
		physical.on("activate",function() {
			var obj = document.getElementById("physicalFrame");
			obj.src=obj.src;
		});
	}
	//如果是调残，不显示参试人员体检表
	var physicale = L5.getCmp("physicale");
	if(serviceType=="12"){
		var allPanel = L5.getCmp("allPanel");
		allPanel.remove(physicale);
		var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel");
		decisionLetterTabPanel.setTitle("不予调整决定书");
	}else{
		physicale.on("activate",function() {
			var obj = document.getElementById("physicaleFrame");
			obj.src=obj.src;
		});
	}
	setPanel();
	var approveTabPanel = L5.getCmp("approveTabPanel");
	approveTabPanel.setTitle('<%=actDefName%>');
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	DisabilityApproveDataset.setParameter("APPLY_ID",'<%=applyId%>');
	DisabilityApproveDataset.load();
	
	var uploadTabPanel = L5.getCmp("uploadTabPanel");
	uploadTabPanel.on("activate",setFrameUrl);
	
	var tabpanel = L5.getCmp("approveTabPanel");
	tabpanel.on("activate",setHide);
	var open_dis_appTabPanel = L5.getCmp("open_dis_appTabPanel");
	open_dis_appTabPanel.on("activate",setSrc);
	
	var acceptTabPanel = L5.getCmp("acceptTabPanel");
	acceptTabPanel.on("activate",function () {
		var obj = document.getElementById("instanceaccept");
		obj.src=obj.src;
	});
	
	var introductTabPanel = L5.getCmp("introductTabPanel");
	introductTabPanel.on("activate",function() {
		var obj = document.getElementById("instanceIntroduct");
		obj.src=obj.src;
	});
	
	var open_dis_appTabPanel = L5.getCmp("open_dis_appTabPanel");
	open_dis_appTabPanel.on("activate",function() {
		var obj = document.getElementById("openNotice");
		obj.src=obj.src;
	});
	
	
	
	var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel");
	decisionLetterTabPanel.on("activate",function() {
		var obj = document.getElementById("decisionTabPanel");
		obj.src=obj.src;
	});
	
	var approveTabDocPanel = L5.getCmp("ass_dis_appTabPanel");
	approveTabDocPanel.on("activate",setApptable);
	
	
	
	L5.QuickTips.init(); 
}

//判断是评残还是调残选取不同的打印模板
function setApptable(){
	if(serviceType=="11"){
		document.getElementById("apptable").src="../../../jsp/cams/bpt/flow/disability/assessdisability/print/ass_disability_apptable.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
	}else if(serviceType=="12"){
		//document.getElementById("decisionTabPanel").src="";
		document.getElementById("apptable").src="../../../jsp/cams/bpt/flow/disability/adjustdisability/adjustPrintDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
	}
}

var first= "true";

function setSrc() {
	if(first){
		if(serviceType=="12"){
		document.getElementById("openNotice").src="../../../jsp/cams/bpt/flow/disability/assessdisability/openDisabilitydetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>&adjust=adjust&serviceType=<%=serviceType%>";
		}
	}
	first = "false";
}
function sipApplyFlag() {
		var townFlag = DisabilityApproveDataset.get("townFlag");//县级
		
		if(townFlag != null && townFlag != "") {
			if(townFlag == 0) {
				document.getElementById("TownVerifyPass").style.display="";
			} else if(townFlag == 1) {
				document.getElementById("TownVerifyEnd").style.display="";
			}
		}	
		
		var cityFlag = DisabilityApproveDataset.get("cityFlag");//市级
		if(cityFlag != null && cityFlag != "") {
			if(cityFlag == 0) {
				document.getElementById("CityVerifyPass").style.display="";
			} else if(cityFlag == 1) {
				document.getElementById("CityVerifyEnd").style.display="";
			}else if(cityFlag == 2) {
				document.getElementById("CityVerifyPass").style.display="";
			}
		}
		
		var proCheckFlag = DisabilityApproveDataset.get("proCheckFlag");//省级初审
		if(proCheckFlag != null && proCheckFlag != "") {
			if(proCheckFlag == 0) {
				document.getElementById("ProvinceAcceptPass").style.display="";
			}else if(proCheckFlag == 2) {
				document.getElementById("ProvinceAcceptPass").style.display="";
			}  
		}
			
		var proAduitFlag = DisabilityApproveDataset.get("proAduitFlag");//省级复审
		
		if(proAduitFlag != null && proAduitFlag != "") {
			if(proAduitFlag == 0) {
				document.getElementById("ProvinceVerifyPass").style.display="";
			}else if(proAduitFlag == 2) {
				document.getElementById("ProvinceVerifyPass").style.display="";
			}   
		}	
		
		var proFlag = DisabilityApproveDataset.get("proFlag");//省级审批
		
		if(proFlag != null && proFlag != "") {
			if(proFlag == 0) {
				document.getElementById("ProvinceApprovePass").style.display="";
			}else if(proFlag == 2) {
				document.getElementById("ProvinceApprovePass").style.display="";
			}
		}	
	
	}   

function setFrameUrl() {
	if(updateFlag) {
		document.getElementById("upload").src=updateUrl;
		updateFlag = false;
	}
}


function setPanel() {
	var serviceType = '<%=serviceType%>';
	updateUrl +=serviceType;
	var allPanel = L5.getCmp("allPanel");
	var ass_dis_appTabPanel = L5.getCmp("ass_dis_appTabPanel");
	var introductTabPanel = L5.getCmp("introductTabPanel");
	var acceptTabPanel = L5.getCmp("acceptTabPanel");
	var open_dis_appTabPanel = L5.getCmp("open_dis_appTabPanel");
	var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel");
	var exchaTable = L5.getCmp("exchaTable");
	var changeTable = L5.getCmp("changeTable");
	var intoTable = L5.getCmp("intoTable");
	
	if(serviceType=="11" || serviceType=="12"){
		allPanel.remove(exchaTable);
		allPanel.remove(changeTable);
		allPanel.remove(intoTable);
	}else {
		allPanel.remove(ass_dis_appTabPanel);
		allPanel.remove(introductTabPanel);
		allPanel.remove(acceptTabPanel);
		allPanel.remove(open_dis_appTabPanel);
		allPanel.remove(decisionLetterTabPanel);
		if(serviceType=="13"){
			  allPanel.remove(changeTable);
			  allPanel.remove(intoTable);
		}else if(serviceType=="14"){
			  allPanel.remove(exchaTable);
			  allPanel.remove(changeTable);
		}else if(serviceType=="18"){
			  allPanel.remove(exchaTable);
			  allPanel.remove(intoTable);
		}
	}	
}


//设置环节域的隐藏
function setHide(approveTabPanel){
		if(applyFlag) {
		sipApplyFlag();
		var records = DisabilityApproveDataset.getAllRecords();
		var serviceType = records[0].get("serviceType");
		var peopleId = records[0].get("peopleId");
		if(serviceType=="11"){
			document.getElementById("adjust").style.display = "none";
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		}
		if(serviceType=="12"){
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		}
		if(serviceType=="13"){
			document.getElementById("adjust").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		}
		if(serviceType=="14"){
			document.getElementById("adjust").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		}
		if(serviceType=="18"){
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("adjust").style.display = "none";
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
		<% if("1".equals(isHidden)){
			%>
			var target=document.getElementById("<%=fieldId%>");
			if(target){
				target.style.display="none";
				}
			<%			
		}else{
			//不隐藏时，如果是只读
			if("1".equals(isReadOnly)){
				//设置为只读
				%>
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
					var txts = target.getElementsByTagName("img");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
					}
				}		
				<%
			}
		}
	}
	%>
	  applyFlag=false;	
	}
}
</script>
</html>
