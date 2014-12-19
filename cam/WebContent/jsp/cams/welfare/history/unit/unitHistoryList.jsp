<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title></title>
		<next:ScriptManager/>
		<script type="text/javascript" src="unitHistoryList.js"></script>
		<script language="javascript">
		 	 //查询条件打开合并函数
		 	 var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus"></model:record>
	</model:dataset>
	<model:dataset id="detailDs" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus"></model:record>
	</model:dataset>
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
								<td class="FieldLabel">福利企业证书编号:</td>
								<td class="FieldInput"><input type="text"  id="serialNum" class="TextEditor" title="编号"  /></td>	
								<td class="FieldLabel">企业名称:</td>
								<td class="FieldInput"><input type="text"  id="companyName" class="TextEditor" title="企业名称"  /></td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button></td>
							</tr>
							<!-- 
							<tr>
								<td class="FieldLabel">法人代表:</td>
								<td class="FieldInput"><input type="text"  id="legalPeople" class="TextEditor" title="法人代表"  /></td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>	
								<td class="FieldLabel"><button type="reset">重 置</button></td>
							</tr>
							 -->
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="wealUnitstatusGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="企业列表">
	<next:TopBar>
		<next:ToolBarItem text="企业列表" ></next:ToolBarItem>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="新增" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"  />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="unitId" header="UNIT_ID" field="unitId" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="taskCode" header="TASK_CODE" field="taskCode" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="status" header="STATUS" field="status" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="applyYear" header="APPLY_YEAR" field="applyYear" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="serialNum" header="福利企业证书编号" field="serialNum" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="companyName" header="企业名称" field="companyName" width="150" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="legalPeople" header="法人代表" field="legalPeople" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="address" header="注册地址" field="address" width="200" >
			<next:TextField  />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
