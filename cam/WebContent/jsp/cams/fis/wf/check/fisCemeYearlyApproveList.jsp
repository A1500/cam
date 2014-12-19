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
<script type="text/javascript" src="fisCemeYearlyApproveList.js"></script>
<script type="text/javascript" src="../ep.js"></script>
<script language="javascript">

	function setTaskState(value,a,rec)
	{
		var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
		var image="";
		//正常状态
		if(value=="0")
		{
			image="normal.png";
		}
		//预警状态
		else if(value=="1")
		{
			image="warn.png";
		}
		//超时状态
		else if(value=="2")
		{
			image="limit.png";
		}
	
		return '<img src="'+imagePath+image+'" />';
	}
		
		var procTypeId="fisCemeYearCheck";
		var organCode = '<%=BspUtil.getOrganCode()%>';
		//根据organType判断流程环节
		var organType = '<%=BspUtil.getOrganType()%>';
		var organName = '<%=BspUtil.getOrganName()%>';
		//年检流程ID
		var procDefUniqueId="4028e08140623a11014062422576004e";
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
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" 
			method="queryDaiBanNJ" autoLoad="false" global="true">
		<model:record>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" 
			method="queryYiBanNJ" autoLoad="false" global="true">
	</model:dataset>
	<model:dataset pageSize="10" id="endTaskDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" 
			method="queryEndNJ"  autoLoad="false" global="true">
	</model:dataset>
	<!-- 年检结果 -->
	<model:dataset id="checkResultDs" enumName="FIS.CEME.INSPECTION.STATUS"
		autoLoad="true" global="true"></model:dataset>
	<!-- 年检业务状态 -->
	<model:dataset id="applyState" enumName="FIS.CEME.CHECK.STATUS"
		autoLoad="true" global="true"></model:dataset>
		
	<!-- 公墓名称字典表的引用 -->
	<model:dataset id="cemeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="FIS_CEME_INFO"></model:param>        <!-- 需要查询的表 -->
			<model:param name="value" value="RECORD_ID"></model:param>     <!-- 查询的内容 -->
			<model:param name="text" value="NAME"></model:param>    <!-- 输出查询的结果 -->
		</model:params>
	</model:dataset>
	<!-- 墓穴信息 -->
	<model:dataset id="CemeInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%" id="tabPanel">
	    <next:TopBar>
	              <next:ToolBarItem symbol="->"></next:ToolBarItem>
	              <next:ToolBarItem handler="download" iconCls="detail" text="下载操作手册"></next:ToolBarItem>
	    </next:TopBar>	
		<next:Tabs>
			<next:Panel title="待办事项" width="100%" height="100%" >
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
							            <td class="FieldInput" width="40%"><input type="text"  id="queryCemeName" style="width:40%" /></td>
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
									<tr>
										<td class="FieldLabel" colspan="4">
											<span style="width:100%;text-align: left">
												<font color="red" size="4px">参与年检的公墓仅有一次整改的机会</font>
											</span>
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
						<next:ToolBarItem iconCls="add"  text="办理" handler="submit" id="btadd"/>
						<next:ToolBarItem iconCls="detail"  text="流程图" handler="showDaibanState" id="detail"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>
						<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
		        		<next:Column header="状态" field="TASK_STATE" width="40" renderer="setTaskState" align="center">
							<next:TextField allowBlank="false"/>
						</next:Column>
		        		<next:Column id="recordId" header="公墓名称" field="RECORD_ID" width="15%" dataset="cemeDs"></next:Column>
						<next:Column id="checkYear" header="年检年度" field="CHECK_YEAR" width="10%" align="center"></next:Column>
						<next:Column id="applyState" header="业务状态" field="APPLY_STATE" dataset="applyState" width="12%" align="center"></next:Column>
						<next:Column id="actDefName" header="当前环节" field="ACT_DEF_NAME" width="100" ></next:Column>
						<next:Column id="curOrgan" header="当前单位" field="CUR_ORGAN" width="10%" align="center"></next:Column>
						<next:Column id="FILL_ORGAN_NAME" header="发起单位" field="FILL_ORGAN_NAME" width="10%" align="center"></next:Column>
						<next:Column id="procCreateTime" header="发起时间" field="PROC_CREATE_TIME" width="120" renderer="renderDate" ></next:Column>
						<next:Column id="actLimitTime" header="环节限时时间" field="ACT_LIMIT_TIME" width="120" renderer="renderDate" ></next:Column>
						<next:Column id="actWarnTime" header="环节预警时间" field="ACT_WARN_TIME" width="120" renderer="renderDate"></next:Column>
						
						<next:Column id="CHECK_RESULT" header="年检结果" field="CHECK_RESULT" width="15%" align="center" dataset="checkResultDs"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataset"/>
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
	
			<next:Panel title="已办事项" width="100%" height="100%">
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
							            <td class="FieldInput" width="40%"><input type="text"  id="queryCemeY" style="width:40%" /></td>
										<td class="FieldLabel" width="10%">年检年度：</td>
							            <td class="FieldInput" width="40%"><input type="text"  id="queryTimeY" style="width:40%" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">年检结果:</td>
										<td class="FieldInput"><select type="text" id="checkResultY"
											class="TextEditor" title="checkResult" />
											<option dataset="checkResultDs"/>
										</select></td>
										<td class="FieldLabel" colspan="2">
										<button onclick="queryYiban()">查 询</button>
										&nbsp;&nbsp;
										<button onclick="reset()">重置</button>
										</td>
									</tr>
								</table>
							</form>	
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>
				
				<next:GridPanel id="yiBanTaskGridPanel" title="已办流程列表" name="yiBanTaskGridPanel" width="100%" height="100%" dataset="yiBanTaskDataset" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="select" text="明细" handler="handleyiban"/>
					<next:ToolBarItem iconCls="detail" text="流程图" handler="showStateyiban"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
	        		<next:Column id="recordId" header="公墓名称" field="RECORD_ID" width="15%" dataset="cemeDs"></next:Column>
					<next:Column id="checkYear" header="年检年度" field="CHECK_YEAR" width="15%" align="center"></next:Column>
					<next:Column id="applyState" header="业务状态" field="APPLY_STATE" dataset="applyState" width="12%" align="center"></next:Column>
					<next:Column id="CUR_ACTIVITY" header="当前环节" field="CUR_ACTIVITY" width="100" ></next:Column>
					<next:Column id="curOrgan" header="当前单位" field="CUR_ORGAN" width="10%" align="center"></next:Column>
					<next:Column id="FILL_ORGAN_NAME" header="发起单位" field="FILL_ORGAN_NAME" width="10%" align="center"></next:Column>
					<next:Column id="REC_TIME" header="接收时间" field="REC_TIME" width="12%" align="center"></next:Column>
						
					<next:Column id="procCreateTime" header="发起时间" field="PROC_CREATE_TIME" width="120" renderer="renderDate" ></next:Column>
					<next:Column id="endTime" header="任务完成时间" field="END_TIME" width="150" renderer="renderDate" ></next:Column>
					<next:Column id="CHECK_RESULT" header="年检结果" field="CHECK_RESULT" width="15%" align="center" dataset="checkResultDs"></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar  dataset="yiBanTaskDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
					
			<next:Panel title="结束事项" width="100%" height="100%">
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
							            <td class="FieldInput" width="40%"><input type="text"  id="queryCemeW" style="width:40%" /></td>
										<td class="FieldLabel" width="10%">年检年度：</td>
							            <td class="FieldInput" width="40%"><input type="text"  id="queryTimeW" style="width:40%" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">年检结果:</td>
										<td class="FieldInput"><select type="text" id="checkResultW"
											class="TextEditor" title="checkResult" />
											<option dataset="checkResultDs"/>
										</select></td>
										<td class="FieldLabel" colspan="2">
										<button onclick="queryEnd()">查 询</button>
										&nbsp;&nbsp;
										<button onclick="reset()">重置</button>
										</td>
									</tr>
								</table>
							</form>	
						</div>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="endTaskGridPanel" title="结束流程列表" dataset="endTaskDataset" width="100%" height="100%"  stripeRows="true" notSelectFirstRow="true">
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="select"  text="明细" handler="handleEnd"/>
					<next:ToolBarItem iconCls="print"  text="打印年检报告" handler="printReport"/>
					<next:ToolBarItem iconCls="detail"  text="流程图" handler="showStateEnd"/>
				</next:TopBar>
				<next:Columns>
	   				<next:RowNumberColumn/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
	        		<next:Column id="recordId" header="公墓名称" field="RECORD_ID" width="15%" dataset="cemeDs"></next:Column>
					<next:Column id="checkYear" header="年检年度" field="CHECK_YEAR" width="15%" align="center"></next:Column>
					<next:Column id="checkResult" header="年检结果" field="CHECK_RESULT" width="15%" align="center" dataset="checkResultDs"></next:Column>
					<next:Column id="procDefName" header="流程名称" field="PROC_DEF_NAME" width="150" ></next:Column>
					<next:Column id="endTime" header="办理时间" field="END_TIME" width="150" renderer="renderDate" ></next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="PROC_CREATE_TIME" width="150"  renderer="renderDate" ></next:Column>
					<next:Column id="procEndTime" header="流程结束时间" field="PROC_END_TIME" width="150" renderer="renderDate" ></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="endTaskDataset" />
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>

</body>
</html>