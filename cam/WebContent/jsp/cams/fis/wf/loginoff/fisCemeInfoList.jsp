<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>

<html>
<head>
<title>殡葬业务公墓信息表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCemeInfoList.js"></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	var organType = '<%=BspUtil.getOrganType()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){	
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>';
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
	<model:dataset id="daiBanDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" global="true" method="queryCemeApply">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="queryApplyDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 备案信息 -->
	<model:dataset id="fisCemeLogoffDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeLogoffQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeLogoff"/>
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
	<%
	    String organType = BspUtil.getOrganType();
	    if(organType.equals("13")){
	%>
	<model:dataset id="fisCemeIsReport" enumName="FIS.CEME.LOGOFF.REPORT" global="true" autoLoad="true"></model:dataset>
	<% }else{ %>
	<model:dataset id="fisCemeIsReport" enumName="FIS.CEME.LOGOFF.REPORT.STATUS" global="true" autoLoad="true"></model:dataset>
	<% } %>
</model:datasets>
	<next:Panel width="100%" autoHeight="true" titleCollapse="true" collapsible="true" title="公墓撤销">
	    <next:TopBar>
	       <next:ToolBarItem symbol="->"></next:ToolBarItem>
	       <next:ToolBarItem handler="download" iconCls="detail" text="下载操作手册"></next:ToolBarItem>
	    </next:TopBar>
		<next:Html><center>		 
		<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">
			查询条件 <img class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,
							"groupbox_collapse.gif")%>"
				onclick="collapse(this)" />
		</legend>
		<div>
			<form style="width: 98%; height: 100%;" class="L5form">
				<table  border="1" width="100%">
					<tr>
					 	<td class="FieldLabel" style="width:10%">公墓名称</td>
		                <td class="FieldInput" style="width:20%"><input id="name" style="width:80%"/></td>
		                <td class="FieldLabel" style="width:10%">上报状态</td>
		                <td class="FieldInput" style="width:20%">
		                    <select id="isReport">
		                       <option dataset="fisCemeIsReport"></option>
		                    </select>
		                </td>					               
		                <td class="FieldButton" style="width:30%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;
						<button type="reset">重置</button></td>
					</tr>
				</table>
			</form>
		</div>
		</fieldset>
		</center>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="daiBanGridPanel" title="待办任务列表" dataset="daiBanDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>
		     <next:ToolBarItem symbol="->"></next:ToolBarItem>
		     <next:ToolBarItem id="add" iconCls="add" text="新增" handler="newLogoff"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="add" text="提交" handler="submit"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="detail" text="流程图" handler="showState"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
	 		<next:RowNumberColumn/>
	 		<next:RadioBoxColumn/>
	 		<next:Column field="RECORD_ID" header="公墓名称" width="10%" sortable="false" dataset="fisCemeInfoDs"/>
	 		<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="cemeState"/>
	 		<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="fisCemeIsReport"/>
			<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
			<next:Column field="CUR_ORGAN" header="当前单位" width="10%" sortable="false"/>
			<next:Column field="REC_TIME" header="接收时间" width="10%" sortable="false"/>
			<next:Column field="COM_TIME" header="处理时间" width="10%" sortable="false"/>
			<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
			<%
			   String organType = BspUtil.getOrganType();
			   if(organType.equals("13")) {
			%>
			<next:Column field="FIRST_TIME" header="发起时间" width="10%" sortable="false"/>
			<%
			   }else{ 
			%>
			<next:Column field="SECOND_TIME" header="发起时间" width="10%" sortable="false"/>
			<%
			   } 
			%>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="daiBanDataSet" />
		</next:BottomBar>
	</next:GridPanel>
</body>
</html>