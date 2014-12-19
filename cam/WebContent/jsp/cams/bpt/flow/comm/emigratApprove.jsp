<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
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
		<script type="text/javascript" src="../../../jsp/cams/bpt/comm/bptComm.js"></script>
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
<next:Panel  title="审批表" id="approveTabPanel" width="100%" height="100%" autoScroll="false">
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
	</next:TopBar>
	<next:Html>
	<DIV style="OVERFLOW-Y: auto;  HEIGHT: expression(400)">
	
		<form id="editForm" dataset="BptApplyEmigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" width="99%" style="">
		  
			  <table width="99%" >
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
		  
				<br/>
			<div id="TownAduit">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" ><input type="text" disabled="disabled" validateName="县级审核负责人"name="townAduitIncharge" field="townAduitIncharge" /></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><input disabled="disabled" type="text" validateName="县级审核时间"name="townAduitApproveDate" field="townAduitApproveDate"format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  disabled="disabled" src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><textarea disabled="disabled" type="text" name="townAduitAdvice" rows="3" field="townAduitAdvice" style="width:90%"></textarea></td>
					</tr>
				</table>
			</div>
				<br/>
	 
			<div id="CityAduit">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><input type="text" validateName="市级审核负责人"name="cityAduitIncharge" field="cityAduitIncharge" /></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><input type="text" validateType="date" validateName="市级审核时间"name="cityAduitApproveDate" field="cityAduitApproveDate"format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><textarea type="text" name="cityAduitAdvice" field="cityAduitAdvice" rows="3" style="width:90%"></textarea></td>
					</tr>
				</table>
			</div>
				<br/>
			<div id="ProvinceApprove" style="display:none">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">省级审批</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><input type="text" validateName="省级审批负责人"name="provinceIncharge" field="provinceIncharge" /></td>
						<td class="FieldLabel">审批时间</td>
						<td class="FieldInput" colspan="3"><input type="text" validateType="date" validateName="省级审批时间"name="provinceApproveDate" field="provinceApproveDate" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><textarea type="text" name="provinceAdvice" field="provinceAdvice" rows="3" style="width:90%"></textarea></td>
					</tr>
				</table>
			</div>
		</table>
		</form>
		</DIV>
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
var currentDate = getCurDate();
var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var eleUrl = "../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
	var updateUrl; // 修改页面url
	var url; // 类别信息url
	var migUrl;// 迁移信息url
	var first = true; // 类别信息标示
	var eleFirst = true;// 电子档案标示
	var migFirst = true; //迁移信息标示
	var currentField = "TownAduit";
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
	
	function updateInfo() { // 若流程为第一环节则可修改
		var width = screen.width-100;
	    var height = screen.height-140;
	    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		if(processId=='null'){
			command.setParameter("assignmentId",assignmentId);
		}else{
			command.setParameter("PROCESS_ID",processId);
		}
		command.execute("queryBusinessType");
		var peopleId = command.getReturn("peopleId");
		var familyId = command.getReturn("familyId");
		var url = L5.webPath+updateUrl;
		var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		window.location.reload();
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
			url = "../../../jsp/cams/bpt/flow/comm/disabilityTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			updateUrl="/jsp/cams/bpt/flow/disability/disabilitymigrate/emigration/emigrationUpdate.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
			migUrl="/jsp/cams/bpt/flow/disability/disabilitymigrate/emigration/emigration_Detail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		}  else if(serviceType=="25"){
			 migUrl="/jsp/cams/bpt/flow/dependant/dependantmigrate/emigration/emigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			url = "../../../jsp/cams/bpt/flow/dependant/comm/dependantTypeDetail_emigrat.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			updateUrl="/jsp/cams/bpt/flow/dependant/dependantmigrate/emigration/emigrationUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="4A"){
			//隐藏除在乡以外的其他tab
			//隐藏除在乡以外的其他tab，
			 migUrl="/jsp/cams/bpt/flow/demobilized/demobilizedmigrate/demomigration_Detail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			url = "../../../jsp/cams/bpt/flow/demobilized/comm/demobilizedInfo.jsp?peopleId=<%=peopleId%>";
			updateUrl="/jsp/cams/bpt/flow/demobilized/demobilizedmigrate/demomigrationUpdate.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="4B"){
			//隐藏除带病回乡以外的其他tab
			 migUrl="/jsp/cams/bpt/flow/demobilizedillness/illmigrate/illMigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			url = "../../../jsp/cams/bpt/flow/demobilizedillness/comm/demobilizedIllnessInfo.jsp?peopleId=<%=peopleId%>";
			updateUrl = "/jsp/cams/bpt/flow/demobilizedillness/illmigrate/illMigrationUpdatetManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		}else if(serviceType=="55"){
			migUrl="/jsp/cams/bpt/flow/war/migrate/emigration/emigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>"; 
			url = "../../../jsp/cams/bpt/flow/comm/warTypeDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			updateUrl = "/jsp/cams/bpt/flow/war/migrate/emigration/emigrationUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		}else if(serviceType=="65"){
			//隐藏除参试以外的其他tab，待写
			migUrl="/jsp/cams/bpt/flow/tested/testedmigrate/emigration/emigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			url = "../../../jsp/cams/bpt/flow/tested/comm/bpttestedDetail.jsp?processId=<%=(String)request.getParameter("processId")%>&assignmentId=<%= (String)request.getParameter("assignmentId")%>";
			updateUrl = "/jsp/cams/bpt/flow/tested/testedmigrate/emigration/emigrationUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="84"){
			//60周岁
			url = "../../../jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			migUrl = "/jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/emigration/sEmigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			updateUrl = "/jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/emigration/sEmigrationUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="B4"){
			//老烈子女
			url = "../../../jsp/cams/bpt/flow/martyroffspring/martyrOffspringDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			migUrl = "/jsp/cams/bpt/flow/martyroffspring/martymigrate/emigration/martyEmigrationDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			updateUrl = "/jsp/cams/bpt/flow/martyroffspring/martymigrate/emigration/martyEmigrationUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		}
	}
	
	function save(){
		var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
		var BptApplyEmigratRecord = BptApplyEmigratDataSet.getCurrent();
		var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand"); 
		command.setParameter("record",BptApplyEmigratRecord);
		command.execute("updateApprove");	
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	
	//设置环节域的隐藏
function setHide(approveTabPanel){
    var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=applyId%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
	var currentDate = getCurDate();
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
		sip(BptApplyEmigratDataSet,fieldId,isHidden,isReadOnly);

		if(target){
			target.style.display="";
				}
		if(isHidden == "1") { // 判断是否为隐藏
				if(!ifback) { // 判断是否为退回操作
					var target=document.getElementById("<%=fieldId%>");
						if(target){
							target.style.display="none";
						}	
		}else{
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


//发送流程
function send(){
	operation("pass");
}

function operation(value) {
	if(validateNotNull()){
	  if(checkProcessState("send")){
	  var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
	  var BptApplyEmigratRecord = BptApplyEmigratDataSet.getCurrent();
	  var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	   command.setParameter("record",BptApplyEmigratRecord);
	   command.setParameter("serviceType",BptApplyEmigratDataSet.get("serviceType"));
	   command.setParameter("peopleId",BptApplyEmigratDataSet.get("peopleId"));
	   command.setParameter("applyId",BptApplyEmigratDataSet.get("applyId"));
	   command.setParameter("currentField",currentField)
	   command.setParameter("condition",value);
	   command.setParameter("actName",'<%=actDefName%>');
	   //执行发送流程方法
	   command.execute("send");
	   if(!command.error){
		   alert("成功发送到下一环节!");	
		   window.close();
		   window.returnValue = "success";
		   //if(value == "pass") {  
		   		//跳转到已办任务页面
		   //		var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		   //		L5.forward(url,"已办任务页面");
		   //} else if(value == "end") {
		   		//跳转到结束任务页面
		   //		var url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
		   //		L5.forward(url,"结束任务页面");
		   //}		
	   }else{
	      alert("回退失败！"+command.error);
	  }
	 }
	}
}

//不予认定并结束
function sendOver(){
	operation("end");	 
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
	if(validateNotNull()) {
		var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
		var BptApplyEmigratRecord = BptApplyEmigratDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	   command.setParameter("record",BptApplyEmigratRecord);
	   command.setParameter("applyId",BptApplyEmigratDataSet.get("applyId"));
	    command.setParameter("currentField",currentField)
	   command.setParameter("actName",'<%=actDefName%>');
	   //执行发送流程方法
	   command.execute("back");
	   if(!command.error){
		   alert("成功回退流程!");
		   window.close();
		   window.returnValue = "success";		  
		   //跳转到已办任务页面
		   //var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		   //L5.forward(url,"已办任务页面");
	   }else{
	      alert("回退失败！"+command.error);
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
			currentField = '<%=fieldId%>';
			if(target){
				var inputs = target.getElementsByTagName("input"); // 验证input标签
				for(var i=0;i<inputs.length;i++) {
					 if(inputs[i].type=="text") {
					 	  var inputValue = inputs[i].value;
					 	  var validateName = inputs[i].getAttribute("validateName");
						  if(inputValue == null || inputValue == "") {
						  	  alert(validateName+"不能为空!");
						  	  return false;
						  } else {
						  	  var validateType = inputs[i].getAttribute("validateType");
						  	  if(validateType == "date") {
						  	  	  if(!validateDateFormat(inputValue)) {
						  	  	  	 L5.Msg.alert("提示",validateName+"格式不正确！");
									 return false;
						  	  	  }
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
// 设置默认值
function sip(DisabilityApproveDataset,fieldId,isHidden,isReadOnly) {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
			command.setParameter("applyId",'<%=applyId%>');
			command.execute("validateIfback");
			var ifback = command.getReturn("ifback");
				//县级审核
				if(fieldId=="TownAduit"&&isHidden=="0"&&isReadOnly=="0"){
					var townAduitApproveDate = DisabilityApproveDataset.get("townAduitApproveDate");
					if(townAduitApproveDate == "" || townAduitApproveDate == null) {
						DisabilityApproveDataset.set("townAduitApproveDate",currentDate);
					}	
					
					var townAduitIncharge = DisabilityApproveDataset.get("townAduitIncharge");
					if(townAduitIncharge == "" || townAduitIncharge == null) {
						DisabilityApproveDataset.set("townAduitIncharge",currentUserName);
					}
				
						
				}
				//市级审核
				if(fieldId=="CityAduit"&&isHidden=="0"&&isReadOnly=="0"){
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
					
				}
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
</script>

</body>
</html>
