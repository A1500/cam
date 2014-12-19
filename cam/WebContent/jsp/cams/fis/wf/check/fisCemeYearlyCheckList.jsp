<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>任务查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="fisCemeYearlyCheckList.js"></script>
<script language="javascript">
<%
	String oType = BspUtil.getOrganType();
%>
		var procTypeId="fisCemeYearCheck";
		//年检流程ID
		var procDefUniqueId="4028e08140623a11014062422576004e";
		var organCode = '<%=BspUtil.getOrganCode()%>';
		var organType = '<%=BspUtil.getOrganType()%>';
		var organName = '<%=BspUtil.getOrganName()%>';	
		var parentOrganCode = '<%=BspUtil.getParentOrgan().getOrganCode()%>';
		var parentOrganName = '<%=BspUtil.getParentOrgan().getOrganName()%>';
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="workflowDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryWorkflow" autoLoad="false" global="true">
	</model:dataset>
	<!-- 待办年检业务表 -->
	<model:dataset id="daiBanDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" method="queryDaiban">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"></model:record>
	</model:dataset>
	<!-- 业务表 加载年检业务-->
	<model:dataset id="applyDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"></model:record>
	</model:dataset>
	<!-- 公墓信息 -->
	<model:dataset id="CemeInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
	<!-- 上报状态 -->
	<model:dataset id="isReportState" enumName="FIS.CEME.REPORT.STATUS"
		autoLoad="true" global="true"></model:dataset>
	<!-- 年检结果 0:未参检,1:合格,2:不合格,3:已检查,4:检查不合格,5.整改-->
	<model:dataset id="checkResultDs" enumName="FIS.CEME.INSPECTION.STATUS"
		autoLoad="true" global="true"></model:dataset>
	<!-- 年检业务状态 -->
	<model:dataset id="applyState" enumName="FIS.CEME.CHECK.STATUS"
		autoLoad="true" global="true"></model:dataset>
	<!--  年检历史记录 -->
	<model:dataset id="historyDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" autoLoad="true" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
	</model:dataset>
</model:datasets>
<next:ViewPort>
			<next:Panel title="经营性公墓年检检查" width="100%" height="100%" >
				<next:Panel width="100%" border="0">
				    <next:TopBar>
	                 <next:ToolBarItem symbol="->"></next:ToolBarItem>
	                 <next:ToolBarItem handler="download" iconCls="detail" text="下载操作手册"></next:ToolBarItem>
	                </next:TopBar>
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
							            <td class="FieldInput" width="40%"><input type="text"  id="queryCemeName" style="width:40%" />
							            <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
											style="cursor: hand" onclick="forCemeSelect()" title="列表选择"/></td>
										<td class="FieldLabel" width="10%">年检年度：</td>
							            <td class="FieldInput" width="40%"><input type="text"  id="queryTime" style="width:40%" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">年检结果:</td>
										<td class="FieldInput"><select type="text" id="checkResult"
											class="TextEditor" title="checkResult" />
											<option dataset="checkResultDs"/>
										</select></td>
										<td class="FieldLabel" colspan="2">
										<button onclick="queryDaiban()">查 询</button>
										&nbsp;&nbsp;
										<button onclick="resetClick()">重置</button>
										</td>
									</tr>
								</table>
							</form>	
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel" width="100%" height="100%" dataset="daiBanDataset" title="待办列表" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>			
						<next:ToolBarItem iconCls="add"  text="新年检" handler="add" id="btadd"/>
						<next:ToolBarItem iconCls="edit"  text="修改" handler="edit" id="btedit"/>
						<next:ToolBarItem iconCls="remove"  text="删除" handler="del" id="btdel"/>
						<next:ToolBarItem iconCls="detail"  text="明细" handler="detail" id="detail"/>
						<next:ToolBarItem iconCls="select"  text="提交" handler="submit" id="btsum"/>
						<next:ToolBarItem iconCls="detail"  text="流程图" handler="workFlow" id="workFlow"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="45" header="序号"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="CEME_APPLY_ID" header="业务编码" field="CEME_APPLY_ID"  hidden="true"></next:Column>
						<next:Column id="SCORE_ID" header="打分编码" field="SCORE_ID"  hidden="true"></next:Column>
						<next:Column id="RECORD_ID" header="公墓记录编码" field="RECORD_ID"  hidden="true"></next:Column>
						<next:Column id="ORGAN_IDS" header="公墓编码" field="ORGAN_ID"  hidden="true"></next:Column>
						<next:Column id="NAME" header="公墓名称" field="NAME" width="15%" ></next:Column>
						<next:Column id="CHECK_YEAR" header="年检年度" field="CHECK_YEAR" width="10%" align="center"></next:Column>
						<next:Column id="APPLY_STATE" header="业务状态" field="APPLY_STATE" dataset="applyState" width="12%" align="center"></next:Column>
						<next:Column id="IS_REPORT" header="上报状态" field="IS_REPORT" width="10%" dataset="isReportState" align="center"></next:Column>
						<next:Column id="CUR_ACTIVITY" header="当前环节" field="CUR_ACTIVITY" width="10%" align="center"></next:Column>
						<next:Column id="CUR_ORGAN" header="当前单位" field="CUR_ORGAN" width="10%" align="center"></next:Column>
						<next:Column id="REC_TIME" header="接收时间" field="REC_TIME" width="12%" align="center"></next:Column>
						<next:Column id="COM_TIME" header="处理时间" field="COM_TIME" width="12%" align="center"></next:Column>
						<next:Column id="FILL_ORGAN_NAME" header="发起单位" field="FILL_ORGAN_NAME" width="10%" align="center"></next:Column>
						<%
							if("13".equals(oType)){
						%>
								<next:Column id="FIRST_TIME" header="发起时间" field="FIRST_TIME" width="12%" align="center"></next:Column>
						<%	
							}
							if("12".equals(oType)){
						%>
							<next:Column id="SECOND_TIME" header="发起时间" field="SECOND_TIME" width="12%" align="center"></next:Column>
						<% 
							}
						%>
						<next:Column id="CHECK_RESULT" header="年检结果" field="CHECK_RESULT" width="15%" align="center" dataset="checkResultDs"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataset"/>
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
</next:ViewPort>

</body>
</html>