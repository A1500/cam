<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<html> 
	<head>
		<title>伤残人员换证补证办理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="../../../jsp/cams/bpt/comm/bptComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
		
				<script>
				var  fieldId1;
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
					var serviceType = '<%=serviceType%>';
					var peopleId = '<%= peopleId%>';
					var processId = '<%= (String)request.getParameter("processId")%>';
					var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
					var assignmentId="<%=assignmentId%>";
					var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
					var command1 = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
					command1.setParameter("peopleId", peopleId);
					command1.execute("getObjecttypeByPeopleId");
					var objectTypeCode = command1.getReturn("objectType");
				</script>
		</head>
<body>
<model:datasets>
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="query" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability"></model:record>
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
	<!-- 取消待遇标志 -->
	<model:dataset id="CancelTreateFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
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
		<next:Panel id="exchaTable" width="100%" height="100%" autoScroll="false" title="换证、补证或证件变更信息">
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
						<td class="FieldLabel" style="width:20.5%">申请机构</td>
						<td class="FieldInput" colspan="3"><label type="text" name="approveOrganId" field="approveOrganId"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:20.5%">换证、补证或证件变更原因：</td>
						<td class="FieldInput" colspan="3"><label id="exchangeReason" name="exchangeReason" field="exchangeReason"></label></td>
					</tr>
					<tr id="adjust">
						<td colspan="5">
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
					</tr>
					<tr id="changecertidisa">
						<td colspan="5">
							<table width="100%">
								
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
			   			<td  class="FieldLabel" style="width:10%">负责人</td>
						<td class="FieldInput" style="width:30%"><input disabled="disabled" type="text" name="townAduitIncharge" field="townAduitIncharge" readonly="readonly" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input disabled="disabled" type="text" name="townAduitApproveDate" field="townAduitApproveDate" readonly="readonly"  /> </td>
					</tr>
					
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3"><textarea  disabled="disabled" name="townAduitAdvice" field="townAduitAdvice" style="width:80%" rows="2"></textarea> </td>
					</tr>
				</table>
			</div>
			</br>
			<div id="CityVerify" style="display:none">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="3" nowrap="nowrap">市级审核</td>
			   			<td  class="FieldLabel" style="width:10%">负责人</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="市级审核" name="cityAduitIncharge" field="cityAduitIncharge" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="时间"format="Y-m-d" style="width: 100px; name="cityAduitApproveDate" field="cityAduitApproveDate"  onpropertychange="changeDateStyle(this)"  /><img  src="../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
					
			   		<tr>
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3"><textarea type="text" name="cityAduitAdvice" field="cityAduitAdvice" style="width:80%" rows="2"></textarea> </td>
					</tr>
				</table>
			</div>
				<br>
			<div id="ProvinceAccept" style="display:none">
				<table width="99%">
					<tr>
						<td  class="FieldLabel"  rowspan="8" nowrap="nowrap">省级审批</td>
						<td  class="FieldLabel" nowrap="nowrap">假证(取消待遇)</td>	
						<td  class="FieldInput" nowrap="nowrap" colspan="3">
							   <select id="cancelTreateFlag" name="cancelTreateFlag" field="cancelTreateFlag" title="取消待遇标志" onblur="cancelTreate(this.value)">
								   <option dataset="CancelTreateFlagEnum"></option>
							   </select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">业务类型</td>
						<td class="FieldInput" colspan="3" style="width:100%">
							<select id="serviceType" name="certType" field="certType" validateName="业务类型" onchange="changeType(this.value)" >
								 <option selected="selected">--请选择--</option>
								 <option value="13">换证补证业务</option>
								 <option value="18">证件变更业务</option>
		   					</select>
						</td>
					</tr>
					<tr id="disabilityNoTr">
						<td  class="FieldLabel" nowrap="nowrap">原优抚证书编号</td>	
								<td  class="FieldInput" nowrap="nowrap" >
									 <label id="oldDisabilityNo" name="oldDisabilityNo" field="oldDisabilityNo" validateName="原优抚证书编号"/>
						</td>	
						<td  class="FieldLabel" nowrap="nowrap">新优抚证书编号</td>	
								<td  class="FieldInput" nowrap="nowrap" >
									 <label id="newDisabilityNo" name="newDisabilityNo" field="newDisabilityNo" validateName="新优抚证书编号"/>
						</td>
					</tr>
					<tr id="changeContentTr" >
						<td  class="FieldLabel" nowrap="nowrap">变更内容</td>	
						<td  class="FieldInput" nowrap="nowrap" colspan="3">
							 <textarea type="text" id="changeContentArea" name="changeContent" field="changeContent" readonly="readonly" style="width:80%" rows="2"></textarea>
						</td>
					</tr>
					<tr id="changeContentTr1" >
					<td  class="FieldLabel" nowrap="nowrap">变更项</td>
					<td colspan="3" class="FieldInput">
						<table  style="width:100%">
							<tr >
								<td  class="FieldLabel" nowrap="nowrap">身份证号</td>
								<td  class="FieldInput" nowrap="nowrap">
									 <input type="text" id="oldIdCard" name="oldIdCard" field="oldIdCard" style="width:155" maxlength="18" disabled="disabled" validateName="原身份证号"/>
								</td>
								<td  class="FieldLabel" nowrap="nowrap">姓名</td>	
								<td  class="FieldInput" nowrap="nowrap">
									 <input type="text" id="oldName" name="oldName" field="oldName" disabled="disabled" validateName="原姓名"/>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="changeContentTr2" >
					<td  class="FieldLabel" nowrap="nowrap">变更为</td>	
					<td colspan="3" class="FieldInput">
						<table style="width:100%">
							<tr >
								<td  class="FieldLabel" nowrap="nowrap">身份证号</td>
								<td  class="FieldInput" nowrap="nowrap">
									 <input type="text" id="newIdCard" name="newIdCard" field="newIdCard" style="width:155" maxlength="18"  validateName="新身份证号"/>
								</td>
								<td  class="FieldLabel" nowrap="nowrap">姓名</td>	
								<td  class="FieldInput" nowrap="nowrap">
									 <input type="text" id="newName" name="newName" field="newName"  validateName="新姓名"/>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					
						<tr>
			   			<td  class="FieldLabel" style="width:10%" nowrap="nowrap">审核人员</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="受理人员" name="provinceCheckPeopleId" field="provinceCheckPeopleId" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="时间" format="Y-m-d" style="width: 100px; name="provinceCheckDate" field="provinceCheckDate"  onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
					
			   		<tr>
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3"><textarea type="text" name="provinceCheckAdvice" field="provinceCheckAdvice" style="width:80%" rows="2"></textarea> </td>
					</tr>
					
				</table>
			</div>
			
				<br>
				
			<div id="ProvinceVerify" style="display:none">
				<table width="99%">
			   		<tr>
						<td  class="FieldLabel" rowspan="3" nowrap="nowrap">省厅审核</td>
						<td  class="FieldLabel" >负责人</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="负责人" name="provinceAduitIncharge" field="provinceAduitIncharge" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="时间" format="Y-m-d" style="width: 100px; name="provinceAduitApproveDate" field="provinceAduitApproveDate" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
			   		<tr>
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3"><textarea type="text" name="provinceAduitAdvice" field="provinceAduitAdvice" style="width:80%" rows="2"></textarea> </td>
					</tr>
				</table>
			</div>
				<br>
			<div id="ProvinceApprove" style="display:none">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel"  rowspan="3" nowrap="nowrap">省厅审批</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="负责人" name="provinceIncharge" field="provinceIncharge" /> </td>
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input type="text" validateName="时间" format="Y-m-d" style="width: 100px; name="provinceApproveDate" field="provinceApproveDate"  onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
					
			   		<tr>
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3"><textarea type="text" name="provinceAdvice" field="provinceAdvice" style="width:80%" rows="2"></textarea> </td>
					</tr>
				</table>
			</div>
		</table>
		</form>
   </next:Html>
