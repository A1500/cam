
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>DIS_RELIEF_INFO列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="dc_info_list.js"></script>
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
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
	</model:dataset>
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true"
		global="true"></model:dataset>
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
									
								<td class="FieldLabel">档案编号:</td>
								<td class="FieldInput"><input type="text"  id="recordId" class="TextEditor" title="RECORD_ID"  /></td>	
								<td class="FieldLabel">救助类型:</td>
								<td class="FieldInput"><select type="text"  id="reliefType" class="TextEditor" title="RELIEF_TYPE"  />
								<option dataset="ReliefTypeDataset"></option></select>
								</td>
								
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disreliefinfoGrid" width="100%" stripeRows="true"clickToSelectedForChkSM="true" height="400" dataset="ds" title="DIS_RELIEF_INFO">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
	
		<next:Column id="recordId" header="档案编号" field="recordId" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="reliefType" header="救助类型" field="reliefType"dataset="ReliefTypeDataset" width="90" >
			<next:TextField  />
		</next:Column>
	
	
		<next:Column id="damageTime" header="受灾时间" field="damageTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="disasterType" header="灾害种类" field="disasterType" width="90" >
			<next:TextField  />
		</next:Column>
	
	
		<next:Column id="note" header="备注" field="note" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="organName" header="填报单位名称" field="organName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="workflowStatus" header="流程跳转状态" field="workflowStatus" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="workflowReceiveOrgan" header="流程接收单位" field="workflowReceiveOrgan" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
