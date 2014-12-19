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
	
	var trialDate = document.getElementById("trialDate").value;
	if(trialDate!=''&&!validateDateFormat(trialDate)){
		L5.Msg.alert("提示","乡镇初审日期格式不正确！");
		return false;
	}
	
	var reviewDate = document.getElementById("reviewDate").value;
	if(reviewDate!=''&&!validateDateFormat(reviewDate)){
		L5.Msg.alert("提示","县区复审日期格式不正确！");
		return false;
	}
	
	var approvalDate = document.getElementById("approvalDate").value;
	if(approvalDate!=''&&!validateDateFormat(approvalDate)){
		L5.Msg.alert("提示","地市审批日期格式不正确！");
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

	function validateDateFormat(date) {
		if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
			return false;
		}
		var r = date.match(/\d{1,4}/g);
		if (r == null) {
			return false;
		};
		var d = new Date(r[0], r[1] - 1, r[2]);
		return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d.getDate() == r[2]);
	}

	function getTimes(item) {
		LoushangDate(item.previousSibling);
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
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/demobilized/applydemobilized/demobilizedFlowHeader.jsp?peopleId=<%=peopleId%>&familyId=<%=familyId%>"
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
			<div id="counties">
			<table border="1"  width="100%" >	
	   		<tr>
				
						<td  class="FieldLabel" >乡镇初审意见</td>
						<td class="FieldInput" colspan="3"><textarea type="text" name="townViews" field="townViews" style="width:80%" rows="4"></textarea> </td>
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >初审人</td>
				<td class="FieldInput"><input type="text" name="trialName" field="trialName"  /> </td>
				<td  class="FieldLabel" >初审日期</td>
				<td class="FieldInput"><input type="text" name="trialDate" field="trialDate" id="trialDate"  format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > </td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >县区复审意见</td>
				<td class="FieldInput" colspan="3"><textarea type="text" name="countiesViews" field="countiesViews" style="width:80%" rows="4"></textarea> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >复审人</td>
				<td class="FieldInput"><input type="text" name="reviewView" field="reviewView"  /> </td>
			
				<td  class="FieldLabel" >复审日期</td>
				<td class="FieldInput"><input type="text" name="reviewDate" field="reviewDate"  id="reviewDate" format="Y-m-d" style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > </td>
			</tr>
			</table>
			</div>
			<div id="city">
				<table border="1"  width="100%" >
			   		<tr>
						<td  class="FieldLabel" >地市审批意见</td>
						<td class="FieldInput" colspan="3"><textarea type="text" name="citiesViews" field="citiesViews" style="width:80%" rows="4"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >审批人</td>
						<td class="FieldInput"><input type="text" name="approvalName" field="approvalName"  /> </td>
						<td  class="FieldLabel" >审批日期</td>
						<td class="FieldInput"><input type="text" name="approvalDate" field="approvalDate"  id="approvalDate"format="Y-m-d" style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > </td>
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
<script>
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
</body>
</html>
