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
		<script type="text/javascript" src="somCheckForPenalty_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="penaltiedDs" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="noCheckDs" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true" method="queryNoCheck">
	</model:dataset>
	<model:dataset id="noCheckPenaltiedDs" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true" method="queryNoCheckPenaltied">
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:TabPanel  width="100%" height="100%" id="tab">
	<next:Tabs>
		<next:Panel title="年检不合格" width="100%" >
			<next:TabPanel  width="100%" height="100%" id="tab1">
			<next:Tabs>
			<next:Panel title="待发起行政执法列表" width="100%" >
			<next:Panel  name="form1" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  >
				<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
								class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,
												"groupbox_collapse.gif")%>"
								onclick="collapse(this)" /> </legend>
							<div class="GroupBoxDiv1" style="width: 100%;height: 100%;">	
								<form class="L5form">
									<table  border="1" width="100%" >
										<tr >
											<td class="FieldLabel" style="width:14%">社会组织名称:</td>
											<td class="FieldInput" style="width:14%"><input type="text"  id="cnName" class="TextEditor" style="width:80%"/></td>	
											<td class="FieldLabel" style="width:14%">登记证号:</td>
											<td class="FieldInput" style="width:14%"><input type="text"  id="sorgCode" class="TextEditor"style="width:80%" /></td>
											<td class="FieldLabel" style="width:14%">年检年份:</td>
											<td class="FieldInput" style="width:14%"><input type="text"  id="batchYear" class="TextEditor"style="width:80%" /></td>
											<td class="FieldButton" style="width:14%">
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
			<next:GridPanel id="editGridPanel" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="社会组织年检列表" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="行政处罚" iconCls="detail" handler="penaltyNoPass"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="taskCode" header="task_code" field="taskCode" width="90" hidden="true">
						<next:TextField allowBlank="false" />
					</next:Column>
					<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="150" >
						<next:TextField  />
					</next:Column>
					<next:Column id="cnName" header="社会组织名称" field="cnName" width="250" >
						<next:TextField  />
					</next:Column>
					<next:Column id="sorgType" header="社会组织类型" field="sorgType" width="150" >
						<next:ComboBox dataset="sorgTypeSelect"/>
					</next:Column>
					<next:Column id="checkYear" header="年检年份" field="checkYear" width="80" >
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
		
		<next:Panel title="已发起行政执法列表" width="100%" >
		<next:Panel  name="form2" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  >
				<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
								class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,
												"groupbox_collapse.gif")%>"
								onclick="collapse(this)" /> </legend>
							<div class="GroupBoxDiv2" style="width: 100%;height: 100%;">	
								<form class="L5form">
									<table  border="1" width="100%" >
										<tr >
											<td class="FieldLabel" style="width:14%">社会组织名称:</td>
											<td class="FieldInput" style="width:14%"><input type="text"  id="cnNamePenaltied" class="TextEditor" style="width:80%"/></td>	
											<td class="FieldLabel" style="width:14%">登记证号:</td>
											<td class="FieldInput" style="width:14%"><input type="text"  id="sorgCodePenaltied" class="TextEditor"style="width:80%" /></td>
											<td class="FieldLabel" style="width:14%">年检年份:</td>
											<td class="FieldInput" style="width:14%"><input type="text"  id="batchYearPenaltied" class="TextEditor"style="width:80%" /></td>
											<td class="FieldButton" style="width:14%">
												<button onclick="queryNoPassPenaltied()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
												<button type="reset">重置</button>
											</td>
										</tr>
									</table>
								</form>
							</div>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="editGridPanel4" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="penaltiedDs" title="社会组织年检列表" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="taskCode" header="task_code" field="taskCode" width="90" hidden="true">
						<next:TextField allowBlank="false" />
					</next:Column>
					<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="150" >
						<next:TextField  />
					</next:Column>
					<next:Column id="cnName" header="社会组织名称" field="cnName" width="250" >
						<next:TextField  />
					</next:Column>
					<next:Column id="sorgType" header="社会组织类型" field="sorgType" width="150" >
						<next:ComboBox dataset="sorgTypeSelect"/>
					</next:Column>
					<next:Column id="checkYear" header="年检年份" field="checkYear" width="80" >
						<next:TextField  />
					</next:Column>
					<next:Column id="status" header="年检状态" field="status" width="150" >
						<next:ComboBox dataset="somCheckStatus"/>
					</next:Column>
					<next:Column id="penaltyTime" header="行政处罚时间" field="penaltyTime" width="150" >
						<next:TextField  />
					</next:Column>
					<next:Column id="penaltyPeople" header="行政处罚发起人" field="penaltyPeople" width="150" >
						<next:TextField  />
					</next:Column>
					<next:Column id="penaltyOrgan" header="行政处罚发起单位" field="penaltyOrgan" width="150" >
						<next:TextField  />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="penaltiedDs"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		</next:Tabs>
		</next:TabPanel>
		</next:Panel>
		
		<next:Panel title="未填报" width="100%" >
			<next:TabPanel  width="100%" height="100%" id="tab2">
			<next:Tabs>
			<next:Panel title="待发起行政执法列表" width="100%" >
			<next:Panel  name="form3" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  >
				<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
								class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src='<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>'
								onclick="collapse(this)" /> </legend>
							<div class="GroupBoxDiv3" style="width: 100%;height: 100%;">	
								<form class="L5form">
									<table  border="1" width="100%" >
										<tr >
											<td class="FieldLabel" style="width:14%">社会组织名称:</td>
											<td class="FieldInput" style="width:14%"><input type="text"  id="userName" class="TextEditor" style="width:80%"/></td>	
											<td class="FieldLabel" width='14%'>社会组织类型:</td>
											<td class="FieldInput" width='14%'><select id='sorgType' name='社会组织类型' style='width:90%'><option  dataset="sorgTypeSelect"></option></select></td>
											<td class="FieldLabel" width='14%'>年检状态:</td>
											<td class="FieldInput" width='14%'>
												<select id='status' name='年检状态' style='width:90%'>
													<option  value="">请选择</option>
													<option  value="1">1年未年检</option>
													<option  value="2">2年未年检</option>
													<option  value="3">2年以上未年检</option>
												</select>
											</td>	
											<td class="FieldButton" style="width:40%">
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
			<next:GridPanel id="editGridPanel2" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="noCheckDs" title="待发起行政执法列表" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="行政处罚" iconCls="detail" handler="penalty"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    <next:Column header="登记证号" field="SORG_CODE" >
						<next:TextField  />
					</next:Column>
					 <next:Column header="" field="MORG_AREA" hidden="true">
						<next:TextField  />
					</next:Column>
					<next:Column id="fillPeopleName" header="社会组织名称" field="CN_NAME" width="250" >
						<next:TextField  />
					</next:Column>
					<next:Column id="organType" header="社会组织类型" field="SORG_TYPE" width="150" >
						<next:ComboBox dataset="sorgTypeSelect"/>
					</next:Column>
					<next:Column id="fillPeopleName" header="年检状态" field="STATUS_DESC" width="250" >
						<next:TextField  />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="noCheckDs"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		
		<next:Panel title="已发起行政执法列表" width="100%" >
		<next:Panel  name="form4" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  >
				<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
								class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src='<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>'
								onclick="collapse(this)" /> </legend>
							<div class="GroupBoxDiv4" style="width: 100%;height: 100%;">	
								<form class="L5form">
									<table  border="1" width="100%" >
										<tr >
											<td class="FieldLabel" style="width:14%">社会组织名称:</td>
											<td class="FieldInput" style="width:14%"><input type="text"  id="userName" class="TextEditor" style="width:80%"/></td>	
											<td class="FieldLabel" width='14%'>社会组织类型:</td>
											<td class="FieldInput" width='14%'><select id='sorgType' name='社会组织类型' style='width:90%'><option  dataset="sorgTypeSelect"></option></select></td>
											<td class="FieldLabel" width='14%'>年检状态:</td>
											<td class="FieldInput" width='14%'>
												<select id='status' name='年检状态' style='width:90%'>
													<option  value="">请选择</option>
													<option  value="1">1年未年检</option>
													<option  value="2">2年未年检</option>
													<option  value="3">2年以上未年检</option>
												</select>
											</td>	
											<td class="FieldButton" style="width:40%">
												<button onclick="query3()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
												<button type="reset">重置</button>
											</td>
										</tr>
									</table>
								</form>
							</div>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="editGridPanel3" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="noCheckPenaltiedDs" title="已发起行政执法列表" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    <next:Column header="登记证号" field="SORG_CODE" >
						<next:TextField  />
					</next:Column>
					 <next:Column header="" field="MORG_AREA" hidden="true">
						<next:TextField  />
					</next:Column>
					<next:Column id="fillPeopleName" header="社会组织名称" field="CN_NAME" width="250" >
						<next:TextField  />
					</next:Column>
					<next:Column id="organType" header="社会组织类型" field="SORG_TYPE" width="150" >
						<next:ComboBox dataset="sorgTypeSelect"/>
					</next:Column>
					<next:Column id="fillPeopleName" header="年检状态" field="STATUS_DESC" width="250" >
						<next:TextField  />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="noCheckPenaltiedDs"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		</next:Tabs>
		</next:TabPanel>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
</html>
