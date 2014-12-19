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
		<title>矫装配企业申请_审批</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
		<style type="text/css">
				#floatBottom{
					position: relative;
					border: 1px solid #8DB2E3;
					background-color: #EFEFEF;
					line-height:90px;
					font-size:12px;
					z-index:1001;
					width:100%;
					height:30px;
				}
		</style> 
		<script>
				<%
					String taskCode=request.getParameter("primaryKey");
					String primaryKey=request.getParameter("primaryKey");
					//System.out.println(primaryKey);
				    if(primaryKey==null)
				    	primaryKey="";
					String assignmentId=(String)request.getParameter("assignmentId");
					String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
					String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
					//然调用接口
					WfQuery wfQuery = new WfQuery();
					//List<Map> list = wfQuery.getActButtons(actDefUniqueId);
					List<Map> list1=wfQuery.getActFields(actDefUniqueId);
				
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
				 
				var actDefName = '<%=actDefName%>';
				var taskCode = '<%=request.getParameter("primaryKey") %>';
			</script>
		</head>
<body>
<model:datasets>
	<!-- 基本意见 -->
	<model:dataset id="wealBaseOpinionDs" enumName="WEAL.BASE_OPINION" autoLoad="true" global="true"></model:dataset>
	<!-- 现场勘查基本意见 -->
	<model:dataset id="wealExpBaseOpinionDs" enumName="WEAL.EXPLORATION_BASE_OPINION" autoLoad="true" global="true"></model:dataset>
	<!-- 业务表 -->
	<model:dataset id="welfUnitApplyDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealUnitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 是否-->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<iframe id="applyframe" marginwidth=0 marginheight=0 width=100% height=93% src="../detail/welfareapply1Detail.jsp?method=DETAIL&taskCode=<%=request.getParameter("primaryKey") %>" frameborder=0></iframe>
	<div id="floatBottom" style="height:7%">
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="审核" style="height:25px;width:80px;position:absolute;margin-left:30%;"  onclick="win_show()"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:60%;" onclick="goBack()"/>
	</div>

