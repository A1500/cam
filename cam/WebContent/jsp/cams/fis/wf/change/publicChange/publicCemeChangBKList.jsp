<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>任务查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src=publicCemeChangBKList.js></script>
<script type="text/javascript" src="../../ep.js"></script>
<script language="javascript" type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	var organType = '<%=BspUtil.getOrganType()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
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
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisCemeInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
	
	<model:dataset pageSize="10" id="workflowDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryWorkflow" autoLoad="false" global="true">
	</model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="daiBanDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" global="true" method="queryByCurActicity">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="queryApplyDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 备案信息 -->
	<model:dataset id="fisCemeChangeDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeChangeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeChange"/>
	</model:dataset>
	<!--字典表将RECORD_ID转为NAME -->
	<model:dataset id="fisCemeInfoDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
			<model:param name="dic" value="FIS_CEME_INFO"></model:param>
			<model:param name="value" value="RECORD_ID"></model:param>
			<model:param name="text" value="NAME"></model:param>
			</model:params>
	</model:dataset>
	<!-- 业务状态 -->
	<model:dataset id="cemeState" enumName="FIS.CEME.CHECK.STATUS" global="true" autoLoad="true"></model:dataset>
	<!-- 上报状态 -->
	<model:dataset id="fisCemeIsReport" enumName="FIS.CEME.REPORT.STATUS" global="true" autoLoad="true"></model:dataset>
		
</model:datasets>
<next:ViewPort>
			<next:Panel title="待办任务" width="100%" height="100%" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"/>
				<next:ToolBarItem iconCls="detail" text="下载操作手册" handler="download"/>
			</next:TopBar>
				<next:Panel width="100%" border="0">
					<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form onsubmit="return false;" class="L5form">				
								<table  border="1" width="100%">
									<tr>
										<td class="FieldLabel" width="10%">公墓名称：</td>
							            <td class="FieldInput" width="40%"><input type="text"  id="name" style="width:40%" /></td>
										<td class="FieldButton" width="10%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;
										<button type="reset">重置</button></td>
									</tr>
								</table>
							</form>	
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>
				
				<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel" width="100%" height="100%" dataset="daiBanDataSet" title="待办任务列表" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>			
						<next:ToolBarItem iconCls="add" id="add" text="新增" handler="add"/>
						<next:ToolBarItem iconCls="edit"  text="修改" handler="edit"/>
						<next:ToolBarItem iconCls="delete"  text="删除" handler="del"/>
						<next:ToolBarItem iconCls="detail"  text="明细" handler="detail"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
		   				<next:Column field="RECORD_ID" header="公墓记录编码" width="10%" sortable="false" hidden="true"/>
		   				<next:Column field="CEME_APPLY_ID" header="业务审批编码" width="10%" sortable="false" hidden="true"/>
		   				<next:Column field="RECORD_ID" header="公墓名称" width="10%" sortable="false" dataset="fisCemeInfoDs"/>
						<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="cemeState"/>
				 		<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="fisCemeIsReport"/>
						<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
						<next:Column field="CUR_ORGAN" header="当前单位" width="10%" sortable="false"/>
						<next:Column field="REC_TIME" header="接收时间" width="15%" sortable="false" renderer="renderDate"/>
						<next:Column field="COM_TIME" header="处理时间" width="15%" sortable="false" renderer="renderDate"/>
						<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false" />
						<next:Column field="REC_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataSet"/>
					</next:BottomBar>
				</next:GridPanel>
				
			</next:Panel>
</next:ViewPort>

</body>
</html>