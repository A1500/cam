
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>DIS_FUNDS_SOURCE列表</title>
		<%
			String organType = BspUtil.getOrganType();
			String areaCode = BspUtil.getOrganCode();
		%>
		<next:ScriptManager/>
		<script type="text/javascript" src="fundsmanage_list.js"></script>
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
			var areaCode = <%= areaCode%>;
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<model:dataset id="allocationStatusSelect" enumName="DIS.ALLOCATION_STATUS" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="allocationTypeSelect" enumName="DIS.ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="allocationPurposeSelect" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="receiveStatusSelect" enumName="DIS.RECEIVE_STATUS" autoLoad="true" global="true"></model:dataset>	
</model:datasets>

<next:Panel  name="form" width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								<td class="FieldLabel">年度:</td>
								<td class="FieldInput"><input type="text"  id="disYear" class="TextEditor" title="年度"  /></td>	
								<td class="FieldLabel">拨付状态:</td>
								<td class="FieldInput">
								<select id="allocationStatus"  >
									<option dataset="allocationStatusSelect"></option>
								</select>
								</td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disfundssourceGrid" width="98%" stripeRows="true" height="400" dataset="ds" title="资金发放管理列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<% if(organType.equals(BspUtil.PROVINCE)){%>
			<next:ToolBarItem text="增加资金" iconCls="add" handler="insert" />
			<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
			<next:ToolBarItem text="删除" iconCls="delete" handler="del" />
		<% }else{%>
		<next:ToolBarItem text="接收资金" iconCls="edit" handler="receive"/>
		<next:ToolBarItem text="发放完成" iconCls="edit" handler="allocationOver"/>
		<% }%>
		<next:ToolBarItem text="资金发放" iconCls="edit" handler="allocation"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="id" header="ID" field="id" width="90" hidden="true">
		</next:Column>
	
		<next:Column id="disYear" header="年度" field="disYear" width="5%" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="upAllocationNum" header="上级下拨文号" field="upAllocationNum" width="8%" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="upAllocationType" header="上级下拨资金类型" field="upAllocationType" width="10%" >
			<next:TextField  /><next:ComboBox dataset="allocationTypeSelect"/>
		</next:Column>
	
		<next:Column id="upAllocationPurpose" header="上级下拨资金用途" field="upAllocationPurpose" width="43%" renderer="fillPurposeName">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="upAllocationTotalCount" header="上级下拨资金总额" field="upAllocationTotalCount" width="15%" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="allocationStatus" header="发放状态" field="allocationStatus" width="15%" >
			<next:TextField  /><next:ComboBox dataset="allocationStatusSelect"/>
		</next:Column>
		
		<next:Column id="receiveStatus" header="接收状态" field="receiveStatus" width="15%" >
			<next:TextField  /><next:ComboBox dataset="receiveStatusSelect"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
