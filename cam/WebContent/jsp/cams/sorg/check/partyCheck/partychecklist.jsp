<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
	<head>
		<title>年检填报列表</title>
		<%
			String partyId=IdHelp.getUUID32();
		String areaCode = BspUtil.getOrganCode().substring(0,6);
		%>
		<next:ScriptManager/>
		<script type="text/javascript" src="partychecklist.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
		 	 //查询条件打开合并函数
		 	 var partyId='<%=partyId%>';
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
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="partyCheckDataSet" cmd="com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckQueryCommand" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.sorg.partycheck.data.SomPartyCheck"></model:record>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 党建信息 -->
	<model:dataset id="somPartyDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty">
		</model:record>
	</model:dataset>
	<!-- 社会组织信息 -->
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrganWithAreaCodeSearchCondition">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.PARTY_CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.PARTY_CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">社会组织名称:</td>
								<td class="FieldInput"><input type="text"  id="sorgName" class="TextEditor" title="CN_NAME"  /></td>
								<td class="FieldLabel">登记证号:</td>
								<td class="FieldInput"><input type="text"  id="sorgCode" class="TextEditor" title="SORG_CODE"  /></td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>
								<td class="FieldLabel"><button onclick="query()">查 询</button></td>
							</tr>
							<tr >
								<td class="FieldLabel">社会组织类型:</td>
								<td class="FieldInput"><select  id="sorgType"  title="SORG_TYPE" ><option dataset="sorgTypeSelect"></option></select></td>
								<td class="FieldLabel">年检状态:</td>
								<td class="FieldInput"><select  id="checkStatus"  title="checkStatus" >
									<option value="">请选择...</option>
									<option value="1">外网提交</option>
									<option value="2">核对不通过</option>
									<option value="3">年检完成</option>
									</select></td>
								<td class="FieldLabel">年检结果:</td>
								<td class="FieldInput"><select  id="checkResult"  title=""checkResult"" ><option dataset="checkResultSelect"></option></select></td>
								<td class="FieldLabel"><button type="reset">重  置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel2" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="partyCheckDataSet" title="外网提交的党建年检信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem text="退回" iconCls="undo" handler="backto"/>
		<next:ToolBarItem text="办理" iconCls="select" handler="handleCheck"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detailCheck"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	  	<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="ycheckId" header="ycheckId" field="ycheckId" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column  header="社会团体名称" field="sorgName" width="250" >
			<next:TextField  />
		</next:Column>

		<next:Column  header="登记证号" field="sorgCode" width="150" >
			<next:TextField  />
		</next:Column>

		<next:Column id="yearly" header="年检年份" field="yearly" width="80" >
			<next:TextField  />
		</next:Column>

		<next:Column id="checkStatus" header="年检状态" field="checkStatus" width="120" dataset="somCheckStatus">
		</next:Column>

		<next:Column id="modTime" header="提交时间" field="modTime" width="150">
		</next:Column>

		<next:Column id="checkResult" header="年检结果" field="checkResult" width="80" >
			<next:ComboBox dataset="checkResultSelect"/>
		</next:Column>

		<next:Column id="checkTime" header="核对时间" field="checkTime" width="150">
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="partyCheckDataSet"/>
	</next:BottomBar>
</next:GridPanel>
<next:Window id="correctNotPassReasonWin" closeAction="hide" width="500" height="170" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" ></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
	</next:TopBar>
	<next:Html>
		<table width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">校对不通过原因</td>
				<td class="FieldInput" style="width:80%"><textarea id="correctNotReason" rows="8" style="width:100%" readonly="readonly"></textarea></td>
			</tr>
		</table>
   </next:Html>
</next:Window>
</body>
</html>
