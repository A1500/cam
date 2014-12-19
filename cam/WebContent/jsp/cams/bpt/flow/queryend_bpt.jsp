<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>结束任务查询</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	</head>
<body>

<model:datasets>
	<model:dataset  id="endTaskDataset" cmd="com.inspur.cams.bpt.manage.cmd.WfProcessBusinessQueryCommand" method="queryEndTask" autoLoad="false" global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="procEndTime" type="string" />
			<model:field name="objectType" type="string" />
			
			<model:field name="name" type="string" />
			<model:field name="idCard" type="string" />
			<model:field name="serviceName" type="string" />
			<model:field name="serviceType" type="string" />
			<model:field name="peopleId" type="string" />
			<model:field name="applyId" type="string" />
			<model:field name="familyId" type="string" />
			<model:field name="fullName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="SERVICETYPE" enumName="BPT.SERVERTYPE" autoLoad="true" global="true"/>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
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
						                 <td class="FieldInput"><input type="text" style="width:135px"  id="idCard" class="TextEditor" title="身份证件号码"  size="40"/></td>
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
			<next:GridPanel id="endTaskGridPanel" name="endTaskGridPanel" clickToSelectedForChkSM="true" notSelectFirstRow="true"  width="100%" height="100%" dataset="endTaskDataset" title="结束流程列表" autoExpandColumn="operation">
				<next:Columns >
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="assignmentId" header="内码" field="assignmentId" width="50" hidden="true" >
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
					<next:Column id="serviceName" header="业务类型" field="serviceName" width="200">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="endTime" header="办理时间" field="endTime" width="100" align="center" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="120" align="center"  >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="procEndTime" header="流程结束时间" field="procEndTime" width="120" align="center"  >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="actDefName" header="已办环节" field="actDefName" width="120" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<% //String organType = BspUtil.getOrganType();
						///if(!"13".equals(organType)){%>
					<next:Column id="operation" header="操作"  field="serviceType" renderer="operation" width="80">
						<next:TextField allowBlank="false"/>
					</next:Column> 
					<% //}%>
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="select"  text="查看" handler="handle"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="endTaskDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="reguIdentiApp/reguIdentiAppPrintDao"/>
<input type="hidden" id="objectType" name="printQuery" queryData="queryData" value="" />
<input type="hidden" id="printYear" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="printMonth" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="changeContent" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="docPath" printMark="printMark" value="" />
<input type="hidden" id="bptQueryPathServiceType" value=""/>
</body>
<script language="javascript"  type="text/javascript" >

var changeContent;

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
	var endTaskDataset = L5.DatasetMgr.lookup("endTaskDataset");
	endTaskDataset.load();
	L5.QuickTips.init();
}

//办结任务查询
function query(){
	var endTaskDataset = L5.DatasetMgr.lookup("endTaskDataset");
	var domicileCode = document.getElementById("domicileCode").value;
	var serviceType = document.getElementById("serviceType").value;
	var name = document.getElementById("name").value;
	var idCard = document.getElementById("idCard").value;
	endTaskDataset.setParameter("domicode",domicileCode);
	endTaskDataset.setParameter("serviceType",serviceType);
	endTaskDataset.setParameter("name",name);
	endTaskDataset.setParameter("idCard",idCard);
	endTaskDataset.load();
	noReclick(endTaskDataset,"queryButton");
	L5.QuickTips.init();
}

//通过链接处理办结任务
function addLink(value,second,record)
{
	var assignmentId=record.get("assignmentId");
	return "<a href=\"javascript:dealendTask('"+assignmentId+"')\">"+value+"</a>";
}

//通过按钮处理办结任务
function handle()
{
	var userGrid=L5.getCmp('endTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		alert("请选择一条记录进行处理!");
		return false;
	}
	if(selected.length > 1) {
		alert("您选择的记录数大于一条，请选择一条您要查看的记录");
	 	return false;
	}
	var rec=selected[0];
	var assignmentId = rec.get("assignmentId");
	var peopleId = rec.get("peopleId");
	var applyId = rec.get("applyId");
	var familyId = rec.get("familyId");
	var serviceType = rec.get("serviceType");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/endTaskForward";
	var query="?assignmentId="+assignmentId;
	query +="&peopleId="+peopleId+"&applyId="+applyId+"&familyId="+familyId+"&serviceType="+serviceType;
	var width = screen.width-200;
    var height = screen.height-150;
	var win = window.showModalDialog (L5.webPath+'/'+url+query,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null){
		return;
	}
	//L5.forward(url+query,"办理");
}

//处理办结任务
function dealendTask(assignmentId)
{			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/endTaskForward";
	var query="?assignmentId="+assignmentId;
	L5.forward(url+query,"办理");
}

//查看流程状态图
function showState()
{
   var endTaskGridPanel=L5.getCmp("endTaskGridPanel");
   var selecteds=endTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length<1){
		alert("请选择一条记录进行处理!");
		return false;
	}
	if(selecteds.length > 1) {
		alert("您选择的记录数大于一条，请选择一条您要查看的记录");
	 	return false;
	}
   var assignmentId=selecteds[0].get("assignmentId");
   var url='jsp/workflow/monitor/flowview.jsp?backUrl=jsp/cams/bpt/flow/queryend_bpt.jsp&assignmentId='+assignmentId;
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

	function operation(value) {
		//判断优抚类别
	if(value == 11||value == 12||value == 13||value == 14||value == 15){//伤残
		if(organType == '11'){
			var func = 'javascript:print()';
			var str = "<a href='"+func+"'>" + '打证' + "</a>"; 
			return str;
		}
	}else if(value == 41||value == 45){//在乡复员军人、带病回乡
		if(organType == '12'){
			var func = 'javascript:print()';
			var str = "<a href='"+func+"'>" + '打证' + "</a>"; 
			return str;
		}
	}
		var str = ""; 
		return str;
	} 
	
	
