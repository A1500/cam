<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.*"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
var sorgId='<%=request.getParameter("sorgId")%>';
//统计报表中的本人办理的业务统计会跳到此页面，跳过来的此状态为1
var sorgType='<%=request.getParameter("sorgType")%>';
function init(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("SORG_ID",sorgId);
	somApplyDataSet.load();
	var somBranchDataSet=L5.DatasetMgr.lookup("somBranchDataSet");
	somBranchDataSet.setParameter("MAIN_SORG_ID",sorgId);
	somBranchDataSet.setParameter("SORG_STATUS@IN","21,22,23,31,32,52");
	somBranchDataSet.load();	
	L5.getCmp("branchGrid").on("rowclick",function(grid,rowIndex,e){
		var record=grid.getSelectionModel().getSelected();
		if(record){
			var somBranchApplyDataSet=L5.DatasetMgr.lookup("somBranchApplyDataSet");
			somBranchApplyDataSet.setParameter("SORG_ID",record.get('sorgId'));
			somBranchApplyDataSet.load();
		}
	});
	if(sorgType=='M'){
		L5.getCmp("tabOrgan").remove(1);
	}
}
function back(){
	history.go(-1);
}
function detail(){
	var grid=L5.getCmp("hisGrid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行查看!");
		return false;
	}
	var record=selected[0];
	var applyType=record.get("applyType");
	var data=new L5.Map();
	data.put('taskCode',record.get("taskCode"));
	var url='';
	if(applyType=='<%=ApplyType.getSOM_GROUP_BUILD_CN()%>'){
		url='jsp/cams/sorg/query/somHis/group/somHisGroupBuildDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_GROUP_NAME_APPROVAL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/group/somHisGroupNameApprovalDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_GROUP_PREPARE_CN()%>'){
		url='jsp/cams/sorg/query/somHis/group/somHisGroupPrepareDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_GROUP_CHANGE_CN()%>'){
		url='jsp/cams/sorg/query/somHis/group/somHisGroupChangeDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_GROUP_CANCEL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/group/somHisGroupCancelDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_UNGOV_NAME_APPROVAL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/ungov/somUngovNameApprovalDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_UNGOV_BUILD_LEGAL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/ungov/somHisUngovBuildDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_UNGOV_BUILD_PARTNERSHIP_CN()%>'){
		url='jsp/cams/sorg/query/somHis/ungov/somHisUngovPartBuildDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_UNGOV_BUILD_INDIVIDUAL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/ungov/somHisUngovIndivBuildDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_UNGOV_CHANGE_CN()%>'){
		url='jsp/cams/sorg/query/somHis/ungov/somHisUngovChangeDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_UNGOV_CANCEL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/ungov/somHisUngovCancelDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_FUND_NAME_APPROVAL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/fund/somFundNameApprovalDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_FUND_BUILD_CN()%>'){
		url='jsp/cams/sorg/query/somHis/fund/somHisFundBuildDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_FUND_CHANGE_CN()%>'){
		url='jsp/cams/sorg/query/somHis/fund/somHisFundChangeDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_FUND_CANCEL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/fund/somHisFundCancelDetail.jsp';
	}
	text='';
	L5.forward(url,text,data);	
}
function detailBranch(){
	var grid=L5.getCmp("branchHisGrid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行查看!");
		return false;
	}
	var record=selected[0];
	var applyType=record.get("applyType");
	var data=new L5.Map();
	data.put('taskCode',record.get("taskCode"));	
	var url='';
	if(applyType=='<%=ApplyType.getSOM_GROUP_BRANCH_BUILD_CN()%>'){
		url='jsp/cams/sorg/query/somHis/group/somHisGroupBranchBuildDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_GROUP_BRANCH_CHANGE_CN()%>'){
		url='jsp/cams/sorg/query/somHis/group/somHisGroupBranchChangeDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_GROUP_BRANCH_CANCEL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/group/somHisGroupBranchCancelDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_FUND_BRANCH_BUILD_CN()%>'){
		url='jsp/cams/sorg/query/somHis/fund/somHisFundBranchBuildDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_FUND_BRANCH_CHANGE_CN()%>'){
		url='jsp/cams/sorg/query/somHis/fund/somHisFundBranchChangeDetail.jsp';
	}else if(applyType=='<%=ApplyType.getSOM_FUND_BRANCH_CANCEL_CN()%>'){
		url='jsp/cams/sorg/query/somHis/fund/somHisFundBranchCancelDetail.jsp';
	}
	text='';
	L5.forward(url,text,data);
}
function closeWin(){
	window.close();	
}
</script>
</head> 
<body>
<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" method="queryOrgan" sortField="appDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>	
	<model:dataset id="somBranchDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>	
	<model:dataset id="somBranchApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" method="queryOrgan" sortField="appDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
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
		<% if(request.getParameter("ifJump")!= null && request.getParameter("ifJump").equals("1")){%>
			<next:ToolBarItem  iconCls="return" text="关闭" handler="closeWin" ></next:ToolBarItem>
		<%}else{%>
			<next:ToolBarItem  iconCls="return" text="返回" handler="back" ></next:ToolBarItem>
		<%}%>
	</next:TopBar>
	<next:TabPanel id="tabOrgan" width="100%" height="100%">	
		<next:Tabs>	
			<next:Panel title="社会组织主体历史沿革" width="100%" height="100%">
				<next:EditGridPanel  id="hisGrid" dataset="somApplyDataSet" height="100%" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem  iconCls="detail" text="查看" handler="detail" ></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="社会组织种类" field="sorgType" sortable="true" dataset="sorgTypeSelect" width="10%" editable="false"><next:TextField /></next:Column>
						<next:Column header="社会组织名称"  field="sorgName" sortable="true" editable="false"width="20%" ><next:TextField></next:TextField></next:Column>
						<next:Column header="登记证号"  field="sorgId" sortable="true" editable="false"width="20%" dataset='sorgCodeSelect'><next:TextField></next:TextField></next:Column>
						<next:Column header="业务类别" field="applyType" sortable="true" editable="false" width="20%" ><next:TextField/></next:Column>
						<next:Column header="审批时间" field="auditTime" sortable="true" editable="false" width="15%"><next:TextField /></next:Column>
						<next:Column header="当前状态" field="ifFinish" sortable="true" editable="false" width="10%" ><next:TextField/></next:Column>
					</next:Columns> 
					<next:BottomBar>
						<next:PagingToolBar dataset="somApplyDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="社会组织分支历史沿革" width="100%" autoScroll="true">			
				<next:EditGridPanel title="社会组织分支列表" id="branchGrid" dataset="somBranchDataSet" height="260" notSelectFirstRow="true">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="分支（代表）机构名称"  field="cnName" sortable="true" editable="false"width="20%" ><next:TextField></next:TextField></next:Column>
						<next:Column header="登记证号" field="sorgCode" sortable="true" editable="false" width="10%"><next:TextField/></next:Column>
						<next:Column header="分支（代表）机构状态" field="sorgStatus" sortable="true" editable="false" width="12%" dataset="sorgStatusSelect"><next:TextField/></next:Column>
						<next:Column header="负责人" field="branchCharger" sortable="true" editable="false" width="10%"><next:TextField /></next:Column>
					</next:Columns> 
					<next:BottomBar>
						<next:PagingToolBar dataset="somBranchDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
				<next:EditGridPanel title="社会组织分支历史沿革" id="branchHisGrid" dataset="somBranchApplyDataSet" height="350" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem  iconCls="detail" text="查看" handler="detailBranch" ></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="社会组织种类" field="sorgType" sortable="true" dataset="sorgTypeSelect" width="10%" editable="false"><next:TextField /></next:Column>
						<next:Column header="社会组织名称"  field="sorgName" sortable="true" editable="false"width="20%" ><next:TextField></next:TextField></next:Column>
						<next:Column header="登记证号"  field="sorgId" sortable="true" editable="false"width="20%" dataset='sorgCodeSelect'><next:TextField></next:TextField></next:Column>
						<next:Column header="业务类别" field="applyType" sortable="true" editable="false" width="20%" ><next:TextField/></next:Column>
						<next:Column header="审批时间" field="auditTime" sortable="true" editable="false" width="15%"><next:TextField /></next:Column>
						<next:Column header="当前状态" field="ifFinish" sortable="true" editable="false" width="10%" ><next:TextField/></next:Column>
					</next:Columns> 
					<next:BottomBar>
						<next:PagingToolBar dataset="somBranchApplyDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>