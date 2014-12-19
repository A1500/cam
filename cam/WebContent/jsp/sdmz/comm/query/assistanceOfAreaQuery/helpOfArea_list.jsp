<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil" %>
<html>
	<head>
		<title>全区救助信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="helpOfArea_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.sdmz.comm.query.assistanceOfAreaQuery.cmd.HelpOfAreaQueryCmd" global="true" autoLoad="true" pageSize="15">
	</model:dataset>
	<model:dataset id="jzbmDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_PLAN'></model:param>
			<model:param name="value" value='PLAN_ORGAN_ID'></model:param>
			<model:param name="text" value='PLAN_ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 100%; height: 100%;" class="L5form">
				<table style="width:100%;table-layout:fixed;" >
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="20%">救助时间 从:</td>
						<td class="FieldInput" colspan="2" width="50%" nowrap="nowrap" ><input type="text" id="startDate" format="Y-m-d" onclick="LoushangDate(this)"/>
						&nbsp;&nbsp;至:&nbsp;&nbsp;<input type="text" id="endDate" format="Y-m-d" onclick="LoushangDate(this)"/></td>
						<td  width="30%" nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="query()">查 询</button> 
						&nbsp&nbsp<button type="reset">重 置</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="jzfaGrid" width="100%" stripeRows="true" height="95%" dataset="ds" title="部门救助信息">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		
		<next:ToolBarItem text="导出excel" iconCls="add"  handler="exportExcel"></next:ToolBarItem>
		
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="45"/>
		<next:Column id="PLAN_ORGAN_NAME" header="救助部门" field="PLAN_ORGAN_NAME" width="180" align="center" >
			<next:TextField  />
		</next:Column>
		<next:Column id="NUM" header="救助次数" field="NUM" width="80" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="JZHS" header="救助户数" field="FAMILY_NUM" width="80" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="JZRS" header="救助人数" field="PEOPLE_NUM" width="80" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="JZZJ_JE" header="资金投入（元）" field="FUND" width="120" align="center">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"></next:PagingToolBar>
	</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
</body>
</html>