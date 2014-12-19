function init() {
	var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
	AssistiveDevicesPrDataset.setParameter("process_Id",processId);
	AssistiveDevicesPrDataset.load();
	setHide();
	L5.QuickTips.init(); 
}



function save(){
	var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
	var AssistiveDevicesPrRecord=AssistiveDevicesPrDataset.getCurrent();
	
	var isValidate = AssistiveDevicesPrDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrCommand");
	command.setParameter("record", AssistiveDevicesPrRecord);
	command.execute("update");
	if (!command.error) {
		AssistiveDevicesPrDataset.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//设置环节域的隐藏
function setHide(){
	<%
	//遍历list1
	for(int i=0;i<list1.size();i++){
		Map map1=(Map)list1.get(i);
		fieldId=(String)map1.get("fieldId");
		isHidden=(String)map1.get("isHidden");
		isReadOnly=(String)map1.get("isReadOnly");
		//如果需要隐藏，则设置隐藏域的style为none
		if("1".equals(isHidden)){
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
				
				}		
						
				<%
			}
		}
	}
	%>	
}


//发送流程
function send(){
	if(validateNotNull()){
	  if(checkProcessState("send")){
	   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrCommand");
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
//通过流转状态图回退流程
function backByState(){
	var url = L5.webPath+"/jsp/workflow/monitor/flowview.jsp?procDefUniqueId="
    +procDefUniqueId+"&assignmentId="+assignmentId+"&actionType=back&isShowBackBtn=false";
    var returnValue=showModalDialog(url, window,
	"scroll:yes;resizable:yes;dialogWidth:900px;dialogHeight:600px");
	if(!returnValue){
		return;
	}
	var procDefUniqueId=returnValue[0].procDefUniqueId;
	var actDefId=returnValue[0].actDefId;
	var actName=returnValue[0].actName;
	alert("procDefUniqueId:"+procDefUniqueId+";actDefId:"+actDefId+";actName:"+actName);	
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