<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<html>
	<head>
		<title>优抚人员省内迁移</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
		<script>
					var currentField;
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
					var processId = '<%= (String)request.getParameter("processId")%>';
					var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
					var assignmentId = '<%=assignmentId%>';
					var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
					var serviceType = '<%=serviceType%>';
					var peopleId = '<%=peopleId%>';
		</script>
		<script type="text/javascript" src="../../../jsp/cams/bpt/comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ProvinceMigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand" method="queryById" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
			<model:field name="ingoingName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 业务类型 --> 
	<model:dataset id="BptServiceTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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
					<iframe id="typeFrame" src=""
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
<next:Panel width="100%" id="updateTabPanel" title="电子档案" height="100%">
				<next:Html>
					<iframe id="updateinfo" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="migratPanel" title="迁移信息" height="100%">
				<next:Html>
					<iframe id="migratinfo" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>

<next:Panel  title="审批信息" id="approveTabPanel" width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
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
		<form id="editForm" dataset="ProvinceMigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" width="99%" >
			<div>
				<table width="99%">
					<tr>
						<td class="FieldLabel" colspan="2" style="width:16%">业务类型</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="serviceType" field="serviceType" dataset="BptServiceTypeDataset"/></td>
						<td class="FieldLabel" style="width:16%">申请机构</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="applyOrganization" field="applyOrganization"/></td>
						<td class="FieldLabel" style="width:16%">抚恤金已发至月份</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="allowanceMonth" field="allowanceMonth"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" colspan="2">迁入地行政区划</td>
						<td class="FieldInput"><label type="text" name="ingoingName" field="ingoingName"/></td>
						<td class="FieldLabel">迁出地县级联系电话</td>
						<td class="FieldInput" colspan="3"><label type="text" name="outTownCheckPhone" field="outTownCheckPhone"/></td>
						<input type="hidden" name="ingoingCode" field="ingoingCode"/>
					</tr>
				</table>
			</div>
	   			</br>
	   		<div id="OutTownAduit">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁出地县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" style="width:16%"><input type="text" disabled="disabled" name="outTownAduitIncharge" field="outTownAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel" style="width:16%">审核时间</td>
						<td class="FieldInput" colspan="3" style="width:48%"><input disabled="disabled" type="text" name="outTownAduitApproveDate" field="outTownAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><textarea disabled="disabled" type="text" name="outTownAduitAdvice" field="outTownAduitAdvice" style="width:90%;"></textarea></td>
					</tr>
	   			</table>
	   		</div>
	   			</br>
	   		
	   		<div id="OutCityAduit" style="display:none">
	   			<table width="99%">
	   				<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁出地市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><input type="text" validateName="负责人" name="outCityAduitIncharge" field="outCityAduitIncharge"/></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><input validateName="审核时间" type="text" name="outCityAduitApproveDate" field="outCityAduitApproveDate" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><textarea type="text" name="outCityAduitAdvice" field="outCityAduitAdvice" style="width:90%;"></textarea></td>
					</tr>
	   			</table>
	   		</div>
	   			</br>
	   		
	   			</br>
	   		<div id="InTownAduit" style="display:none">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁入地县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><input type="text" validateName="负责人" name="inTownAduitIncharge" field="inTownAduitIncharge" /></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><input validateName="审核时间" type="text" name="inTownAduitApproveDate" field="inTownAduitApproveDate" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><textarea type="text" name="inTownAduitAdvice" field="inTownAduitAdvice" style="width:90%;"></textarea></td>
					</tr>
	   			</table>
	   		</div>
				</br>
	   		<div id="InCityAduit" style="display:none">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁入地市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><input type="text" validateName="负责人" name="inCityAduitIncharge" field="inCityAduitIncharge"  /></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><input validateName="审核时间" type="text" name="inCityAduitApproveDate" field="inCityAduitApproveDate"  format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><textarea type="text" name="inCityAduitAdvice" field="inCityAduitAdvice" style="width:90%;"></textarea></td>
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
</body>
<script type="text/javascript"><!--
	var eleUrl = "../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
	var updateUrl; // 修改页面url
	var url; // 类别信息url
	var migUrl;// 迁移信息url
	var first = true; // 类别信息标示
	var eleFirst = true;// 电子档案标示
	var migFirst = true; //迁移信息标示
	function init() {
	
		setPanel();
	
	var approveTabPanel = L5.getCmp("approveTabPanel");
	approveTabPanel.setTitle('<%=actDefName%>');
	
		var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		 
		ProvinceMigratDataSet.setParameter("APPLY_ID",'<%=applyId%>');
		 
		ProvinceMigratDataSet.load();
		
		 
		
		var tabpanel = L5.getCmp("approveTabPanel");
		tabpanel.on("activate",setHide);
		
		var typePanel = L5.getCmp("typeTabPanel"); // 设置类别信息url
		typePanel.on("activate",funcFrameUrl);
		
		var elePanel = L5.getCmp("updateTabPanel"); // 设置电子档案url
		elePanel.on("activate",funcFrameUrlEle);
		
		var migratPanel = L5.getCmp("migratPanel");// 设置迁移信息url
		migratPanel.on("activate",funcFrameUrlMig);
		
		L5.QuickTips.init(); 
	}
	
	function funcFrameUrlMig() {
			document.getElementById("migratinfo").src=L5.webPath+migUrl;
	} 
	
	function funcFrameUrlEle() {
		if(eleFirst) {
			document.getElementById("updateinfo").src=eleUrl;
			eleFirst = false;
		}
	}
	
	function updateInfo() { // 若流程为第一环节则可修改
		var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		var records = ProvinceMigratDataSet.getAllRecords();
		var serviceType = records[0].get("serviceType");
		var width = screen.width-100;
	    var height = screen.height-140;
		url = "../../../jsp/cams/bpt/flow/comm/PMTownEdit.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>&serviceType="+serviceType;
		 window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		
		if(processId=="null"){
			ProvinceMigratDataSet.setParameter("assignmentId",assignmentId);
		}else{
			ProvinceMigratDataSet.setParameter("PROCESS_ID",processId);
		}
		ProvinceMigratDataSet.load();
	}
	
	function funcFrameUrl() { //类别信息url跳转
		if(first) {
			document.getElementById("typeFrame").src=url;
			first = false;
		}	
	}
	
	function setPanel() { //设置panel的隐藏
		
		var serviceType = '<%=serviceType%>';
		eleUrl = eleUrl + "&serviceType="+serviceType;
		if(serviceType=="16"){
			//隐藏除伤残以外的其他tab，待写
			url = "../../../jsp/cams/bpt/flow/comm/disabilityTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			updateUrl="/jsp/cams/bpt/flow/disability/disabilitymigrate/provincemigration/provinceMigrationUpdate.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			migUrl="/jsp/cams/bpt/flow/disability/disabilitymigrate/provincemigration/provinceMigration_Detail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="23"){
			//隐藏除三属以外的其他tab，待写
			
			url = "../../../jsp/cams/bpt/flow/dependant/comm/dependantTypeDetail_emigrat.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			updateUrl="/jsp/cams/bpt/flow/dependant/dependantmigrate/provincemigration/provinceMigrationUpdate.jsp?applyId=<%=applyId%>";
			migUrl = "/jsp/cams/bpt/flow/dependant/dependantmigrate/provincemigration/provinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="43"){
			//隐藏除在乡以外的其他tab
			url = "../../../jsp/cams/bpt/flow/demobilized/comm/demobilizedInfo.jsp?peopleId=<%=peopleId%>";
			updateUrl="/jsp/cams/bpt/flow/demobilized/demoprovincemigrate/demoProvinceMigrationUpdate.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
			migUrl="/jsp/cams/bpt/flow/demobilized/demoprovincemigrate/demoProvince_Detail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
		} else if(serviceType=="47"){
			//隐藏除带病回乡以外的其他tab，待写
			url = "../../../jsp/cams/bpt/flow/demobilizedillness/comm/demobilizedIllnessInfo.jsp?peopleId=<%=peopleId%>";
			updateUrl="/jsp/cams/bpt/flow/demobilizedillness/illprovincemigrate/illprovinceMigrationUpdatet.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			migUrl="/jsp/cams/bpt/flow/demobilizedillness/illprovincemigrate/illprovinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="53"){
			
			url = "../../../jsp/cams/bpt/flow/comm/warTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			updateUrl = "/jsp/cams/bpt/flow/war/migrate/provincialmigration/provinceMigrationUpdate.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			migUrl="/jsp/cams/bpt/flow/war/migrate/provincialmigration/provinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="63"){
			//隐藏除参试以外的其他tab，待写
			
			url = "../../../jsp/cams/bpt/flow/tested/comm/bpttestedDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			updateUrl = "/jsp/cams/bpt/flow/tested/testedmigrate/provincemigration/provinceMigrationUpdate.jsp?applyId=<%=applyId%>";
			migUrl="/jsp/cams/bpt/flow/tested/testedmigrate/provincemigration/provinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="83"){
			//60周岁
			url = "../../../jsp/cams/bpt/dataCollection/bptcountretiredsoldier/bptcountretiredsoldierInfo.jsp?applyId=<%=applyId%>&peopleId='<%=peopleId%>'";
			migUrl = "/jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/provincemigration/sprovinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="B3"){
			//老烈子女
			migUrl = "/jsp/cams/bpt/flow/martyroffspring/martymigrate/provincemigration/mprovinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			url = "../../../jsp/cams/bpt/flow/martyroffspring/martyrOffspringDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} 
	}
	
	function save(){
		if(validateNotNull()) {
		var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		var ProvinceMigratRecord = ProvinceMigratDataSet.getCurrent();
		//校验
		var valid = ProvinceMigratDataSet.isValidate();
		if(valid != true){
			L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
			return false;
		}	
		
		var outCityAduitApproveDate = ProvinceMigratRecord.get("outCityAduitApproveDate");
	if(outCityAduitApproveDate!=''&&!validateDateFormat(outCityAduitApproveDate)){
		L5.Msg.alert("提示","迁出地市级审核时间格式不正确！");
		return false;
	}
	var inTownAduitApproveDate = ProvinceMigratRecord.get("inTownAduitApproveDate");
	if(inTownAduitApproveDate!=''&&!validateDateFormat(inTownAduitApproveDate)){
		L5.Msg.alert("提示","迁入地县级审核时间格式不正确！");
		return false;
	}
	var inCityAduitApproveDate = ProvinceMigratRecord.get("inCityAduitApproveDate");
	if(inCityAduitApproveDate!=''&&!validateDateFormat(inCityAduitApproveDate)){
		L5.Msg.alert("提示","迁入地市级审核时间格式不正确！");
		return false;
	}
		
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
		command.setParameter("record",ProvinceMigratRecord);
		command.execute("update");	
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
		}    
	}
	
	function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}
	
	
	function setHide(approveTabPanel){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=applyId%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
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
			 
			 	sip(ProvinceMigratDataSet,fieldId,isHidden,isReadOnly);
				
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
					var txts = target.getElementsByTagName("img");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
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
				var currentDate = getCurDate();
				//迁出地市级审核
				if(fieldId=="OutCityAduit"&&isHidden=="0"&&isReadOnly=="0"){
					var outCityAduitIncharge = ProvinceMigratDataSet.get("outCityAduitIncharge");
					if(outCityAduitIncharge == "" || outCityAduitIncharge == null) {
						ProvinceMigratDataSet.set("outCityAduitIncharge",currentUserName);
					}
					var outCityAduitApproveDate = ProvinceMigratDataSet.get("outCityAduitApproveDate");
					if(ifback){
					ProvinceMigratDataSet.set("outCityAduitApproveDate",currentDate);
					
					}else if(outCityAduitApproveDate == "" || outCityAduitApproveDate == null) {
						ProvinceMigratDataSet.set("outCityAduitApproveDate",currentDate);
					}
				}
				
				//迁入地县级审核
				if(fieldId=="InTownAduit"&&isHidden=="0"&&isReadOnly=="0"){
					var inTownAduitIncharge = ProvinceMigratDataSet.get("inTownAduitIncharge");
					if(inTownAduitIncharge == "" || inTownAduitIncharge == null) {
						ProvinceMigratDataSet.set("inTownAduitIncharge",currentUserName);
					}
					var inTownAduitApproveDate = ProvinceMigratDataSet.get("inTownAduitApproveDate");
					if(ifback){
						ProvinceMigratDataSet.set("inTownAduitApproveDate",currentDate);
					}else if(inTownAduitApproveDate == "" || inTownAduitApproveDate == null) {
						ProvinceMigratDataSet.set("inTownAduitApproveDate",currentDate);
					}
				}
				//迁入地市级审核
				if(fieldId=="InCityAduit"&&isHidden=="0"&&isReadOnly=="0"){
					var inCityAduitIncharge = ProvinceMigratDataSet.get("inCityAduitIncharge");
					if(inCityAduitIncharge == "" || inCityAduitIncharge == null) {
						ProvinceMigratDataSet.set("inCityAduitIncharge",currentUserName);
					}
					var inCityAduitApproveDate = ProvinceMigratDataSet.get("inCityCheckDate");
					if(inCityAduitApproveDate == "" || inCityAduitApproveDate == null) {
						ProvinceMigratDataSet.set("inCityAduitApproveDate",currentDate);
					}
				}

}
function sendOver(){
	var Condition = 'end';
	sendFlow(Condition);
}
function send(){
	var Condition = 'pass';
	sendFlow(Condition);
}

