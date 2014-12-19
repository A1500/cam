
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>DIS_YEAR_COST_SHEET列表</title>
		<%
		// 行政区划
		 String organCode = BspUtil.getOrganCode();
		%>
		<next:ScriptManager/>
		<script type="text/javascript" src="disyearcostsheet_list.js"></script>
		<script language="javascript">
			 var organCode = '<%= organCode%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisYearCostSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisYearCostSheet"></model:record>
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
									
								<td class="FieldLabel">年度:</td>
								<td class="FieldInput"><input type="text"  id="disYear" class="TextEditor" title="年度"  /></td>	
								
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disyearcostsheetGrid" width="100%" stripeRows="true" height="100%" clickToSelectedForChkSM="true" dataset="ds" title="年度资金预算">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    
	
		<next:Column id="disYear" header="年度" field="disYear" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="yearCostSheet" header="本级救灾资金年度预算" field="yearCostSheet" width="12%" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="assistanceForSelf" header="本级配套灾害救助资金" field="assistanceForSelf" width="12%" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="donationForSelf" header="本级募集救灾捐赠资金" field="donationForSelf" width="12%" >
			<next:NumberField  />
		</next:Column>
	
		
	
		<next:Column id="organName" header="填报单位名称" field="organName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fillPeopleName" header="填报人姓名" field="fillPeopleName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fillTime" header="填报时间" field="fillTime" width="12%" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
