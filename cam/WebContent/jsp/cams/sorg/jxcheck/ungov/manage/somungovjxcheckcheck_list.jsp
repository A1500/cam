
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil;"%>
<html>
	<head>
	<%
		String areaCode = BspUtil.getOrganCode().substring(0,6);
	%>
		<title>年检查询列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somungovjxcheckcheck_list.js"></script>
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
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  width="100%" height="100%" >
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
		<next:ToolBarItem text="审核" iconCls="detail" handler="detail"/>
		
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
</body>
</html>
