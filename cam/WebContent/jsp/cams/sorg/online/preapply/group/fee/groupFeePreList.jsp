<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.*"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
var sorgId='<%=request.getParameter("sorgId")%>';
var sorgType='<%=request.getParameter("sorgType")%>';
var morgArea='<%=BspUtil.getOrganCode()%>';
function init(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("CREATE_ORGAN",morgArea);
	somApplyDataSet.setParameter("APPLY_TYPE","016");
	somApplyDataSet.load();
}
function back(){
	history.go(-1);
}
function detail(){
	var grid=L5.getCmp("preGrid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行查看!");
		return false;
	}
	var record=selected[0];
	if(record.get("acceptSatus")=="已受理"){
		L5.Msg.alert("提示","该业务已经受理，不能重复受理!");
		return false;
	}
	var data=new L5.Map();
	data.put('taskCode',record.get("taskCode"));
	var url='';
	url='jsp/cams/sorg/online/preapply/group/fee/groupFeePre.jsp';
	text='';
	L5.forward(url,text,data);
}
function queryItem(){
	var cnName=_$("cnName");
	var taskCode=_$("taskCode");
	if(cnName=="" && taskCode==""){
		L5.Msg.alert("提示","请至少输入社团名称或受理编号!");
		return false;
	}
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE",taskCode);
	somApplyDataSet.setParameter("SORG_NAME",cnName);
	somApplyDataSet.setParameter("CREATE_ORGAN",morgArea);
	somApplyDataSet.setParameter("APPLY_TYPE","016");
	somApplyDataSet.load();
}
</script>
</head> 
<body>
<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" method="queryHasAcceptStatus" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>	
	<!-- 社会组织种类 -->
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='SORG_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
			<next:Panel width="100%" border="0">
				<next:Html>
					<form class="L5form">
					<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件</legend>
						<table border="1" width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">社团名称：</td>
								<td class="FieldInput" style="width:25%"><input type="text" id="cnName" style="width:80%"/></td>
								<td class="FieldLabel" style="width:15%">受理编号：</td>
								<td class="FieldInput" style="width:25%"><input type="text" id="taskCode" style="width:80%"/></td>
								<td class="FieldButton" style="width:20%">
								<button onclick="queryItem()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
						 		<button type="reset">重置</button>
								</td>
							</tr>
						</table>
					</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="社会组织会费标准备案预受理列表" width="100%" height="100%">
				<next:EditGridPanel  id="preGrid" dataset="somApplyDataSet" height="100%" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem  iconCls="detail" text="受理" handler="detail" ></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="受理编号" field="taskCode" sortable="true" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="社会组织种类" field="sorgType" sortable="true" dataset="sorgTypeSelect" width="10%" editable="false"><next:TextField /></next:Column>
						<next:Column header="社会组织名称"  field="sorgName" sortable="true" editable="false" width="20%" ><next:TextField></next:TextField></next:Column>
						<next:Column header="登记证号"  field="sorgId" sortable="true" editable="false"width="20%" dataset='sorgCodeSelect'><next:TextField></next:TextField></next:Column>
						<next:Column header="受理状态" field="acceptSatus" sortable="true" editable="false" width="10%" ><next:TextField/></next:Column>
						<next:Column header="创建时间" field="createTime" sortable="true" editable="false" width="10%" ><next:TextField/></next:Column>
						<next:Column header="创建人" field="createPerson" sortable="true" editable="false" width="10%" ><next:TextField/></next:Column>
					</next:Columns> 
					<next:BottomBar>
						<next:PagingToolBar dataset="somApplyDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
</next:Panel>
</body>
</html>