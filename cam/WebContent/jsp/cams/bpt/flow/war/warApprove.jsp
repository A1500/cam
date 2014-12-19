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
		<title>参战人员申请_审批编辑</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
				<script>
					var ifsave = true;
					<%
						String primaryKey=request.getParameter("primaryKey");
					    if(primaryKey==null)
					    	primaryKey="";
					%>
					<%
						String assignmentId=(String)request.getParameter("assignmentId");
						String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
						String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
						//然调用接口
						List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
						List<Map> list1=new WfQuery().getActFields(actDefUniqueId);
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
				
					<%
						Map<String, String> Idmap = new HashMap<String, String>();
							BptBaseinfoPeopleQueryCommand command= new BptBaseinfoPeopleQueryCommand();
									String  processId = request.getParameter("processId");
									Idmap = command.queryPeopleByProcessId(processId,assignmentId);
									String peopleId =Idmap.get("peopleId");
									String familyId =Idmap.get("familyId");
									String applyId = Idmap.get("applyId");
					%>
					
					<% 
					//从后台获取环节按钮权限，显示要显示按钮
					for(int i=0;i<list.size();i++){
					Map map=(Map)list.get(i);
					String buttonName=(String)map.get("buttonName");
					if("保存".equals(buttonName)) {
					%>		
							ifsave = false;
					<% 
						}
					 
					}
					%>
				</script>
		</head>
<body>
<model:datasets>
	<model:dataset id="DependantApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDependantQueryCommand" method="queryApplyDependant" global="true">
	</model:dataset>
	
	<!-- 参战类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	 
	
</model:datasets>


<next:Panel width="100%" height="100%" autoScroll="false">
<next:Tabs>
	<next:TabPanel>
	<next:Panel width="100%" id="peopleTabPanel" title="基本信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/peopleDetail.jsp?peopleId=<%=peopleId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="typeTabPanel" title="类别信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/comm/warTypeDetail.jsp?familyId='<%=(String)request.getParameter("processId")%>'&assignmentId='<%= (String)request.getParameter("assignmentId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="menberTabPanel" title="家庭成员信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/memberListDetail.jsp?familyId='<%=familyId%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="houseTabPanel" title="住房信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/houseDetail.jsp?familyId='<%=familyId%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>

<next:Panel  title="审批信息" height="100%" width="100%" id="approveTabPanel" autoScroll="true" >
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
		<form id="editForm"   dataset="DependantApproveDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="0"  width="99%" >
			<div>
				<table width="99%">
			   		<tr>
						<td  class="FieldLabel" colspan="2">申请时间</td>
						<td class="FieldInput" style="width:30%"><label type="text" name="approve_date" field="APPROVE_DATE"/></td>
					
						<td  class="FieldLabel" style="width:20%">申请机构</td>
						<td class="FieldInput" style="width:30%"><label type="text" name="approve_organ_id" field="APPROVE_ORGAN_ID"/></td>
					</tr>
				</table>
			</div>
				<br>
				
			<div id="TownVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="4" nowrap="nowrap">县级审核</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><input type="text" name="verify_incharge" field="TOWN_ADUIT_INCHARGE" readonly="readonly" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input type="text" name="verify__approve_date" field="TOWN_ADUIT_APPROVE_DATE" readonly="readonly"  /> </td>
					</tr>
					
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3"><textarea name="verify_advice" field="TOWN_ADUIT_ADVICE" style="width:80%" rows="2"></textarea> </td>
					</tr>
				</table>
			</div>
		</table>
		</form>
   </next:Html>
</next:Panel>

	</next:TabPanel>
</next:Tabs>

</next:Panel>
</body>
<script>
function init() {
	var DependantApproveDataset = L5.DatasetMgr.lookup("DependantApproveDataset");
	if(processId=="null"){
		DependantApproveDataset.setParameter("assignmentId",assignmentId);
	}else{
		DependantApproveDataset.setParameter("processId",processId);
	}
	DependantApproveDataset.load();
	
	var tabpanel = L5.getCmp("approveTabPanel");
	tabpanel.on("activate",setHide);
	
	L5.QuickTips.init(); 
}

function updateInfo() { //修改申请信息
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
	var url = L5.webPath+"/jsp/cams/bpt/flow/war/bptwar_edit.jsp?peopleId=" + peopleId + "&familyId=" + familyId;
	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.location.reload();	
}


function save(){
	var DependantApproveDataset = L5.DatasetMgr.lookup("DependantApproveDataset");
	var DependantApproveRecord=DependantApproveDataset.getCurrent();
	
	var isValidate = DependantApproveDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDependantCommand");
	command.setParameter("record", DependantApproveRecord);
	command.execute("update");
	if (!command.error) {
		DependantApproveDataset.commitChanges();
		ifsave = true;
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//设置环节域的隐藏
function setHide(approveTabPanel){
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
				//县级审核
				if(fieldId=="TownVerify"&&isHidden=="0"&&isReadOnly=="0"){
					DependantApproveDataset.set("TOWN_ADUIT_APPROVE_DATE",currentDate);
					DependantApproveDataset.set("TOWN_ADUIT_INCHARGE",currentUserName);
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
				}		
						
				<%
			}
		}
	}
	%>	
}


//发送流程
function send(){
	if(!ifsave) {
		L5.Msg.alert("提示","请先保存审批信息!");
		return false;
	}
	if(validateNotNull()){
	  if(checkProcessState("send")){
	   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDependantCommand");
	   
	   command.setParameter("object_type",DependantApproveDataset.get("OBJECT_TYPE"));
	   command.setParameter("peopleId",DependantApproveDataset.get("PEOPLE_ID"));
	   //执行发送流程方法
	   command.execute("send");
	   if(!command.error){
		   alert("成功发送到下一环节!");		  
		   //跳转到已办任务页面
		   var url = "jsp/workflow/tasklist/queryyiban.jsp";
		   L5.forward(url,"已办任务页面");
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
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDependantCommand");
	   //执行发送流程方法
	   command.execute("back");
	   if(!command.error){
		   alert("成功回退流程!");		  
		   //跳转到已办任务页面
		   var url = "jsp/workflow/tasklist/queryyiban.jsp";
		   L5.forward(url,"已办任务页面");
	   }else{
	      alert(command.error);
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
			var value=document.getElementById("<%=fieldId%>").value;
			if(value==null||value==""){
				alert("<%=fieldName%>"+"不能为空!");
				return false;
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
</script>
</html>
