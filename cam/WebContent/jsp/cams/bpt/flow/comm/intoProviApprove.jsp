<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<html>
	<head>
		<title>外省优抚人员抚恤关系迁入我省编辑</title>
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
					var serviceType = '<%=serviceType%>';
					var peopleId = '<%=peopleId%>';
					var applyId = '<%=applyId%>';
		</script>
		<script type="text/javascript" src="../../../jsp/cams/bpt/comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 外省优抚人员抚恤关系迁入DataSet -->
	<model:dataset id="BptIntoproviDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyIntoprovince"></model:record>
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
	<next:TabPanel animScroll="true" enableTabScroll="true" id="allPanel">
<next:Panel width="100%" id="peopleTabPanel" title="基本信息" height="100%">
				<next:Html>
					<iframe id="people" src="../../../jsp/cams/bpt/comm/peopleDetail.jsp?peopleId=<%=peopleId%>"
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
					<iframe id="house" src="../../../jsp/cams/bpt/comm/houseDetail.jsp?familyId=<%=familyId%>"
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
<next:Panel width="100%" id="intoPrintPanel" title="迁移信息" height="100%">
				<next:Html>
					<iframe id="intoPrint" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel  title="审批信息" width="100%" height="100%" id="approveTabPanel" autoScroll="true">
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
		<form id="editForm"   dataset="BptIntoproviDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
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
						<td class="FieldLabel" colspan="2" style="width:16%">由何地迁入：</td>
						<td class="FieldInput"><label name="ingoingAddress" field="ingoingAddress"/></td>
						<td class="FieldLabel">迁入原因</td>
						<td class="FieldInput" colspan="5"><label name="ingoingReason" field="ingoingReason"/></td>
					</tr>
		  	</table>
		  </div>
		  	<br/>
		  <div id="TownVerify">
		  	<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2">县级审核</td>
						<td class="FieldLabel" >审核人员</td>
						<td class="FieldInput"><input type="text" disabled="disabled" name="townAduitIncharge" field="townAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput"><input type="text" disabled="disabled" name="townAduitApproveDate" field="townAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">审核意见</td>
						<td class="FieldInput" colspan="3"><textarea disabled="disabled" type="text" name="townAduitAdvice" field="townAduitAdvice" style="width:90%"></textarea></td>
					</tr>
			 </table>
		  </div>
			<br/>
		  <div id="CityVerify" style="display:none">
		  	<table width="99%">
		   		<tr>
		   			<td class="FieldLabel" rowspan="2">市级审核</td>
					<td class="FieldLabel">审核人员</td>
					<td class="FieldInput"><input type="text" validateName="审核人员" name="cityAduitIncharge" field="cityAduitIncharge" /></td>
					<td class="FieldLabel">审核时间</td>
					<td class="FieldInput"><input type="text" validateType="date" validateName="审核时间" name="cityAduitApproveDate" field="cityAduitApproveDate" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
				</tr>
		   		<tr>
					<td class="FieldLabel">审核意见</td>
					<td class="FieldInput" colspan="3"><textarea type="text" name="cityAduitAdvice" field="cityAduitAdvice" style="width:90%"></textarea></td>
				</tr>
			</table>
		  </div>
		  	<br/>
		   
			<div id="ProvinceApprove" style="display:none">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2">省级审批</td>
						<td class="FieldLabel">审批人员</td>
						<td class="FieldInput"><input type="text" validateName="审批人员" name="provinceIncharge" field="provinceIncharge" /></td>
					
						<td class="FieldLabel">审批时间</td>
						<td class="FieldInput"><input type="text" validateType="date" validateName="审批时间" name="provinceApproveDate" field="provinceApproveDate" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">审批意见</td>
						<td class="FieldInput" colspan="3"><textarea type="text" name="provinceAdvice" field="provinceAdvice" style="width:90%"></textarea></td>
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
	var updateUrl; // 修改页面url
	var url; // 类别信息url
	var printUrl;//迁移信息url
	var first = true; // 类别信息标示
	var eleFirst = true;// 电子档案标示
	var migFirst = true; //迁移信息标识
	var currentField = "TownVerify";
	
	function init() {
		setPanel();
		
		var approveTabPanel = L5.getCmp("approveTabPanel");
		approveTabPanel.setTitle('<%=actDefName%>');
		var BptIntoproviDataset = L5.DatasetMgr.lookup("BptIntoproviDataset");
		BptIntoproviDataset.setParameter("APPLY_ID",'<%=applyId%>');
		BptIntoproviDataset.load();
		
		var tabpanel = L5.getCmp("approveTabPanel");
		tabpanel.on("activate",setHide);
		
		var typePanel = L5.getCmp("typeTabPanel"); // 设置类别信息url
		typePanel.on("activate",funcFrameUrl);
		
		var elePanel = L5.getCmp("updateTabPanel"); // 设置电子档案url
		elePanel.on("activate",funcFrameUrlEle);
		 
		var elePanel = L5.getCmp("intoPrintPanel"); // 设迁移信息url
		elePanel.on("activate",funcintoPrintUrl);
		
		L5.QuickTips.init(); 
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
	function funcintoPrintUrl() { //类别信息url跳转
			document.getElementById("intoPrint").src=printUrl;
	}
	function setPanel() { //设置panel的隐藏
		 
		var serviceType = '<%=serviceType%>';
		eleUrl = eleUrl + "&serviceType="+serviceType;
		if(serviceType=="15"){
		//隐藏除伤残以外的其他tab
		
			url="../../../jsp/cams/bpt/flow/disability/disabilitymigrate/ingoingprovince/intoProviDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			printUrl="../../../jsp/cams/bpt/flow/disability/disabilitymigrate/ingoingprovince/intoProviPrint.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";	
			updateUrl="/jsp/cams/bpt/flow/disability/disabilitymigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="22"){
			url = "../../../jsp/cams/bpt/flow/dependant/dependantmigrate/ingoingprovince/intoProviDetail.jsp?applyId=<%=applyId%>";
			printUrl = "../../../jsp/cams/bpt/flow/dependant/dependantmigrate/ingoingprovince/intoProviPrint.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			updateUrl="/jsp/cams/bpt/flow/dependant/dependantmigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="42"){
			//隐藏除在乡以外的其他tab，
			url = "../../../jsp/cams/bpt/flow/demobilized/demoingoingprovince/demobilizedInfo.jsp?peopleId=<%=peopleId%>";
			printUrl = "../../../jsp/cams/bpt/flow/demobilized/demoingoingprovince/demobilizedPrint.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			updateUrl="/jsp/cams/bpt/flow/demobilized/demoingoingprovince/demobilizedUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="46"){
			//隐藏除带病回乡以外的其他tab，待写
			url = "../../../jsp/cams/bpt/flow/demobilizedillness/illingoingmigrate/demobilizedIllnessInfo.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			printUrl = "../../../jsp/cams/bpt/flow/demobilizedillness/illingoingmigrate/demobilizedIllnessIntoPrint.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			updateUrl = "/jsp/cams/bpt/flow/demobilizedillness/illingoingmigrate/demobilizedIllnessUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="52"){
		//参战
			url = "../../../jsp/cams/bpt/flow/war/migrate/ingoingprovince/bptwarDetail.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
			printUrl = "../../../jsp/cams/bpt/flow/war/migrate/ingoingprovince/warIntoPrint.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			updateUrl = "/jsp/cams/bpt/flow/war/migrate/ingoingprovince/intoProviUpdate.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="62"){
			//隐藏除参试以外的其他tab，待写
			url = "../../../jsp/cams/bpt/flow/tested/testedmigrate/ingoingprovince/intoProviDetail.jsp?applyId=<%=applyId%>";
			printUrl = "../../../jsp/cams/bpt/flow/tested/testedmigrate/ingoingprovince/intoProviPrint.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			updateUrl = "/jsp/cams/bpt/flow/tested/testedmigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="82"){
			//60周岁
			url = "../../../jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			printUrl = "../../../jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviPrint.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			updateUrl = "/jsp/cams/bpt/flow/countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		} else if(serviceType=="B2"){
			//老烈子女
			url = "../../../jsp/cams/bpt/flow/martyroffspring/martymigrate/ingoingprovince/mintoProviDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			printUrl = "../../../jsp/cams/bpt/flow/martyroffspring/martymigrate/ingoingprovince/mintoProviPrint.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>";
			updateUrl = "/jsp/cams/bpt/flow/martyroffspring/martymigrate/ingoingprovince/mintoProviUpdateManage.jsp?applyId=<%=applyId%>&peopleId=<%=peopleId%>&familyId=<%=familyId%>";
		}
	}
	
	//设置环节域的隐藏
function setHide(approveTabPanel){
	var currentDate = getCurDate();
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
				
				sip(BptIntoproviDataset,fieldId,isHidden,isReadOnly);
				
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

function sip(BptIntoproviDataset,fieldId,isHidden,isReadOnly) {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=applyId%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
	//根据是否隐藏和只读给相应环节负责人和日期赋值
				var currentDate = getCurDate();
				//	市级审核
				if(fieldId=="CityVerify"&&isHidden=="0"&&isReadOnly=="0"){
					var cityAduitApproveDate = BptIntoproviDataset.get("cityAduitApproveDate");
					if(ifback){
						BptIntoproviDataset.set("cityAduitApproveDate",currentDate);
					}else if(cityAduitApproveDate == null || cityAduitApproveDate == "") {
						BptIntoproviDataset.set("cityAduitApproveDate",currentDate);
					}
					
					var cityAduitIncharge = BptIntoproviDataset.get("cityAduitIncharge");
					if(cityAduitIncharge == null || cityAduitIncharge == "") {
						BptIntoproviDataset.set("cityAduitIncharge",currentUserName);
					}
				}
				 
				 
				//省厅审批
				if(fieldId=="ProvinceApprove"&&isHidden=="0"&&isReadOnly=="0"){
					var provinceApproveDate = BptIntoproviDataset.get("provinceApproveDate");
					if(provinceApproveDate == null || provinceApproveDate == "") {
						BptIntoproviDataset.set("provinceApproveDate",currentDate);
					}
					
					var provinceIncharge = BptIntoproviDataset.get("provinceIncharge");
					if(provinceIncharge == null || provinceIncharge == "") {
						BptIntoproviDataset.set("provinceIncharge",currentUserName);
					}
					
				}
}


//发送流程
function send(){
	  operation("pass");
}

function end() {
	  operation("end");
}


function operation(value) {
	if(validateNotNull()){
	  if(checkProcessState("send")){
	var BptIntoproviDataset = L5.DatasetMgr.lookup("BptIntoproviDataset");
		var record = BptIntoproviDataset.getCurrent();
	   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	   //执行发送流程方法
	    command.setParameter("record",record);
	    command.setParameter("applyId",'<%=applyId%>');
	    command.setParameter("serviceType",BptIntoproviDataset.get("serviceType"));
	    command.setParameter("contion",value);
	    command.setParameter("actName",'<%=actDefName%>');
	    command.setParameter("currentField",currentField);
	   command.setParameter("peopleId",'<%=peopleId%>');
	   command.execute("send");
	   if(!command.error){
		   alert("成功发送到下一环节!");		
		   window.close();
		   window.returnValue = "success";
		  //if(value == "pass") {  
		   		//跳转到已办任务页面
		 // 		var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		 //  		L5.forward(url,"已办任务页面");
		 //  } else if(value == "end") {
		   		//跳转到结束任务页面
		 //  		var url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
		 //  		L5.forward(url,"结束任务页面");
		 //  }		
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
	if(validateNotNull()) {
	var BptIntoproviDataset = L5.DatasetMgr.lookup("BptIntoproviDataset");
	var record = BptIntoproviDataset.getCurrent();
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	   //执行发送流程方法
	   command.setParameter("record",record);
	    command.setParameter("applyId",'<%=applyId%>');
	    command.setParameter("actName",'<%=actDefName%>');
	    command.setParameter("currentField",currentField);
	   command.execute("back");
	   if(!command.error){
		   alert("成功回退流程!");	
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
			currentField = '<%=fieldId%>';
			var target=document.getElementById("<%=fieldId%>");
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
						  	  		L5.Msg.alert("提示",validateName+"时间格式不正确！");
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

function save(){
		var BptIntoproviDataset = L5.DatasetMgr.lookup("BptIntoproviDataset");
		var record = BptIntoproviDataset.getCurrent();
		var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand"); 
		command.setParameter("record",record);
		command.execute("update");	
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
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
//手动输入时间格式 
function changeDateStyle(obj) {
	var temp = obj.value;
	if(temp!=""&&temp.length == 4) {
		obj.value = temp + '-';
	} else if (temp!=""&&temp.length==7) {
		obj.value = temp + '-';
	} 
}
</script>
</body>
</html>