</next:Panel>
	<next:Panel id="bptApplyHistory" width="100%" height="100%" autoScroll="false" title="审批历史记录">
				<next:Html>
				    <iframe id="history" src="../../../jsp/cams/bpt/flow/disability/assessdisability/disabilityCert_FlowAppHistory.jsp?applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
   
	</next:TabPanel>
</next:Tabs>
</next:Panel>

<input type="hidden"  id="docPath" printMark="printMark" value="" />
<input type="hidden" id="changeContent" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="printYear" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="printMonth" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="bptQueryPathServiceType" value=""/>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="reguIdentiApp/reguIdentiAppPrintDao"/>
<input type="hidden" id="objectType" name="printQuery" queryData="queryData" value="" />
</body>
<script>

var disabilityCaseCode,disabilityLevelCode;
var currentDate = getCurDate();
var updateFlag = true;
var updateUrl = "../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>&serviceType=";
var record_disabilityCaseCode="";
var record_disabilityLevelCode="";

function cancelTreate(treateFalg){
	if(treateFalg=='1'){
		document.getElementById("serviceType").disabled= "disabled";
	}else{
		document.getElementById("serviceType").disabled= "";
	}
}

function updateInfo() { // 若流程为第一环节则可修改
	var width = screen.width-100;
    var height = screen.height-140;
	var url = L5.webPath+"/jsp/cams/bpt/flow/disability/exchacertidisa/exchaCertiDisaUpdate.jsp?peopleId=<%=peopleId%>&familyId=<%=familyId%>&applyId=<%=applyId%>";
	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.location.reload();
}
function init() {
	// 换证补证重复打开
	L5.getCmp("exchaTable").on("activate",function(){
		var exchaTabSrc = document.getElementById("exchaTab").src;
		document.getElementById("exchaTab").src = exchaTabSrc;
	});
	setPanel(); 
	var approveTabPanel = L5.getCmp("approveTabPanel");
	approveTabPanel.setTitle('<%=actDefName%>');
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	DisabilityApproveDataset.setParameter("APPLY_ID",'<%=applyId%>');
	DisabilityApproveDataset.setParameter("serviceType",'<%=serviceType%>');
	DisabilityApproveDataset.load();
	DisabilityApproveDataset.on("load",function(){
		var cancelTreateFlag = DisabilityApproveDataset.get("cancelTreateFlag");
		if(cancelTreateFlag==""){
			DisabilityApproveDataset.set("cancelTreateFlag","0")
		}
	});
	var uploadTabPanel = L5.getCmp("uploadTabPanel");
	uploadTabPanel.on("activate",setFrameUrl);
	
	var tabpanel = L5.getCmp("approveTabPanel");
	tabpanel.on("activate",setHide);
	
	L5.QuickTips.init(); 
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

// 省级审批证件变更打证  
function print() {
	var url;
	var docpath;
	var cancelTreateFlag = document.getElementById("cancelTreateFlag").value;
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	var certType = DisabilityApproveRecord.get("certType");
	if(cancelTreateFlag=="1"){
		L5.Msg.alert('提示',"是假证，不能打印！");
		return false;
	}
	var getValue = window.showModalDialog('../../../jsp/cams/bpt/flow/disability/assessdisability/selectLeftOrRightPrint.jsp', 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
	if(getValue!=""&&getValue!=undefined){
		var list = getValue.split(";");
		typeFlag = list[0];
		flag = list[1];
		var changedContent = decodeURI(list[2]);
		if(certType=="13"&&typeFlag!="13"){
			L5.Msg.alert("提示","打印类型请选择‘打证’！");
			return false;
		}
		if(certType=="18"&&typeFlag!="18"){
			L5.Msg.alert("提示","打印类型请选择‘变更’！");
			return false;
		}
		//打证
		if(certType=="13"&&typeFlag=="13"){
			var oldDisabilityNo = DisabilityApproveRecord.get("oldDisabilityNo");
			var newDisabilityNo = DisabilityApproveRecord.get("newDisabilityNo");
			if(newDisabilityNo==""||newDisabilityNo==oldDisabilityNo){
				L5.Msg.alert("提示","未保存，请先保存后再打印！");
				return false;
			}
			if(objectTypeCode == '11'){//残疾军人
				docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
			}else if(objectTypeCode == '12'){//伤残国家机关工作人员
				docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityGZ_apptable.doc";
			}else if(objectTypeCode == '13'){//伤残人民警察
				docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJC_apptable.doc";
			}else if(objectTypeCode == '14'){//伤残民兵民工
				docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
			}else if(objectTypeCode == '15'){//因战因公伤残人员
				docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
			}
			document.getElementById("peopleId").value=peopleId;
			document.getElementById("objectType").value=objectTypeCode;
			document.getElementById("bptQueryPathServiceType").value=objectTypeCode;
			url="../../../jsp/cams/comm/print/jspcommonprint.jsp?";
		}
		//证件变更打印
		if(certType=="18"&&typeFlag=="18"){
			document.getElementById("changeContent").value = changedContent;
			document.getElementById("changeContentArea").value = changedContent;
			var content = document.getElementById("changeContentArea").value;
			if(content == null || content == "") {
				L5.Msg.alert("提示","请填写变更内容");
				return false;
			}
			var path;
			if(flag == "0") { //左边栏
				docpath = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
				document.getElementById("bptQueryPathServiceType").value ="71";
			} else  if(flag == "1") { //右边栏
				docpath = "jsp/cams/bpt/flow/disability/exchacertidisa/print/right.doc";
				document.getElementById("bptQueryPathServiceType").value ="70";
			}
			var date=new Date();
			var year=""+date.getFullYear();
			var month=date.getMonth()+1;
			if(month<10){month="0"+month;}
			document.getElementById("printYear").value = year;
			document.getElementById("printMonth").value = month;
			url ="../../../jsp/cams/comm/print/print_noDataSet.jsp";
		}
		document.getElementById("docPath").value = docpath;
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	} else{
		return;
}

}
function save(){
	if(validateNotNull()) {
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
		
		var certType = DisabilityApproveRecord.get("certType");
	
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
		command.setParameter("record", DisabilityApproveRecord);
		if(record_disabilityCaseCode != "") {
	  		command.setParameter("disabilityCaseCode",record_disabilityCaseCode);
	   }
	   if(record_disabilityLevelCode != "") {
	  		command.setParameter("disabilityLevelCode",record_disabilityLevelCode);
	   }
		command.execute("update");
		if (!command.error) {
		   if(certType=='13'){
			   var newDisabilityNoRt = command.getReturn("newDisabilityNo");
			   DisabilityApproveDataset.set("newDisabilityNo",newDisabilityNoRt);
		   }
			DisabilityApproveDataset.reload();
			L5.Msg.alert('提示',"数据保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
}

//设置环节域的隐藏
function setHide(approveTabPanel){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=applyId%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
		
		var records = DisabilityApproveDataset.getAllRecords();
		var serviceType = records[0].get("serviceType");
		var peopleId = records[0].get("peopleId");
		if(serviceType=="11"){
			document.getElementById("adjust").style.display = "none";
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		} else if(serviceType=="12"){
			document.getElementById("exchacerti").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		} else if(serviceType=="13"||serviceType=="18"){
			document.getElementById("adjust").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		} else if(serviceType=="14"){
			document.getElementById("adjust").style.display = "none";
			document.getElementById("changecertidisa").style.display = "none";
		} //else if(serviceType=="18"){
		 //document.getElementById("exchacerti").style.display = "none";
			//document.getElementById("adjust").style.display = "none";
		//}
		
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
}

// 设置默认值
function sip(DisabilityApproveDataset,fieldId,isHidden,isReadOnly) {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=applyId%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
				//市级审核
				if(fieldId=="CityVerify"&&isHidden=="0"&&isReadOnly=="0"){
					var cityAduitApproveDate = DisabilityApproveDataset.get("cityAduitApproveDate");
					if(ifback){
						DisabilityApproveDataset.set("cityAduitApproveDate",currentDate);
					}else if(cityAduitApproveDate == "" || cityAduitApproveDate == null) {
						DisabilityApproveDataset.set("cityAduitApproveDate",currentDate);
					}	
					
					var cityAduitIncharge = DisabilityApproveDataset.get("cityAduitIncharge");
					if(cityAduitIncharge == "" || cityAduitIncharge == null) {
						DisabilityApproveDataset.set("cityAduitIncharge",currentUserName);
					}
					var cityAduitDisabilityNature = DisabilityApproveDataset.get("cityAduitDisabilityNature");
					if(cityAduitDisabilityNature == "" || cityAduitDisabilityNature == null) {
						DisabilityApproveDataset.set("cityAduitDisabilityNature",disabilityCaseCode);
					}
					var cityAduitDisabilityLevel = DisabilityApproveDataset.get("cityAduitDisabilityLevel");
					if(cityAduitDisabilityLevel == "" || cityAduitDisabilityLevel == null) {
						DisabilityApproveDataset.set("cityAduitDisabilityLevel",disabilityLevelCode);
					}	
				}
				//省级受理
				if(fieldId=="ProvinceAccept"&&isHidden=="0"&&isReadOnly=="0"){
					var provinceCheckDate = DisabilityApproveDataset.get("provinceCheckDate");
					if(ifback){
						DisabilityApproveDataset.set("provinceCheckDate",currentDate);
					}else if(provinceCheckDate == "" ||  provinceCheckDate == null ) {
						DisabilityApproveDataset.set("provinceCheckDate",currentDate);
					}
					var provinceCheckPeopleId = DisabilityApproveDataset.get("provinceCheckPeopleId");
					if(provinceCheckPeopleId == "" || provinceCheckPeopleId == null) {
						DisabilityApproveDataset.set("provinceCheckPeopleId",currentUserName);
					}	
					var provinceCheckDisNature = DisabilityApproveDataset.get("provinceCheckDisNature");
					if(provinceCheckDisNature == "" || provinceCheckDisNature == null) {
						DisabilityApproveDataset.set("provinceCheckDisNature",disabilityCaseCode);
					}	
					var provinceCheckDisLevel = DisabilityApproveDataset.get("provinceCheckDisLevel");
					if(provinceCheckDisLevel == "" || provinceCheckDisLevel == null) {
						DisabilityApproveDataset.set("provinceCheckDisLevel",disabilityLevelCode);
					}	
					
				}
				//省厅审核
				if(fieldId=="ProvinceVerify"&&isHidden=="0"&&isReadOnly=="0"){
					var provinceAduitApproveDate = DisabilityApproveDataset.get("provinceAduitApproveDate");
					if(ifback){
						DisabilityApproveDataset.set("provinceAduitApproveDate",currentDate);
					}else if(provinceAduitApproveDate == "" || provinceAduitApproveDate == null) {
						DisabilityApproveDataset.set("provinceAduitApproveDate",currentDate);
					}	
					
					var provinceAduitIncharge = DisabilityApproveDataset.get("provinceAduitIncharge");
					if(provinceAduitIncharge == "" || provinceAduitIncharge == null) {
						DisabilityApproveDataset.set("provinceAduitIncharge",currentUserName);
					}	
					
					var provinceAduitDisabilityNatu = DisabilityApproveDataset.get("provinceAduitDisabilityNatu");
					if(provinceAduitDisabilityNatu == "" || provinceAduitDisabilityNatu == null) {
						DisabilityApproveDataset.set("provinceAduitDisabilityNatu",disabilityCaseCode);
					}	
					
					var provinceAduitDisabilityLeve = DisabilityApproveDataset.get("provinceAduitDisabilityLeve");
					if(provinceAduitDisabilityLeve == "" || provinceAduitDisabilityLeve == null) {
						DisabilityApproveDataset.set("provinceAduitDisabilityLeve",disabilityLevelCode);
					}	
					
				}
				//省厅审批
				if(fieldId=="ProvinceApprove"&&isHidden=="0"&&isReadOnly=="0"){
					var provinceApproveDate = DisabilityApproveDataset.get("provinceApproveDate");
					if(provinceApproveDate == "" || provinceApproveDate == null) {
						DisabilityApproveDataset.set("provinceApproveDate",currentDate);
					}	
					
					var provinceIncharge = DisabilityApproveDataset.get("provinceIncharge");
					if(provinceIncharge == "" || provinceIncharge == null) {
						DisabilityApproveDataset.set("provinceIncharge",currentUserName);
					}	
					
					var provinceVerifyDisabilityNat = DisabilityApproveDataset.get("provinceVerifyDisabilityNat");
					if(provinceVerifyDisabilityNat == "" || provinceVerifyDisabilityNat == null) {
						DisabilityApproveDataset.set("provinceVerifyDisabilityNat",disabilityCaseCode);
					}	
					
					var provinceLevel = DisabilityApproveDataset.get("provinceLevel");
					if(provinceLevel == "" || provinceLevel == null) {
						DisabilityApproveDataset.set("provinceLevel",disabilityLevelCode);
					}	
					
				}
}


//发送流程
function send(){
	
	if(DisabilityApproveDataset.get("oldDisabilityNo")!=DisabilityApproveDataset.get("newDisabilityNo")
			&&DisabilityApproveDataset.get("newDisabilityNo")!=''&&DisabilityApproveDataset.get("newDisabilityNo")!=null){
		
	}else {
		save();
	}
	
	if(validateNotNull()){
	  if(checkProcessState("send")){
	   var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	   //执行发送流程方法
	   command.setParameter("applyId",'<%=applyId%>');
	   command.setParameter("serviceType",DisabilityApproveDataset.get("serviceType"));
	   command.setParameter("peopleId",DisabilityApproveDataset.get("peopleId"));
	   command.setParameter("condition","pass");
	   command.setParameter("actDefName",'<%=actDefName%>');
	   command.setParameter("currentField",fieldId1);
	   command.setParameter("record", DisabilityApproveRecord);
	   command.setParameter("newDisabilityNo", DisabilityApproveDataset.get("newDisabilityNo"));
	   if(record_disabilityCaseCode != "") {
	  		command.setParameter("disabilityCaseCode",record_disabilityCaseCode);
	   }
	   if(record_disabilityLevelCode != "") {
	  		command.setParameter("disabilityLevelCode",record_disabilityLevelCode);
	   }
	   command.execute("changeCertSend");
	   if(!command.error){
		   alert("成功发送到下一环节!");	
		   window.close();
		   window.returnValue = "success";		  
		   //跳转到已办任务页面
		   //var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		   //L5.forward(url,"已办任务页面");
	   }else{
	      alert(command.error);
	  }
	 }
	}
}

function end() { //不予认定并结束
     var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
	command.setParameter("applyId",'<%=applyId%>');
	command.execute("ifHave");
	var flag = command.getReturn("ifhave");
	if(!flag) {
		L5.Msg.alert("提示","请填写不予评定决定书");
		return false;
	}
	 var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	   //执行发送流程方法
	   command.setParameter("serviceType",DisabilityApproveDataset.get("serviceType"));
	   command.setParameter("peopleId",DisabilityApproveDataset.get("peopleId"));
	   command.setParameter("condition","end");
	   command.setParameter("actDefName",'<%=actDefName%>');
	   command.setParameter("currentField",fieldId1);
	   command.setParameter("applyId",'<%=applyId%>');
	   command.setParameter("record", DisabilityApproveRecord);
	   command.execute("send");
	   if(!command.error){
		   alert("成功发送到下一环节!");
		   window.close();
		   window.returnValue = "success";			  
		   //跳转到已办任务页面 
		   //var url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
		   //L5.forward(url,"已办任务页面");
	   }else{
	      alert(command.error);
	  }
}


//查看流转状态图
function showState(){
	 var url = L5.webPath+"/jsp/workflow/monitor/flowview.jsp?procDefUniqueId="
	      +procDefUniqueId+"&assignmentId="+assignmentId+"&isShowBackBtn=false";
	 showModalDialog(url, window,
	 	"scroll:yes;resizable:yes;dialogWidth:900px;dialogHeight:600px");	  	 
}
//回退流程
function back(){
	if(validateNotNull()){
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	   //执行发送流程方法
	   command.setParameter("applyId",'<%=applyId%>');
	   command.setParameter("record", DisabilityApproveRecord);
	   command.setParameter("actDefName",'<%=actDefName%>');
	   command.setParameter("currentField",fieldId1);
	   command.execute("back");
	   if(!command.error){
		   alert("成功回退流程!");
		   window.close();
		   window.returnValue = "success";			  
		   //跳转到已办任务页面
		   //var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		   //L5.forward(url,"已办任务页面");
	   }else{
	      alert(command.error);
	   }
	 } 
}



//校验非空的域是否为空
function validateNotNull(){
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
			fieldId1 =  '<%=fieldId%>';
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
						  if(inputs[i].getAttribute("validateName")=="原身份证号"){
						  	if(!checkIDCard(inputs[i])){
							    L5.Msg.alert("提示", "原身份证格式不正确!");
							    return false;
							}
						  }
						  if(inputs[i].getAttribute("validateName")=="新身份证号"){
						  	if(!checkIDCard(inputs[i])){
							    L5.Msg.alert("提示", "新身份证格式不正确!");
							    return false;
							}
						  }
					 }
				}
				var selects = target.getElementsByTagName("select");// 验证select标签
				for(var i=0;i<selects.length;i++) {	
					 	  var inputValue = selects[i].value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(selects[i].getAttribute("validateName")+"不能为空!");
						  	  return false;
						  } else {
						  	 if(selects[i].getAttribute("validateType") == "disabilityLevelCode") {
						  	 	record_disabilityLevelCode = selects[i].value;
						  	 } else if(selects[i].getAttribute("validateType") == "disabilityCaseCode") {
						  	 	record_disabilityCaseCode = selects[i].value;
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

//检查流程状态
function checkProcessState(method){
	var urlDataString=document.URL.split("?")[1];
	var dataArr=urlDataString.split("&");
	var hasAssignmentId=false;
	for(i=0;i<dataArr.length;i++)
	{
		var data=dataArr[i].split("=");
		if(data[0]=="assignmentId")
		{
			if(method=="create"||method=="createAndSend")
			{
				alert("该流程已经创建！");
				return false;
			}
			hasAssignmentId=true;
		}
	}
	if(!hasAssignmentId)
	{
		if(method!="create"&&method!="createAndSend")
		{
			alert("该流程还没有创建！请先创建流程！");
			return false;
		}
	}
	return true;
}

//获得当前日期 
function getCurDate(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	var day = date.getDate();
	if(day<10){day = "0"+day;}
	return year+"-"+month+"-"+day;
}


//如选
function changeType(value) {  
	var disabilityNoTr = document.getElementById("disabilityNoTr");
	var changeContent = document.getElementById("changeContentTr");
	var changeContent1 = document.getElementById("changeContentTr1");
	var changeContent2 = document.getElementById("changeContentTr2");
	if(value == "18") {
		changeContent.style.display=""; 
		changeContent1.style.display="";
		changeContent2.style.display="";
		disabilityNoTr.style.display="none";
	} else if(value == "13") {
		changeContent.style.display="none";
		changeContent1.style.display="none";
		changeContent2.style.display="none";
		disabilityNoTr.style.display="";
	}
}


</script>
</html>
