<%@ page contentType="text/html; charset=UTF-8"%>
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
		<title>优抚人员省内迁移</title>
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
	<next:Html>
		<form id="editForm"   dataset="ProvinceMigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" width="99%">
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
					</tr>
				</table>
			</div>
	   			</br>
	   		<div id="OutTownAduit">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁出地县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="outTownAduitIncharge" field="outTownAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel" style="width:16%">审核时间</td>
						<td class="FieldInput" colspan="3" style="width:48%"><label type="text" name="outTownAduitApproveDate" field="outTownAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><label type="text" name="outTownAduitAdvice" field="outTownAduitAdvice" style="width:90%;"></label></td>
					</tr>
	   			</table>
	   		</div>
	   			</br>
	   		<div id="OutCityAduit" style="display:none">
	   			<table width="99%">
	   				<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁出地市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><label type="text" name="outCityAduitIncharge" field="outCityAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><label type="text" name="outCityAduitApproveDate" field="outCityAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><label type="text" name="outCityAduitAdvice" field="outCityAduitAdvice" style="width:90%;"></label></td>
					</tr>
	   			</table>
	   		</div>
	   			</br>
	   		<div id="InTownAduit" style="display:none">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁入地县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><label type="text" name="inTownAduitIncharge" field="inTownAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><label type="text" name="inTownAduitApproveDate" field="inTownAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><label type="text" name="inTownAduitAdvice" field="inTownAduitAdvice" style="width:90%;"></label></td>
					</tr>
	   			</table>
	   		</div>
				</br>
	   		<div id="InCityAduit" style="display:none">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁入地市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><label type="text" name="inCityAduitIncharge" field="inCityAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><label type="text" name="inCityAduitApproveDate" field="inCityAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><label type="text" name="inCityAduitAdvice" field="inCityAduitAdvice" style="width:90%;"/></td>
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
<script type="text/javascript">
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
		/*if(migFirst) {
			document.getElementById("migratinfo").src=L5.webPath+migUrl;
			migFirst = false;
		}*/
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
		if(serviceType=="16"){
			//隐藏除伤残以外的其他tab，待写
			url = "../../../jsp/cams/bpt/flow/comm/disabilityTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			migUrl="/jsp/cams/bpt/flow/disability/disabilitymigrate/provincemigration/provinceMigration_Detail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="23"){
			//隐藏除三属以外的其他tab，待写
			migUrl = "/jsp/cams/bpt/flow/dependant/dependantmigrate/provincemigration/provinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
				url = "../../../jsp/cams/bpt/flow/dependant/comm/dependantTypeDetail_emigrat.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
		} else if(serviceType=="43"){
			//隐藏除在乡以外的其他tab，待写
			url = "../../../jsp/cams/bpt/flow/demobilized/comm/demobilizedInfo.jsp?peopleId=<%=peopleId%>";
			migUrl="/jsp/cams/bpt/flow/demobilized/demoprovincemigrate/demoProvince_Detail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
		} else if(serviceType=="47"){
			//隐藏除带病回乡以外的其他tab，待写
			url = "../../../jsp/cams/bpt/flow/demobilizedillness/comm/demobilizedIllnessInfo.jsp?peopleId=<%=peopleId%>";
			migUrl="/jsp/cams/bpt/flow/demobilizedillness/illprovincemigrate/illprovinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			
		} else if(serviceType=="53"){
			url = "../../../jsp/cams/bpt/flow/comm/warTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			migUrl="/jsp/cams/bpt/flow/war/migrate/provincialmigration/provinceMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
		} else if(serviceType=="63"){
			//隐藏除参试以外的其他tab，待写
			url = "../../../jsp/cams/bpt/flow/tested/comm/bpttestedDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
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
		
	//设置环节域的隐藏
function setHide(approveTabPanel){
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
}
</script>

</html>