function replaceAll(s0,s1,s2) { 
    return s0.replace(new RegExp(s1,"gm"),s2); 
}
	/**
 * 打印
 */
function print(){
/**
	获取bptObjectType的值
	用于判断当前显示的是哪个panel
*/
	var userGrid=L5.getCmp('endTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要打印的记录!");
		return false;
	}
	var a = selected[0];
	var peopleId = selected[0].get("peopleId");
	var objectType = null;
	//判断优抚类别获取类别Id
		objectType = selected[0].get('objectType');
//	var domicile_code = selected[0].get('DOMICILE_CODE');
//	alert(peopleId+"  "+objectType);
	var data = new L5.Map();
	data.put("peopleId",peopleId);
	data.put("objectType",objectType);
	//判断优抚类别
	if(objectType == 11||objectType == 12||objectType == 13||objectType == 14||objectType == 15){//伤残
		
		if(organType == '11'){
			var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type=disability&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
			if(objectType == 11){
				if(getValue!=""&&getValue!=undefined){
					var list = getValue.split(";");
					flag = list[1];
					changeContent = decodeURI(list[2]);
					
					changeContent=replaceAll(changeContent," ","&nbsp;");
					changeContent=replaceAll(changeContent,"\r\n","<br/>");
					changeContent=replaceAll(changeContent,"\n","<br/>");
					changeContent = escape(encodeURIComponent(changeContent));
					//changeContent = decodeURI(list[2]);
					if(flag == "0") { //左边栏
						var url="../disabilityRenewal/disabilityInfoWrite.jsp?renewalFlag=no&peopleId="+peopleId+"&changeContent="+changeContent;
						var width = 1024;
						var height = 768;
					    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
						/* path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc";
						change(path,changeContent,"68"); */
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disright.doc";
						change(path,changeContent,"67");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
					//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
					//window.showModalDialog(url,window);
				}
			}else{
				if(getValue!=""&&getValue!=undefined){
					var list = getValue.split(";");
					flag = list[1];
					changeContent = decodeURI(list[2]);
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc";
						change(path,changeContent,"68"); 
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disright.doc";
						change(path,changeContent,"67");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
					//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
					//window.showModalDialog(url,window);
				}
			}
			
		}else{
			alert("伤残只能省级用户打印！");
			return false;
		}
	}else if(objectType == 41||objectType == 42){//在乡复员军人、带病回乡
		if(organType == '12'){
			var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type=demobilized&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
			if(getValue!=""&&getValue!=undefined){
				var list = getValue.split(";");
				flag = list[1];
				changeContent = decodeURI(list[2]);
				if(objectType == 41){//在乡复员军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/demright.doc";
						change(path,changeContent,"65");
					} else if (flag == "3") {
					
						openPrint(peopleId,objectType);
					}
				} else if (objectType == 42){//带病回乡军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc";
						change(path,changeContent,"66");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				}
				//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
				//window.showModalDialog(url,window);
			}
		}else{
			alert("在乡复员、带病回乡军人只能市级用户打印！");
			return false;
		}
	}else{
		alert("您选择的用户暂不能打印！");
		return false;
	}
//	var text = '优抚对象定期认证打印';
//	L5.forward(url,text,data);
	
}
function openPrint(peopleId,objectType) {
	var docpath;
	var url="../../comm/print/jspcommonprint.jsp?";
	if(objectType == 11){//残疾军人
		//docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
		url="../disabilityRenewal/disabilityInfoWrite.jsp?renewalFlag=no&peopleId="+peopleId;
	}else if(objectType == 12){//伤残国家机关工作人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityGZ_apptable.doc";
		
	}else if(objectType == 13){//伤残人民警察
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJC_apptable.doc";
		
	}else if(objectType == 14){//伤残民兵民工
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
		
	}else if(objectType == 15){//因战因公伤残人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
		
	}else if(objectType == 41){//在乡复员军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/demobilized_apptable.doc";
		
	}else if(objectType == 42){//带病回乡复员军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/demobilizedIllness_apptable.doc";
		
	}
	
	document.getElementById("docpath").value=docpath;
	var ements = document.getElementsByName("printQuery");
	for(var i=0;i<ements.length;i++) {
		var obj = ements[i];
		if(obj.getAttribute("queryData") == "queryData") {
			var idValue = obj.getAttribute("id");
			if(idValue == "peopleId") {
				obj.value = peopleId;
			} else if(idValue == "objectType") {
				obj.value = objectType;
			}
		}
	}
	document.getElementById("bptQueryPathServiceType").value=objectType;
	
	
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}
//证件变更时的打印页面
function change(path,changeContent,serviceType_temp) {
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){
		month="0"+month;
	}
	document.getElementById("docPath").value = path;
	document.getElementById("printYear").value = year;
	document.getElementById("printMonth").value = month;
	document.getElementById("changeContent").value = changeContent ;
	
	document.getElementById("bptQueryPathServiceType").value = serviceType_temp;
	
	var url="../../../cams/comm/print/print_noDataSet.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
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