<next:Window id="approveInfo" title='审批信息' resizable="false"
	width="460" height="430" lazyRender="false" closable="false">
	<next:FitLayout>
		<next:Panel id="fextend" border="false" autoScroll="true" >
			<next:Html>
			<form id="editForm"    onsubmit="return false" dataset="welfUnitApplyDataSet" style="padding: 5px;" class="L5form">
				<div id="xzgdiv" >
				<table width="98%">
			   		<tr >
			   			<td  class="FieldLabel" style="width:30%">县级主管审核基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<select style="width:130px;" name="countyChargeBaseOpinion"  onchange="fillOption(this)"
							 validateName="县级主管审核基本意见" id="countyChargeBaseOpinion" field="countyChargeBaseOpinion">
							<option dataset="wealBaseOpinionDs"></option>
						</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级主管审核补充意见</td>
						<td class="FieldInput" ><textarea name="countyChargeAddOpinion" validateName="县级主管审核补充意见" field="countyChargeAddOpinion" id="countyChargeAddOpinion" cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级主管审核时间</td>
						<td class="FieldInput" ><input type="text" validateName="县级主管审核时间" format="Y-m-d" style="width: 100px" name="countyChargeTime" id="countyChargeTime" field="countyChargeTime" maxlength="10"  /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
				</table>
			    </div>
			    <div id="xzgdiv1" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">县级主管审核基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<label style="width:90px;" name="cityFlag" id="countyChargeBaseOpinion" field="countyChargeBaseOpinion" dataset="wealBaseOpinionDs"/>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级主管审核补充意见</td>
						<td class="FieldInput" ><label name="countyChargeAddOpinion" field="countyChargeAddOpinion"  cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级主管审核时间</td>
						<td class="FieldInput" ><label type="text" validateName="时间"format="Y-m-d" style="width: 100px; name="countyChargeTime" field="countyChargeTime" maxlength="10"  /></td>
					</tr>
				</table>
			    </div>
			    </br>
			    <div id="xjzdiv"  >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">县级局长审批基本意见</td>
						<td class="FieldInput" style="width:60%">
						<select style="width:130px;" name="countyChiefBaseOpinion" onchange="fillOption(this)"
							 validateName="县级局长审批基本意见" id="countyChiefBaseOpinion" field="countyChiefBaseOpinion">
							<option dataset="wealBaseOpinionDs"></option>
						</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级局长审批补充意见</td>
						<td class="FieldInput" ><textarea name="countyChiefAddOpinion" field="countyChiefAddOpinion"  validateName="县级局长审批补充意见" cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级局长审批时间</td>
						<td class="FieldInput" ><input type="text" validateName="县级局长审批时间"format="Y-m-d" style="width: 100px" name="countyChiefTime" id="countyChiefTime" field="countyChiefTime" maxlength="10"  /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >是否提交至市级审核</td>
						<td class="FieldInput" ><select id="approvalLevel" field="approvalLevel" validateName="是否提交至市级审核" style="width:130px;">
					<option dataset="comm_yesorno"></option>
				</select></td>
					</tr>
				</table>
			    </div>
			    <div id="xjzdiv1"  >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">县级局长审批基本意见</td>
						<td class="FieldInput" style="width:60%">
						<label style="width:90px;" name="cityFlag" 
							 id="countyChiefBaseOpinion" field="countyChiefBaseOpinion" dataset="wealBaseOpinionDs"/>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级局长审批补充意见</td>
						<td class="FieldInput" ><label name="countyChiefAddOpinion" field="countyChiefAddOpinion"  cols="50" rows="8"/> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级局长审批时间</td>
						<td class="FieldInput" ><label type="text" validateName="时间"format="Y-m-d" style="width: 100px; name="countyChiefTime" field="countyChiefTime" maxlength="10"  /></td>
					</tr>
				</table>
			    </div>
			     </br>
			    <div id="szgdiv" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">市级主管审核基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<select style="width:130px;" name="cityChargeBaseOpinion" onchange="fillOption(this)"
							 validateName="市级主管审核基本意见" id="cityChargeBaseOpinion" field="cityChargeBaseOpinion">
							<option dataset="wealBaseOpinionDs"></option>
						</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >市级主管审核补充意见</td>
						<td class="FieldInput" ><textarea name="cityChargeAddOpinion" field="cityChargeAddOpinion"  validateName="市级主管审核补充意见" cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >市级主管审核时间</td>
						<td class="FieldInput" ><input type="text" validateName="市级主管审核时间"format="Y-m-d" style="width: 100px" name="cityChargeTime" id="cityChargeTime" field="cityChargeTime" maxlength="10"  /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
				</table>
			    </div>
			     <div id="szgdiv1" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">市级主管审核基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<label style="width:90px;" name="cityFlag"  id="cityChargeBaseOpinion" field="cityChargeBaseOpinion" dataset="wealBaseOpinionDs"/>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >市级主管审核补充意见</td>
						<td class="FieldInput" ><label name="cityChargeAddOpinion" field="cityChargeAddOpinion"  cols="50" rows="8"/> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >市级主管审核时间</td>
						<td class="FieldInput" ><label type="text" validateName="时间"format="Y-m-d" style="width: 100px;" name="cityChargeTime" field="cityChargeTime" maxlength="10"  /> </td>
					</tr>
				</table>
			    </div>
			    </br>
			    <div id="sjzdiv" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">市级局长审批基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<select style="width:130px;" name="cityChiefBaseOpinion" onchange="fillOption(this)"
							 validateName="市级局长审批基本意见" id="cityChiefBaseOpinion" field="cityChiefBaseOpinion">
							<option dataset="wealBaseOpinionDs"></option>
						</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >市级局长审批补充意见</td>
						<td class="FieldInput" ><textarea name="cityChiefAddOpinion" validateName="市级局长审批补充意见" field="cityChiefAddOpinion"  cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >市级局长审批时间</td>
						<td class="FieldInput" ><input type="text" validateName="市级局长审批时间"format="Y-m-d" style="width: 100px" name="cityChiefTime" id="cityChiefTime" field="cityChiefTime" maxlength="10"  /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
				</table>
			    </div>
			    <div id="sjzdiv1" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">市级局长审批基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<label style="width:90px;" name="cityFlag" id="cityChiefBaseOpinion" field="cityChiefBaseOpinion" dataset="wealBaseOpinionDs"/>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >市级局长审批补充意见</td>
						<td class="FieldInput" ><label name="cityChiefAddOpinion" field="cityChiefAddOpinion"  cols="50" rows="8"/> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >市级局长审批时间</td>
						<td class="FieldInput" ><label type="text" validateName="时间"format="Y-m-d" style="width: 100px;" name="cityChiefTime" field="cityChiefTime" maxlength="10"  /></td>
					</tr>
				</table>
			    </div>
			    </br>
			    
			    </form>
			</next:Html>
		</next:Panel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="保存" handler="save" id="saveButton"></next:ToolButton>
		<next:ToolButton text="提交" handler="send" id="sendButton"></next:ToolButton>
		<next:ToolButton text="关闭" handler="win_close"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
