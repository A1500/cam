<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
</script>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>待办任务查询</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptNotRemindQueryCommand" method="queryDaiBanRemind"  global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="activityId" type="string" />
			<model:field name="actDefUniqueId" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="actLimitTime" type="string" />
			<model:field name="actWarnTime" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="createTime" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="preActDefNames" type="string" />
			<model:field name="preOrganNames" type="string" />
			<model:field name="processId" type="string" />
			
			<model:field name="name" type="string" />
			<model:field name="idCard" type="string" />
			<model:field name="serviceName" type="string" />
			<model:field name="serviceType" type="string" />
			<model:field name="peopleId" type="string" />
			<model:field name="applyId" type="string" />
			<model:field name="familyId" type="string" />
			<model:field name="status" type="string" />
			<model:field name="fullName" type="string" />
			<model:field name="isRemind" type="string" />
		</model:record>
	</model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="ynDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="SERVICETYPE" enumName="BPT.SERVERTYPE" autoLoad="true" global="true"/>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel id="daibanpanel">
			<next:AnchorLayout>
			<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件
						<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
					</legend>
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form onsubmit="return false;" class="L5form">				
							<table  border="1" width="100%">
								<tr>
										 <td class="FieldLabel" width="15%" >身份证件号码：</td>
						                 <td class="FieldInput"><input type="text" style="width:135px" maxlength="18" id="idCard" class="TextEditor" title="身份证件号码"  size="40"/></td>
										<td class="FieldLabel" width="15%" >属地行政区划：</td>
						                 <td class="FieldInput">
						                 	<input type="text" id="domicileName" name="domicileName" style="width:280px;" title="属地行政区划" style="width:90%"  onclick="func_ForDomicileSelect()" readonly="readonly"/>
						      				<input type="hidden" id="domicileCode" name="domicileCode" title="属地行政区划"/>
						                 </td>
						                 <td class="FieldButton" width="15%">
									<button onclick="reset()">重置</button>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" width="15%" >姓名：</td>
						                 <td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  size="40"/></td>
						                 <td class="FieldLabel" width="15%" >业务类型：</td>
						                 <td class="FieldInput"><select  id="serviceType" style="width:280px;"  title="业务类型"  >
						                 	<option dataset="SERVICETYPE"></option>
						                 </select>
						                 </td>
									<td class="FieldButton" width="15%">
									<button id="queryButton" onclick="query()">查询</button>
									</td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel"  anchor="100%" height="100%" dataset="daiBanDataset"  stripeRows="true"  notSelectFirstRow="true"  title="待办流程列表" >
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="select"  text="取消/恢复提醒" handler="handle"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="assignmentId" header="内码" field="assignmentId"  hidden="true" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="serviceType" header="业务代码" field="serviceType"   hidden="true" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="applyId" header="申请id" field="applyId"   hidden="true" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="peopeleId" header="人员id" field="peopeleId"   hidden="true" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="familyId" header="家庭id" field="familyId"   hidden="true" >
						<next:TextField allowBlank="false"/> 
					</next:Column>
					
					<next:Column id="fullName" header="属地行政区划" field="fullName" width="160">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="name" header="姓名" field="name" width="60">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="黑名单" field="blackList" width="60" renderer="setTaskState" align="center">
						<next:TextField allowBlank="false"/>
					</next:Column>	
					<next:Column id="idCard" header="身份证件号码" field="idCard"  width="140">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="serviceName" header="业务类型" field="serviceName"  width="200">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="createTime" header="任务到达时间" field="createTime" width="100" align="center">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="100" align="center" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="preActDefNames" header="发送环节" field="preActDefNames" width="100" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="preOrganNames" header="发送人" field="preOrganNames" width="60" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="actDefName" header="当前环节" field="actDefName" width="100" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="status" header="流程状态" field="status" width="80" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="isRemind" header="是否提醒" field="isRemind" width="80" dataset='ynDataSet'>
						<next:TextField allowBlank="false" />
					</next:Column>
					<next:Column id="actLimitTime" header="环节限时时间" field="actLimitTime" width="100" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="actWarnTime" header="环节预警时间" field="actWarnTime" width="100" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="processId" header="processId" field="processId" width="100" hidden="true" >
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar  dataset="daiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >

