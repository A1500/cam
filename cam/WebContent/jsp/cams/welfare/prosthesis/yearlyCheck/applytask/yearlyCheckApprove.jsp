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
		<title>矫装配企业年度检查</title>
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
	<model:dataset id="welfFitApplyDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitApply"></model:record>
	</model:dataset>
</model:datasets>
<iframe id="applyframe" marginwidth=0 marginheight=0 width=100% height=93% src="../info/prosthesisapply1Detail.jsp?method=DETAIL&act=act&taskCode=<%=request.getParameter("primaryKey") %>" frameborder=0></iframe>
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
			<form id="editForm"    onsubmit="return false" dataset="welfFitApplyDataSet" style="padding: 5px;" class="L5form">
				<div id="kcdiv" >
				<table width="98%">
			   		<tr >
			   			<td  class="FieldLabel" style="width:30%">现场勘查情况基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<select style="width:90px;" name="explorationBaseOpinion"  onchange="fillOption(this)"
							 validateName="现场勘查情况基本意见" id="explorationBaseOpinion" field="explorationBaseOpinion">
							<option value="01">同意</option>
							<option value="02">符合条件 同意</option>
							<option value="11">不同意</option>
							<option value="12">不符合条件 不同意</option>
							<option value="2">补齐补正</option>
						</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >现场勘查情况补充意见</td>
						<td class="FieldInput" ><textarea name="explorationAddOpinion" validateName="现场勘查情况补充意见" field="explorationAddOpinion" id="explorationAddOpinion" cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >现场勘查情况审核时间</td>
						<td class="FieldInput" ><input type="text" validateName="现场勘查情况审核时间" format="Y-m-d" style="width: 100px" name="explorationTime" id="explorationTime" field="explorationTime" maxlength="10"  /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >现场勘查人姓名</td>
						<td class="FieldInput" ><input type="text" validateName="现场勘查人姓名" style="width: 90%" name="exploration" id="exploration" field="exploration" maxlength="200"  /></td>
					</tr>
				</table>
			    </div>
			     <div id="kcdiv1" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">现场勘查情况基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<label style="width:90px;" name="cityFlag" id="explorationBaseOpinion" field="explorationBaseOpinion" dataset="wealExpBaseOpinionDs"/>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >现场勘查情况补充意见</td>
						<td class="FieldInput" ><label name="explorationAddOpinion" field="explorationAddOpinion"  cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >现场勘查情况审核时间</td>
						<td class="FieldInput" ><label type="text" validateName="时间"format="Y-m-d" style="width: 100px; name="explorationTime" field="explorationTime" maxlength="10"  /></td>
					</tr>
					<tr>
						<td  class="FieldLabel" >现场勘查人姓名</td>
						<td class="FieldInput" ><label type="text" validateName="现场勘查人姓名" style="width: 90%" name="exploration" id="exploration" field="exploration" maxlength="200"  /></td>
					</tr>
				</table>
			    </div>
			    </br>
			    <div id="zgdiv"  >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">主管审核基本意见</td>
						<td class="FieldInput" style="width:60%">
						<select style="width:90px;" name="chargeBaseOpinion" onchange="fillOption(this)"
							 validateName="主管审核基本意见" id="chargeBaseOpinion" field="chargeBaseOpinion">
							<option dataset="wealBaseOpinionDs"></option>
						</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >主管审核补充意见</td>
						<td class="FieldInput" ><textarea name="chargeAddOpinion" field="chargeAddOpinion"  validateName="主管审核补充意见" cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >主管审核审核时间</td>
						<td class="FieldInput" ><input type="text" validateName="主管审核审核时间"format="Y-m-d" style="width: 100px" name="chargeTime" id="chargeTime" field="chargeTime" maxlength="10"  /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
				</table>
			    </div>
			     <div id="zgdiv1"  >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">主管审核基本意见</td>
						<td class="FieldInput" style="width:60%">
						<label style="width:90px;" name="cityFlag" 
							 id="chargeBaseOpinion" field="chargeBaseOpinion" dataset="wealBaseOpinionDs"/>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >主管审核补充意见</td>
						<td class="FieldInput" ><label name="chargeAddOpinion" field="chargeAddOpinion"  cols="50" rows="8"/> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >主管审核审核时间</td>
						<td class="FieldInput" ><label type="text" validateName="时间"format="Y-m-d" style="width: 100px; name="chargeTime" field="chargeTime" maxlength="10"  /></td>
					</tr>
				</table>
			    </div>
			     </br>
			    <div id="czdiv" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">处长审核基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<select style="width:90px;" name="cityFlag" onchange="fillOption(this)"
							 validateName="处长审核基本意见" id="chiefBaseOpinion" field="chiefBaseOpinion">
							<option dataset="wealBaseOpinionDs"></option>
						</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >处长审核补充意见</td>
						<td class="FieldInput" ><textarea name="chiefAddOpinion" field="chiefAddOpinion"  validateName="处长审核补充意见" cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >处长审核审核时间</td>
						<td class="FieldInput" ><input type="text" validateName="处长审核审核时间"format="Y-m-d" style="width: 100px" name="chiefTime" id="chiefTime" field="chiefTime" maxlength="10"  /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
				</table>
			    </div>
			     <div id="czdiv1" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">处长审核基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<label style="width:90px;" name="cityFlag"  id="chiefBaseOpinion" field="chiefBaseOpinion" dataset="wealBaseOpinionDs"/>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >处长审核补充意见</td>
						<td class="FieldInput" ><label name="chiefAddOpinion" field="chiefAddOpinion"  cols="50" rows="8"/> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >处长审核审核时间</td>
						<td class="FieldInput" ><label type="text" validateName="时间"format="Y-m-d" style="width: 100px; name="chiefTime" field="chiefTime" maxlength="10"  /> </td>
					</tr>
				</table>
			    </div>
			    </br>
			    <div id="tzdiv" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">主管厅长审批基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<select style="width:90px;" name="cityFlag" onchange="fillOption(this)"
							 validateName="主管厅长审批基本意见" id="directorBaseOpinion" field="directorBaseOpinion">
							<option dataset="wealBaseOpinionDs"></option>
						</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >主管厅长审批补充意见</td>
						<td class="FieldInput" ><textarea name="directorAddOpinion" validateName="主管厅长审批补充意见" field="directorAddOpinion"  cols="50" rows="8"></textarea> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >主管厅长审批时间</td>
						<td class="FieldInput" ><input type="text" validateName="主管厅长审批时间"format="Y-m-d" style="width: 100px" name="directorTime" id="directorTime" field="directorTime" maxlength="10"  /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
				</table>
			    </div>
			     <div id="tzdiv1" >
				<table width="98%">
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">主管厅长审批基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<label style="width:90px;" name="cityFlag" id="directorBaseOpinion" field="directorBaseOpinion" dataset="wealBaseOpinionDs"/>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" >主管厅长审批补充意见</td>
						<td class="FieldInput" ><label name="directorAddOpinion" field="directorAddOpinion"  cols="50" rows="8"/> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >主管厅长审批时间</td>
						<td class="FieldInput" ><label type="text" validateName="时间"format="Y-m-d" style="width: 100px; name="directorTime" field="directorTime" maxlength="10"  /></td>
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
	var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
	welfFitApplyDataSet.setParameter("TASK_CODE@=", "<%=taskCode%>");
	welfFitApplyDataSet.load();
	if(actDefName=='补齐补正'){
		document.getElementById("applyframe").src="../info/prosthesisapply1.jsp?method=DETAIL&taskCode="+taskCode;
	}
	
	setHide();
	L5.QuickTips.init(); 
}
function save(){
	var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
	var welfFitApplyValidate = welfFitApplyDataSet.isValidate();
	var fitApplyRecord=welfFitApplyDataSet.getCurrent();
	if(validateNotNull(fitApplyRecord,"")){
		var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
		command.setParameter("record", fitApplyRecord);
		command.execute("saveFitApply");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
}
function send() {
	var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
	var fitApplyRecord=welfFitApplyDataSet.getCurrent();
	var option = "";
	if(actDefName=="现场勘查"){
		option=fitApplyRecord.get("explorationBaseOpinion");
		fitApplyRecord.set("curOpinion",fitApplyRecord.get("explorationAddOpinion"));
	}else if(actDefName=="主管审核"){
		option=fitApplyRecord.get("chargeBaseOpinion");
		fitApplyRecord.set("curOpinion",fitApplyRecord.get("chargeAddOpinion"));
	}else if(actDefName=="处长审核"){
		option=fitApplyRecord.get("chiefBaseOpinion");
		fitApplyRecord.set("curOpinion",fitApplyRecord.get("chiefAddOpinion"));
	}else if(actDefName=="主管厅长审批"){
		option=fitApplyRecord.get("directorBaseOpinion");
		fitApplyRecord.set("curOpinion",fitApplyRecord.get("directorAddOpinion"));
	}
	fitApplyRecord.set("curActivity",actDefName);
	fitApplyRecord.set("curOpinionId",option);
	fitApplyRecord.set("curPeopleName",currentUserName);
	if(validateNotNull(fitApplyRecord,"")){
		var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
		command.setParameter("record", fitApplyRecord);
		command.setParameter("option", option);
		command.execute("sendYearlyCheck");
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
			if(actDefName=="现场勘查"){
				document.getElementById("kcdiv1").style.display = "none";
				document.getElementById("zgdiv1").style.display = "none";
				document.getElementById("czdiv1").style.display = "none";
				document.getElementById("tzdiv1").style.display = "none";
				
			}else if(actDefName=="补齐补正"){
				document.getElementById("kcdiv").style.display = "none";
				document.getElementById("kcdiv1").style.display = "block";
				document.getElementById("zgdiv").style.display = "none";
				document.getElementById("zgdiv1").style.display = "none";
				document.getElementById("czdiv").style.display = "none";
				document.getElementById("czdiv1").style.display = "none";
				document.getElementById("tzdiv").style.display = "none";
				document.getElementById("tzdiv1").style.display = "none";
				
			}else if(actDefName=="主管审核"){
				document.getElementById("kcdiv").style.display = "none";
				document.getElementById("kcdiv1").style.display = "block";
				document.getElementById("zgdiv1").style.display = "none";
				document.getElementById("czdiv1").style.display = "none";
				document.getElementById("tzdiv1").style.display = "none";
				
			}else if(actDefName=="处长审核"){
				document.getElementById("kcdiv").style.display = "none";
				document.getElementById("kcdiv1").style.display = "block";
				document.getElementById("zgdiv").style.display = "none";
				document.getElementById("zgdiv1").style.display = "block";
				document.getElementById("czdiv1").style.display = "none";
				document.getElementById("tzdiv1").style.display = "none";
			}else if(actDefName=="主管厅长审批"){
				document.getElementById("kcdiv").style.display = "none";
				document.getElementById("kcdiv1").style.display = "block";
				document.getElementById("zgdiv").style.display = "none";
				document.getElementById("zgdiv1").style.display = "block";
				document.getElementById("czdiv").style.display = "none";
				document.getElementById("czdiv1").style.display = "block";
				document.getElementById("tzdiv1").style.display = "none";
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
	var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
	var fitApplyRecord=welfFitApplyDataSet.getCurrent();
	if(actDefName=="现场勘查"){
		document.getElementById("explorationTime").value=getCurDate();
		fitApplyRecord.set("explorationTime",getCurDate());
	}else if(actDefName=="主管审核"){
		document.getElementById("chargeTime").value=getCurDate();
		fitApplyRecord.set("chargeTime",getCurDate());
	}else if(actDefName=="处长审核"){
		document.getElementById("chiefTime").value=getCurDate();
		fitApplyRecord.set("chiefTime",getCurDate());
	}else if(actDefName=="主管厅长审批"){
		document.getElementById("directorTime").value=getCurDate();
		fitApplyRecord.set("directorTime",getCurDate());
	}
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}
function getActId(actDefName){
	var actId="";
	if(actDefName=="现场勘查"){
		actId=1;
	}else if(actDefName=="主管审核"){
		actId=2;
	}else if(actDefName=="处长审核"){
		actId=3;
	}else if(actDefName=="主管厅长审批"){
		actId=4;
	}else if(actDefName=="补齐补正"){
		actId=5;
	}
	return actId;
}
function goBack(item) {
	//history.go(-1);
	var url='jsp/cams/welfare/prosthesis/yearlyCheck/applytask/yearlyCheckApprovalList.jsp?actId='+getActId(actDefName);
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
