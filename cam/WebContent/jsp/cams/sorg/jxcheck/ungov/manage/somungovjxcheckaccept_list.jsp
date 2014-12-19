<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
	<head>
	<%
		String areaCode = BspUtil.getOrganCode().substring(0,6);
	%>
		<title>年检查询列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somungovjxcheckaccept_list.js"></script>
		<script language="javascript">
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
			var areaCode = '<%=areaCode%>';
			var year = '<%=Integer.parseInt(DateUtil.getYear())-1+""%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<model:dataset id="noCheckDs" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true" method="queryNoCheck">
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:TabPanel  width="100%" height="100%" id="tab">
	<next:Tabs>
		<next:Panel title="已填报" width="100%" >
			<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  >
				<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
								class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,
												"groupbox_collapse.gif")%>"
								onclick="collapse(this)" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
								<form class="L5form">
									<table  border="1" width="100%" >
										<tr >
											<td class="FieldLabel" style="width:15%">单位名称:</td>
											<td class="FieldInput" style="width:25%"><input type="text"  id="cnName" class="TextEditor" style="width:80%"/></td>	
											<td class="FieldLabel" style="width:15%">登记证号:</td>
											<td class="FieldInput" style="width:25%"><input type="text"  id="sorgCode" class="TextEditor"style="width:80%" /></td>
											<td class="FieldButton" style="width:20%">
												<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
												<button type="reset">重置</button>
											</td>
										</tr>
									</table>
								</form>
							</div>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="editGridPanel" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="民办非企业单位年检列表" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="置为校对不通过" iconCls="detail" handler="notpass"/>
					<next:ToolBarItem text="出具年检结论" iconCls="detail" handler="detail"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn width="30"/>
				    <next:CheckBoxColumn></next:CheckBoxColumn>
				     
					<next:Column id="taskCode" header="task_code" field="taskCode" width="90" hidden="true">
						<next:TextField allowBlank="false" />
					</next:Column>
				
					<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="150" >
						<next:TextField  />
					</next:Column>
					
					<next:Column id="cnName" header="社会组织名称" field="cnName" width="250" >
						<next:TextField  />
					</next:Column>
				
				
					<next:Column id="checkYear" header="年检年份" field="checkYear" width="150" >
						<next:TextField  />
					</next:Column>
				
					<next:Column id="status" header="年检状态" field="status" width="150" >
						<next:ComboBox dataset="somCheckStatus"/>
					</next:Column>
				
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="ds"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		
		<next:Panel title="未填报" width="100%" >
			<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  >
				<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
								class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src='<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>'
								onclick="collapse(this)" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
								<form class="L5form">
									<table  border="1" width="100%" >
										<tr >
											<td class="FieldLabel" style="width:15%">民办非企业单位名称:</td>
											<td class="FieldInput" style="width:25%"><input type="text"  id="userName" class="TextEditor" style="width:80%"/></td>	
											<td class="FieldLabel" style="width:15%"></td>
											<td class="FieldInput" style="width:25%"></td>
											<td class="FieldButton" style="width:20%">
												<button onclick="query2()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
												<button type="reset">重置</button>
											</td>
										</tr>
									</table>
								</form>
							</div>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="editGridPanel2" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="noCheckDs" title="民办非企业单位未年检列表" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="出具年检结论" iconCls="detail" handler="showWin"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn width="30"/>
				    <next:CheckBoxColumn></next:CheckBoxColumn>
				    <next:Column header="" field="USER_ID" hidden="true">
						<next:TextField  />
					</next:Column>
					 <next:Column header="" field="AREA_CODE" hidden="true">
						<next:TextField  />
					</next:Column>
					<next:Column id="fillPeopleName" header="社会组织名称" field="USER_NAME" width="250" >
						<next:TextField  />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="noCheckDs"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
<next:Window id="forCheck" closeAction="hide" title="年检结果信息" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="出具年检结论"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="saveResult"></next:ToolBarItem>
		<next:ToolBarItem text="关闭窗口" iconCls="detail" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" >
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>社会组织名称：</label></td>
					<td class="FieldInput" colspan="5"><label id="fillPeopleName"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:20%"><label>去年年检结果：</label></td>
					<td class="FieldInput" colspan="5"><label id="lastYearCheckResult"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>去年年检结果描述：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='"去年年检结果描述"' id="lastYearCheckResultDesc" style="width:98%" readonly="readonly"></textarea>
					</td>
				</tr>
			</table>
		</form>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>年检结果：</label></td>
					<td class="FieldInput" colspan="5">
					<select id="checkResult" name='"年检结果"' style="width:150px" default="0">
						<option dataset="checkResultSelect"></option>
					</select><span style="color:red">*</span>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>年检结果描述：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='"年检结果描述"' id="checkResultDesc" style="width:98%"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>