//发送流程
function sendFlow(Condition){
	/*if(!ifsave) {
		L5.Msg.alert("提示","请先保存审批信息!");
		return false;
	}*/
	if(validateNotNull()){
	  if(checkProcessState("send")){
	  var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		var ProvinceMigratRecord = ProvinceMigratDataSet.getCurrent();
	   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	  
	  command.setParameter("record",ProvinceMigratRecord);
	   command.setParameter("serviceType",ProvinceMigratDataSet.get("serviceType"));
	   command.setParameter("peopleId",ProvinceMigratDataSet.get("peopleId"));
	   command.setParameter("applyId",ProvinceMigratDataSet.get("applyId"));
	  
	  
	   //执行发送流程方法
	   var inTownOrganId = document.getElementById("ingoingCode").value;
	   command.setParameter("In_Town_OrganId",inTownOrganId);
		command.setParameter("Condition",Condition);
		command.setParameter("currentField",currentField);
		command.setParameter("actDefName",'<%=actDefName%>');
	   command.execute("send");
	   if(!command.error){
		   alert("成功发送到下一环节!");		
		   window.close();
		   window.returnValue = "success";  
		   //跳转到已办任务页面
		   //var url = "jsp/workflow/tasklist/queryyiban.jsp";
		   //L5.forward(url,"已办任务页面");
	   }else{
	      alert(command.error);
	  }
	 }
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
		var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		var ProvinceMigratRecord = ProvinceMigratDataSet.getCurrent();
	    var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	  
	    command.setParameter("record",ProvinceMigratRecord);
		command.setParameter("applyId",'<%=applyId%>');
		command.setParameter("peopleId",ProvinceMigratDataSet.get("peopleId"));
		command.setParameter("currentField",currentField);
		command.setParameter("actDefName",'<%=actDefName%>');
	   //执行发送流程方法
	   command.execute("back");
	   if(!command.error){
		   alert("成功回退流程!");		
		   window.returnValue="success";
		   window.close();  
		   //跳转到已办任务页面
		   //var url = "jsp/workflow/tasklist/queryyiban.jsp";
		  // L5.forward(url,"已办任务页面");
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
			
			currentField = "<%=fieldId%>";
			var target=document.getElementById("<%=fieldId%>");
			if(target){
				var inputs = target.getElementsByTagName("input"); // 验证input标签
				for(var i=0;i<inputs.length;i++) {
					 if(inputs[i].type=="text") {
					 	  var inputValue = inputs[i].value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(inputs[i].getAttribute("validateName")+"不能为空!");
						  	  return false;
						  }
					 }
				}
				var selects = target.getElementsByTagName("select");// 验证select标签
				for(var i=0;i<selects.length;i++) {	
					 	  var inputValue = selects[i].value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(selects[i].getAttribute("validateName")+"不能为空!");
						  	  return false;
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
function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}
</script>

</html>