<script>
function init() {
	var welfUnitApplyDataSet = L5.DatasetMgr.lookup("welfUnitApplyDataSet");
	welfUnitApplyDataSet.setParameter("TASK_CODE@=", "<%=taskCode%>");
	welfUnitApplyDataSet.load();

	setHide();
	L5.QuickTips.init(); 
}
function save(){
	var welfUnitApplyDataSet = L5.DatasetMgr.lookup("welfUnitApplyDataSet");
	var welfFitApplyValidate = welfUnitApplyDataSet.isValidate();
	var unitApplyRecord=welfUnitApplyDataSet.getCurrent();
	if(validateNotNull(unitApplyRecord,"")){
		var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyCmd");
		command.setParameter("record", unitApplyRecord);
		command.execute("saveUnitApply");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
}
function send() {
	var welfUnitApplyDataSet = L5.DatasetMgr.lookup("welfUnitApplyDataSet");
	var unitApplyRecord=welfUnitApplyDataSet.getCurrent();
	var option = "";
	var direction="";//流程走向
	if(actDefName=="县级主管审核"){
		option=unitApplyRecord.get("countyChargeBaseOpinion");
		unitApplyRecord.set("curOpinion",unitApplyRecord.get("countyChargeAddOpinion"));
	}else if(actDefName=="县级局长审批"){
		option=unitApplyRecord.get("countyChiefBaseOpinion");
		direction=unitApplyRecord.get("approvalLevel");
		unitApplyRecord.set("curOpinion",unitApplyRecord.get("countyChiefAddOpinion"));
	}else if(actDefName=="市级主管审核"){
		option=unitApplyRecord.get("cityChargeBaseOpinion");
		unitApplyRecord.set("curOpinion",unitApplyRecord.get("cityChargeAddOpinion"));
	}else if(actDefName=="市级局长审批"){
		option=unitApplyRecord.get("cityChiefBaseOpinion");
		unitApplyRecord.set("curOpinion",unitApplyRecord.get("cityChiefAddOpinion"));
	}
	unitApplyRecord.set("curActivity",actDefName);
	unitApplyRecord.set("curOpinionId",option);
	unitApplyRecord.set("curPeopleName",currentUserName);
	if(validateNotNull(unitApplyRecord,"")){
		var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyCmd");
		command.setParameter("record", unitApplyRecord);
		command.setParameter("option", option);
		command.setParameter("direction", direction);
		command.setParameter("actDefName", actDefName);
		command.execute("sendQualification");
		if(!command.error){
			/* if(actId=='5' || end){//是发证环节流程结束
				L5.Msg.alert("提示","成功结束流程!",function(){
					window.history.go(-1);
				});
			}else{ */
				L5.Msg.alert("提示","成功提交至下一环节!",function(){
					//window.history.go(-1);
					goBack();
				});
			//}
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		}
	}
	
}
var ifApplyActive = true;
//设置环节域的隐藏
function setHide(){
		if(ifApplyActive) {
		//document.getElementById("TownVerifyFlag").disabled=true;
	<%
	//遍历list1
	for(int i=0;i<list1.size();i++){
		Map map1=(Map)list1.get(i);
		fieldId=(String)map1.get("fieldId");
	 
		isHidden=(String)map1.get("isHidden");
		isReadOnly=(String)map1.get("isReadOnly");
	 %>
				var fieldId = '<%=fieldId%>';
				var isHidden = '<%=isHidden%>';
				var isReadOnly = '<%=isReadOnly%>';
			 	var target=document.getElementById("<%=fieldId%>");
				if(target){
					target.style.display="";
				}	
			 
			 	//sip(DisabilityApproveDataset,fieldId,isHidden,isReadOnly);
				
			if(isHidden == "1") { // 判断是否为隐藏
				//if(!ifback) { // 判断是否为退回操作
					var target=document.getElementById("<%=fieldId%>");
						if(target){
							target.style.display="none";
						}	
				/* } else {
					isReadOnly = "1";
				} */				 		     
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
						var imgs = target.getElementsByTagName("img");
						for(var i=0;i<imgs.length;i++)
						{				  	
							imgs[i].style.display = "none";												
						}
					}		
			}
			if(actDefName=="县级主管审核"){
				document.getElementById("xzgdiv1").style.display = "none";
				document.getElementById("xjzdiv1").style.display = "none";
				document.getElementById("szgdiv1").style.display = "none";
				document.getElementById("sjzdiv1").style.display = "none";
				
			}else if(actDefName=="县级局长审批"){
				document.getElementById("xzgdiv").style.display = "none";
				document.getElementById("xzgdiv1").style.display = "block";
				document.getElementById("xjzdiv1").style.display = "none";
				document.getElementById("szgdiv1").style.display = "none";
				document.getElementById("sjzdiv1").style.display = "none";
				
			}else if(actDefName=="市级主管审核"){
				document.getElementById("xzgdiv").style.display = "none";
				document.getElementById("xzgdiv1").style.display = "block";
				document.getElementById("xjzdiv").style.display = "none";
				document.getElementById("xjzdiv1").style.display = "block";
				document.getElementById("szgdiv1").style.display = "none";
				document.getElementById("sjzdiv1").style.display = "none";
			}else if(actDefName=="市级局长审批"){
				document.getElementById("xzgdiv").style.display = "none";
				document.getElementById("xzgdiv1").style.display = "block";
				document.getElementById("xjzdiv").style.display = "none";
				document.getElementById("xjzdiv1").style.display = "block";
				document.getElementById("szgdiv").style.display = "none";
				document.getElementById("szgdiv1").style.display = "block";
				document.getElementById("sjzdiv1").style.display = "none";
			}
	<%	
	}
	%>
		ifApplyActive = false;	
	}
	
}
function fillOption(obj){
	for(i=0;i<obj.length;i++){
		   if(obj[i].selected==true){
			   obj.parentNode.parentNode.nextSibling.childNodes[1].childNodes[0].value=obj[i].innerText; 
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
function win_close() {
	var win = L5.getCmp("approveInfo");
	win.hide();
}
function win_show() {
	var conditionSelect = L5.getCmp("approveInfo");
	conditionSelect.show();
	var welfUnitApplyDataSet = L5.DatasetMgr.lookup("welfUnitApplyDataSet");
	var unitApplyRecord=welfUnitApplyDataSet.getCurrent();
	if(actDefName=="县级主管审核"){
		document.getElementById("countyChargeTime").value=getCurDate();
		unitApplyRecord.set("countyChargeTime",getCurDate());
		unitApplyRecord.set("countyCharge",'<%=GetBspInfo.getBspInfo().getUserName()%>');
	}else if(actDefName=="县级局长审批"){
		document.getElementById("countyChiefTime").value=getCurDate();
		unitApplyRecord.set("countyChiefTime",getCurDate());
		unitApplyRecord.set("countyChief",'<%=GetBspInfo.getBspInfo().getUserName()%>');
	}else if(actDefName=="市级主管审核"){
		document.getElementById("cityChargeTime").value=getCurDate();
		unitApplyRecord.set("cityChargeTime",getCurDate());
		unitApplyRecord.set("cityCharge",'<%=GetBspInfo.getBspInfo().getUserName()%>');
	}else if(actDefName=="市级局长审批"){
		document.getElementById("cityChiefTime").value=getCurDate();
		unitApplyRecord.set("cityChiefTime",getCurDate());
		unitApplyRecord.set("cityChief",'<%=GetBspInfo.getBspInfo().getUserName()%>');
	}
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}
function getActId(actDefName){
	var actId="";
	if(actDefName=="县级主管审核"){
		actId=1;
	}else if(actDefName=="县级局长审批"){
		actId=2;
	}else if(actDefName=="市级主管审核"){
		actId=3;
	}else if(actDefName=="市级局长审批"){
		actId=4;
	}
	return actId;
}
function goBack(item) {
	//history.go(-1);
	var url='jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/applytask/unitQualificationApprovalList.jsp?actId='+getActId(actDefName);
	L5.forward(url);
}
//校验非空的域是否为空
function validateNotNull(record,ifback){
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
			currentField = "<%=fieldId%>";
			if(target){
				var inputs = target.getElementsByTagName("input"); // 验证input标签
				for(var i=0;i<inputs.length;i++) {
					 if(inputs[i].type=="text") {
					 	  var inputValue = inputs[i].value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(inputs[i].getAttribute("validateName")+"不能为空!");
						  	  return false;
						  }
						  if( inputs[i].getAttribute("validateName").indexOf("时间")!=-1){
						  	if(!validateDateFormat(inputs[i].value)){
						  		alert(inputs[i].getAttribute("validateName")+"格式错误!");
						  	  return false;
						  	}
						  }
					 }
				}
				var selects = target.getElementsByTagName("select");// 验证select标签
				for(var i=0;i<selects.length;i++) {	
					  var selectObj = selects[i];
					  var validateName = selectObj.getAttribute("validateName");
					  if(validateName != null && validateName != "") {
					 	  var inputValue = selectObj.value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(validateName+"不能为空!");
						  	  return false;
						  } 
					  }	  
				}
				var textareas = target.getElementsByTagName("textarea");// 验证textarea标签
				for(var i=0;i<textareas.length;i++) {	
					  var areaObj = textareas[i];
					  var validateName = areaObj.getAttribute("validateName");
					  if(validateName != null && validateName != "") {
					 	  var inputValue = areaObj.value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(validateName+"不能为空!");
						  	  return false;
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
</script>
</html>