function query2(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var domicileCode = document.getElementById("domicileCode").value;
	var serviceType = document.getElementById("serviceType").value;
	var name = document.getElementById("name").value;
	var idCard = document.getElementById("idCard").value;
	daiBanDataset.setParameter("domicode",domicileCode);
	daiBanDataset.setParameter("serviceType",serviceType);
	daiBanDataset.setParameter("name",name);
	daiBanDataset.setParameter("idCard",idCard);
	daiBanDataset.load();
	noReclick(daiBanDataset,"queryButton");
}
//查询条件面板打开合并函数
function collapse(element){
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
		fieldsetParent.getElementsByTagName("div")[0].style.display="none";
		element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
		element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
		element.expand =true;
	}
}

function init(){
	if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
		}
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	//要查询的流程类型或要过滤掉的流程类型
	daiBanDataset.load();
}
//待办任务查询
function query(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var domicileCode = document.getElementById("domicileCode").value;
	var serviceType = document.getElementById("serviceType").value;
	var name = document.getElementById("name").value;
	var idCard = document.getElementById("idCard").value;
	daiBanDataset.setParameter("domicode",domicileCode);
	daiBanDataset.setParameter("serviceType",serviceType);
	daiBanDataset.setParameter("name",name);
	daiBanDataset.setParameter("idCard",idCard);
	daiBanDataset.load();
	noReclick(daiBanDataset,"queryButton");
}
//通过按钮处理待办任务
function handle(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		alert("请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var applyId = rec.get("applyId");
	var peopleId = rec.get("peopleId");
	var isRemind = rec.get("isRemind");
	var msg='';
	if(isRemind==1){
		msg="确定不在提醒该任务吗?";
	}else if(isRemind==0){
		msg="确定恢复提醒该任务吗?";
	}
	L5.MessageBox.confirm('确定', msg,function(state){
		  if(state=="yes"){
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptNotRemindCommand");
			command.setParameter("applyId",applyId);
			command.setParameter("peopleId",peopleId);
			command.setParameter("remindType","A");
			if(isRemind==1){
				command.execute("insertRemind");
			}else if(isRemind==0){
				command.execute("deleteRemindByAppplyUserId");
			}
			if (!command.error) {
				query();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}  
	});
}

//处理待办任务
function dealDaiBanTask(assignmentId,processId)
{	
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId;
	L5.forward(url+query,"办理");
}  

//查看流程状态图
function showState()
{
   var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
   var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length == 0){
      alert("请选择一条您要查看的记录");
	  return false;
	}
	if(selecteds.length > 1) {
		alert("您选择的记录数大于一条，请选择一条您要查看的记录");
	 	return false;
	}
   var assignmentId=selecteds[0].get("assignmentId");
   var url='jsp/workflow/monitor/flowview.jsp?backUrl=jsp/cams/bpt/flow/querydaiban_bpt.jsp&assignmentId='+assignmentId;
   var width = screen.width-200;
    var height = screen.height-150;
	var win = window.showModalDialog (L5.webPath+'/'+url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
   //var text = '流程状态';
   //L5.forward(url,text);
}

/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value=list[0];
		document.getElementById("domicileName").value=list[4];
	}
}
function setTaskState(value,a,rec){		
	var idCard = rec.get("idCard");
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
	command.setParameter("idCard", idCard);
	command.execute("checkDoublePerson");
	var flag = command.getReturn("flag");//0;没有重复 ,1:有重复
	
	var imagePath=L5.webPath+"/jsp/cams/bpt/bptPerjury/img/";
	var image="";
	if(flag=="1"){
		image="blackList.png";
		return '<img src="'+imagePath+image+'" />';
	}else{
		return '';
	}

}	
</script>
</html>