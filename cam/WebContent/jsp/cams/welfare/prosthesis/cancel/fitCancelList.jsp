
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>注销列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="fitCancelList.js"></script>
		<script language="javascript">
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
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitLogoffQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitLogoff"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" border="0" width="100%" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								<td class="FieldLabel">编号:</td>
								<td class="FieldInput"><input type="text"  id="serialNumQuery" class="TextEditor" title="编号"  /></td>	
								<td class="FieldLabel">企业名称:</td>
								<td class="FieldInput"><input type="text"  id="companyNameQuery" class="TextEditor" title="企业名称"  /></td>	
								<td class="FieldLabel">联系人:</td>
								<td class="FieldInput"><input type="text"  id="linkmanQuery" class="TextEditor" title="联系人"  /></td>	
							</tr>
							<tr>	
								<td class="FieldLabel">注销时间:</td>
								<td class="FieldInput"><input type="text"  id="logoffDateQuery" class="TextEditor" title="注销时间"  /></td>	
								<td class="FieldLabel">法定代表人:</td>
								<td class="FieldInput"><input type="text"  id="legalPeopleQuery" class="TextEditor" title="法定代表人"  /></td>	
								<td class="FieldLabel"></td>
								<td class="FieldInput"><button onclick="query()">查 询&nbsp;&nbsp;&nbsp;
										<button type="reset">重 置</button></button> 
								</td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" width="100%" name="wealfitlogoffGrid" stripeRows="true" height="100%" dataset="ds" title="注销企业列表"  clickToSelectedForChkSM="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="确认注销" iconCls="select" handler="cancel" />
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="taskCode" header="业务编码" field="taskCode" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="serialNum" header="编号" field="serialNum" width="130" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="companyName" header="企业名称" field="companyName" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="linkman" header="联系人" field="linkman" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="phone" header="联系电话" field="phone" width="100" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="logoffDate" header="注销时间" field="logoffDate" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="logoffReason" header="注销原因" field="logoffReason" width="200" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="legalPeople" header="法定代表人" field="legalPeople" width="90" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="idCard" header="法定代表人身份证号" field="idCard" width="150" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="regDate" header="注销备案时间" field="regDate" width="150" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
