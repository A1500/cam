
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<script type="text/javascript">
</script>
	<head>
		<title>年检查询列表</title>
		<next:ScriptManager/>
		<script language="javascript">
		<%
			String username = ExtBspInfo.getUserInfo(request).getUserName();
		 	String userId = ExtBspInfo.getUserInfo(request).getUserId();
		%>
		var username='<%=username%>';
		var userId = '<%=userId%>';
		var year = '<%=Integer.parseInt(DateUtil.getYear())-1+""%>';
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
		<script type="text/javascript" src="somfundcheckfill_list.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" >
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  >
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend	class="GroupBoxTitle">查询条件 
				<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> 
			</legend>						
			<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
				<form class="L5form">
					<table  border="1" width="100%">
						<tr >
							<td class="FieldLabel"style="width:20%">年检年份:</td>
							<td class="FieldInput"style="width:20%"><input type="text"  id="batchYear" class="TextEditor" maxlength="4"   /></td>	
							<td class="FieldLabel"style="width:20%">年检状态:</td>
							<td class="FieldInput"style="width:20%"><select id="status"><option dataset="somCheckStatus" ></option></select> </td>	
							<td class="FieldButton" style="width:20%">
								<button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="reset">重 置</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="somcheckGrid" width="100%" stripeRows="true" height="300" dataset="ds" title="基金会年检列表" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="上报" iconCls="upload" handler="report" />
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="查看并打印年检报告" iconCls="detail" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="sorgCode" header="年检年份" field="batchYear" width="15%" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="cnName" header="社会组织名称" field="cnName" width="25%" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="batch" header="填报日期" field="reportDate" width="15%" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="status" header="年检状态" field="status" width="14%" >
			<next:ComboBox dataset="somCheckStatus"/>
		</next:Column>
		
		<next:Column id="checkResult" header="年检结果" field="checkResult" width="150" >
			<next:ComboBox dataset="checkResultSelect"/>
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
<next:Panel  name="desc" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:2px;"  >
	<next:Html>
	<div>
	<span style="font-size:12px;color:red">
				操作说明：<br>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp1.点击“增加”按钮进行录入年检信息;<br>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp2.状态为保存或校对不通过的年检信息选择后点击“修改”按钮可以进行修改;<br>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp3.保存后的年检信息需要选择后点击“上报”按钮，将年检信息上报给民政部门;<br>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp4.一个用户可以保存多个年检信息，但是只能上报一条年检信息。<br>
	</span>
	</div>
	</next:Html>
</next:Panel>
</next:Panel>
</body>
</html>
