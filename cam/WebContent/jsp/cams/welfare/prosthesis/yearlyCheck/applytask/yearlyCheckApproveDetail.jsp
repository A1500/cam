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
<iframe id="frame" marginwidth=0 marginheight=0 width=100% height=93% src="../info/prosthesisapply1Detail.jsp?method=DETAIL&taskCode=<%=request.getParameter("primaryKey") %>" frameborder=0></iframe>
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
			   		<tr>
			   			<td  class="FieldLabel" style="width:30%">现场勘查情况基本意见</td>
						<td class="FieldInput" style="width:60%" >
						<label style="width:90px;" name="cityFlag" id="explorationBaseOpinion" field="explorationBaseOpinion" dataset="wealExpBaseOpinionDs"/>
						</select>
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
				</table>
			    </div>
			    </br>
			    <div id="zgdiv"  >
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
			    </form>
			</next:Html>
		</next:Panel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="win_close"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
<script>
function init() {
	var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
	welfFitApplyDataSet.setParameter("TASK_CODE@=", "<%=taskCode%>");
	welfFitApplyDataSet.load();
	setHide();
	L5.QuickTips.init(); 
}
function save(){
	var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
	var welfFitApplyValidate = welfFitApplyDataSet.isValidate();
	if(welfFitApplyValidate != true){
		L5.Msg.alert("提示",welfFitApplyValidate);
		return ;
	}
	var fitApplyRecord=welfFitApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
	command.setParameter("record", fitApplyRecord);
	command.execute("saveFitApply");
	if (!command.error) {
		alert("保存成功！");	
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function send() {
	var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
	var fitApplyRecord=welfFitApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
	command.setParameter("record", fitApplyRecord);
	command.execute("sendQualification");
	if(!command.error){
		/* if(actId=='5' || end){//是发证环节流程结束
			L5.Msg.alert("提示","成功结束流程!",function(){
				window.history.go(-1);
			});
		}else{ */
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				window.history.go(-1);
			});
		//}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
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
	<%	
	}
	%>
		ifApplyActive = false;	
	}
}

function win_close() {
	var win = L5.getCmp("approveInfo");
	win.hide();
}
function win_show() {
	var conditionSelect = L5.getCmp("approveInfo");
	conditionSelect.show();
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}
function goBack() {
	history.go(-1);
}
</script>
</html>
