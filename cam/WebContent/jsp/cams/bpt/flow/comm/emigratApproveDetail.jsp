<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@page import="java.util.HashMap" %>
<html>
	<head>
		<title>优抚抚恤关系跨省迁出审批表</title>
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
					var processId = '<%= (String)request.getParameter("processId")%>';
					var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
					var assignmentId = '<%=assignmentId%>';
					var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="BptApplyEmigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationQueryCommand" method="queryById" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyEmigration"></model:record>
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
	<next:TabPanel id="allPanel">
	
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
<next:Panel  title="审批表" id="approveTabPanel" width="100%" height="100%" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="BptApplyEmigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" width="99%">
			<div>
			  <table width="99%">
		   		<tr>
						<td class="FieldLabel" colspan="2" style="width:16%">业务类型</td>
						<td class="FieldInput" style="width:16%" nowrap="nowrap"><label type="text" name="serviceType" field="serviceType" dataset="BptServiceTypeDataset"/></td>
						<td class="FieldLabel" style="width:16%">申请机构</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="applyOrganization" field="applyOrganization"/></td>
						<td class="FieldLabel" style="width:16%">抚恤金已发至月份</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="allowanceMonth" field="allowanceMonth"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" colspan="2" style="width:16%">迁入地民政局：</td>
					<td class="FieldInput" colspan="5"><label name="ingoingAddress" field="ingoingAddress"/></td>
				</tr>
			  </table>
		   </div>
				<br/>
			<div id="TownAduit">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" ><label name="townAduitIncharge" field="townAduitIncharge"/></td>
						<td class="FieldLabel" style="width:8%">审核时间</td>
						<td class="FieldInput" colspan="3"><label name="townAduitApproveDate" field="townAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><label name="townAduitAdvice" rows="3" field="townAduitAdvice" ></label></td>
					</tr>
				</table>
			</div>
				<br/>
			<div id="CityAduit" style="display:none">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><label name="cityAduitIncharge" field="cityAduitIncharge"/></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><label name="cityAduitApproveDate" field="cityAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><label name="cityAduitAdvice" field="cityAduitAdvice" rows="3"/></td>
					</tr>
				</table>
			</div>
				<br/>
			<div id="ProvinceApprove" style="display:none">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">省级审批</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><label name="provinceIncharge" field="provinceIncharge"/></td>
						<td class="FieldLabel">审批时间</td>
						<td class="FieldInput" colspan="3"><label name="provinceApproveDate" field="provinceApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><label name="provinceAdvice" field="provinceAdvice" rows="3"/></td>
					</tr>
				</table>
			</div>
		</table>
		</form>
   </next:Html>
</next:Panel>
<next:Panel width="100%" id="appHistory" title="审批历史记录" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/comm/intoProAppHistory.jsp?applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>

	</next:TabPanel>
	</next:Tabs>

</next:Panel>

<script type="text/javascript">
	var eleUrl = "../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
	var url; // 类别信息url
	var migUrl;// 迁移信息url
	var first = true; // 类别信息标示
	var eleFirst = true;// 电子档案标示
	var migFirst = true; //迁移信息标示
	function init() {
		setPanel();
	
		var approveTabPanel = L5.getCmp("approveTabPanel");
		approveTabPanel.setTitle('<%=actDefName%>');
		var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
		BptApplyEmigratDataSet.setParameter("APPLY_ID",'<%=applyId%>');
		BptApplyEmigratDataSet.load();
		
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
	
	function funcFrameUrl() { //类别信息url跳转
		if(first) {
			document.getElementById("typeFrame").src=url;
			first = false;
		}	
	}
	
	function setPanel() { //设置panel的隐藏
		var serviceType = '<%=serviceType%>';
		eleUrl = eleUrl + "&serviceType="+serviceType;
		if(serviceType=="19"){
			//隐藏除伤残以外的其他tab，待写
			migUrl="/jsp/cams/bpt/flow/disability/disabilitymigrate/emigration/emigration_Detail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			url = "../../../jsp/cams/bpt/flow/comm/disabilityTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
		} else if(serviceType=="25"){
		 migUrl="/jsp/cams/bpt/flow/dependant/dependantmigrate/emigration/emigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";	
			url = "../../../jsp/cams/bpt/flow/dependant/comm/dependantTypeDetail_emigrat.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
		} else if(serviceType=="4A"){
			//隐藏除在乡以外的其他tab，
			 migUrl="/jsp/cams/bpt/flow/demobilized/demobilizedmigrate/demomigration_Detail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>"; 
			url = "../../../jsp/cams/bpt/flow/demobilized/comm/demobilizedInfo.jsp?peopleId=<%=peopleId%>";
		} else if(serviceType=="4B"){
			//隐藏除带病回乡以外的其他tab
			 migUrl="/jsp/cams/bpt/flow/demobilizedillness/illmigrate/illMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>"; 
			url = "../../../jsp/cams/bpt/flow/demobilizedillness/comm/demobilizedIllnessInfo.jsp?peopleId=<%=peopleId%>";
		} else if(serviceType=="55"){
		migUrl="/jsp/cams/bpt/flow/war/migrate/emigration/emigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>"; 
			url = "../../../jsp/cams/bpt/flow/comm/warTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
		
		} else if(serviceType=="65"){
			//隐藏除参试以外的其他tab，待写
			migUrl="/jsp/cams/bpt/flow/tested/testedmigrate/emigration/emigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>"; 
			url = "../../../jsp/cams/bpt/flow/tested/comm/bpttestedDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
		}  else if(serviceType=="84"){
			//60周岁
			url = "../../../jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			migUrl = "/jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/emigration/sEmigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="B4"){
			//老烈子女
			url = "../../../jsp/cams/bpt/flow/martyroffspring/martyrOffspringDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			migUrl = "/jsp/cams/bpt/flow/martyroffspring/martymigrate/emigration/martyEmigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} 
	}
	
	
		//设置环节域的隐藏
function setHide(approveTabPanel){
    var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
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
		//根据是否隐藏和只读给相应环节负责人和日期赋值

		if(target){
			target.style.display="";
				}
		if(isHidden == "1") { // 判断是否为隐藏
					var target=document.getElementById("<%=fieldId%>");
						if(target){
							target.style.display="none";
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
					var txts = target.getElementsByTagName("img");
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

</script>

</body>
</html>
