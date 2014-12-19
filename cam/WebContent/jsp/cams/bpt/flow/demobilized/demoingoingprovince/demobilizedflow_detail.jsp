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
		<title>在乡复员军人审批表编辑</title>
		<next:ScriptManager/>
		<script>
		
			
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
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
					var assignmentId="<%=assignmentId%>";
					var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		function init() {
		var approveTabPanel = L5.getCmp("approveTabPanel");
	approveTabPanel.setTitle('<%=actDefName%>');
						var ds = L5.DatasetMgr.lookup("ds");
										if(processId=="null"){
									ds.setParameter("assignmentId",assignmentId);
								}else{
									ds.setParameter("PROCESS_ID",processId);
								}
							
							ds.load();
							var tabpanel = L5.getCmp("approveTabPanel");
							tabpanel.on("activate",setHide);
					}
		//发送流程
				function send(){
					if(validateNotNull()){
					  if(checkProcessState("send")){
					   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand");
					   //执行发送流程方法
					   command.setParameter("assignmentId",assignmentId);
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
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand");
	 command.setParameter("assignmentId",assignmentId);
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
function save(){
var ds = L5.DatasetMgr.lookup("ds");
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var records = ds.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand"); 
	command.setParameter("records",records);
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

	
					
		</script>
		<script type="text/javascript" src="demobilizedflow_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.DemobilizedflowQueryCommand" method="query2">
		<model:record fromBean="com.inspur.cams.bpt.base.data.Demobilizedflow"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="false">
<next:Tabs>
	<next:TabPanel>
	<%
	String peopleId=null;
	String familyId=null;	
	Map<String, Object> Idmap = new HashMap<String, Object>();
		BptBaseinfoPeopleQueryCommand command= new BptBaseinfoPeopleQueryCommand();
				String  processId = (String)request.getParameter("processId");
				Idmap = command.queryPeopleByProcessId(processId);
				peopleId =(String) Idmap.get("peopleId");
				familyId =(String) Idmap.get("familyId");
	%>
<next:Panel width="100%" id="demobilizedTabPanel" title="在乡复员军人信息表" height="100%">
				
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/demobilized/demobilized/demobilizedFlowHeader.jsp?peopleId=<%=peopleId%>&familyId=<%=familyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>			
</next:Panel>	

<next:Panel  title="在乡复员申请审批" height="100%" width="100%" id="approveTabPanel" autoScroll="true" >
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
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<div>
			<table  style="display:none">
			
			<tr>
				<td  class="FieldLabel" >录入时间</td>
				<td class="FieldInput"><input type="text" name="interDate" field="interDate" format="Y-m-d" onclick="LoushangDate(this)" /> </td>
				
				<td  class="FieldLabel" >修改人</td>
				<td class="FieldInput"><input type="text" name="changeId" field="changeId"  /> </td>
			
				<td  class="FieldLabel" >修改日期</td>
				<td class="FieldInput"><input type="text" name="changeDate" field="changeDate" format="Y-m-d" onclick="LoushangDate(this)" /> </td>
			</tr>
			
	   		<tr>
				<td  class="FieldLabel" >申请ID</td>
				<td class="FieldInput"><input type="text" name="applyId" field="applyId"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >录入人ID</td>
				<td class="FieldInput"><input type="text" name="interId" field="interId"  /><font color="red">*</font> </td>
				
				<td  class="FieldLabel" >人员ID</td>
				
				<td class="FieldInput"><input type="text" name="peopleId" field="peopleId"  /> </td>
			</tr>

			<tr>
				<td  class="FieldLabel" >姓名</td>
				<td class="FieldInput"><input type="text" name="name" field="name"  /> </td>
				
				<td  class="FieldLabel" >性别</td>
				<td class="FieldInput"><input type="text" name="sex" field="sex"  /> </td>	
				
				<td  class="FieldLabel" >出生日期</td>
				<td class="FieldInput"><input type="text" name="birthday" field="birthday" format="Y-m-d" onclick="LoushangDate(this)" /> </td>	
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" >证件类型</td>
				<td class="FieldInput"><input type="text" name="documentsType" field="documentsType"  /> </td>
				
				<td  class="FieldLabel" >身份证号码</td>
				<td class="FieldInput"><input type="text" name="idCard" field="idCard"  /> </td>
			
				<td  class="FieldLabel" >户籍地址</td>
				<td class="FieldInput"><input type="text" name="household" field="household"  /> </td>
			</tr>
				<tr>
	   			<td  class="FieldLabel" >原部队代号</td>
				<td class="FieldInput"><input type="text" name="designation" field="designation"  /> </td>
				
				<td  class="FieldLabel" >原部队职务</td>
				<td class="FieldInput"><input type="text" name="position" field="position"  /> </td>
			
				<td  class="FieldLabel" >复员证字号</td>
				<td class="FieldInput"><input type="text" name="demobilizeId" field="demobilizeId"  /> </td>
			</tr>	
	   		<tr>
				<td  class="FieldLabel" >优抚对象类别</td>
				<td class="FieldInput"><input type="text" name="objectType" field="objectType"  /> </td>
			
				<td  class="FieldLabel" >优抚对象状态标志</td>
				<td class="FieldInput"><input type="text" name="objectMark" field="objectMark"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >入伍日期</td>
				<td class="FieldInput"><input type="text" name="armyDate" field="armyDate"  format="Y-m-d" onclick="LoushangDate(this)"/> </td>
				
				<td  class="FieldLabel" >复员日期</td>
				<td class="FieldInput"><input type="text" name="demobilize" field="demobilize" format="Y-m-d" onclick="LoushangDate(this)" /> </td>
			
			</tr>
			</table>
	   	</div>
		
			<div id="town">
			<table border="1"  width="100%" >	
	   		<tr>
				
						<td  class="FieldLabel" >乡镇初审意见</td>
						<td class="FieldInput" colspan="3"><label name="townViews" field="townViews" rows="3" title="乡镇初审意见" style="width:80%"></label> </td>
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >初审人</td>
				<td class="FieldInput"></td><label name="trialName" field="trialName" rows="3" title="初审人"></label> </td>
				<td  class="FieldLabel" >初审日期</td>
				<td class="FieldInput"><label name="trialDate" field="trialDate" title="初审日期"></label> </td>
			</tr>
			</table>
				</div>
		
			<div id="counties">
			<table border="1"  width="100%" >
			<tr>
				<td  class="FieldLabel" >县区复审意见</td>
				<td class="FieldInput" colspan="3"><label name="countiesViews" field="countiesViews" rows="3" title="县区复审意见" style="width:80%"></label> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >复审人</td>
				<td class="FieldInput"><label name="reviewView" field="reviewView" rows="3" title="复审人" ></label> </td>
			
				<td  class="FieldLabel" >复审日期</td>
				<td class="FieldInput"><label name="reviewDate" field="reviewDate" title="复审日期"></label> </td>
			</tr>
			</table>
			</div>	
			<div id="city">
				<table border="1"  width="100%" >
			   		<tr>
						<td  class="FieldLabel" >地市审批意见</td>
						<td class="FieldInput" colspan="3"><label name="citiesViews" field="citiesViews" rows="3" title="地市审批意见" style="width:80%"></label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >审批人</td>
						<td class="FieldInput"><label name="approvalName" field="approvalName" rows="3" title="审批人" style="width:80%"></label> </td>
						<td  class="FieldLabel" >审批日期</td>
						<td class="FieldInput"><label name="approvalDate" field="approvalDate" title="审批日期"></label> </td>
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
</html>
