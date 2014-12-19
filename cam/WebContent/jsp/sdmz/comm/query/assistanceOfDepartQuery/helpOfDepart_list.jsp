<%@ page contentType="text/html; charset=UTF-8" import="com.inspur.sdmz.comm.util.*"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%
	//String organArea = BspUtil.getCorpOrgan().getCorpOrganId();
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	
	
%>
<script language="javascript">
	var organArea = "<%=organArea%>";
</script>
<html>
	<head>
		<title>部门救助信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
		<script type="text/javascript" src="helpOfDepart_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" global="true" autoLoad="false" pageSize="15">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="jzlxDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean">
		</model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jzbmDs" cmd="com.inspur.sdmz.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='SAM_PLAN'></model:param>
			<model:param name="valueField" value='PLAN_ORGAN_ID'></model:param>
			<model:param name="textField" value='PLAN_ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 100%; height: 100%;" class="L5form">
				<table style="width:100%;table-layout:fixed;">
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="10%">救助部门:</td>
						<td class="FieldInput" nowrap="nowrap" width="25%">
							<select id="jzbmquery">
								<option dataset="jzbmDs"></option>
							</select>
						</td>	
						<td class="FieldLabel" nowrap="nowrap" width="15%">救助时间 从:</td>
						<td class="FieldInput" nowrap="nowrap" width="50%"><input type="text"  id="jzsjqquery" format="Y-m-d" onclick="LoushangDate(this)"/>
						至:<input type="text"  id="jzsjzquery" format="Y-m-d" onclick="LoushangDate(this)"/></td>
					</tr>
					<tr>	
						<td class="FieldLabel" nowrap="nowrap" width="10%">救助方案名称:</td>
						<td class="FieldInput" nowrap="nowrap" width="25"><input type="text" id="jzfamcquery" /></td>
					
						<td class="FieldLabel" nowrap="nowrap" width="15%">救助类型:</td>
						<td class="FieldInput" colspan="1" nowrap="nowrap" width="50%">
							<input type="text" id="jzlxDisplay" readOnly="true"  ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="mutiHelp('jzlxDs','jzlxDisplay','jzlxquery')"/>
							<input type="hidden" id="jzlxquery">&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="query()">查 询</button> &nbsp&nbsp
							<button type="reset">重 置</button> </td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" hasSum="true" name="jzfaGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="部门救助信息" >
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		
		<next:ToolBarItem text="导出excel" iconCls="add" handler="exportExcel"></next:ToolBarItem>
		
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="45"/>
		<next:Column id="jzfaid" header="救助方案ID" field="planId" hidden="true" align="center" width="10" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="jzfamc" header="救助活动" field="planName" width="100" align="center" >
			<next:TextField  />
		</next:Column>
		<next:Column id="jzlxdm" header="救助项目" field="planType" width="100" align="center" dataset="jzlxDs">
			<next:TextField  />
		</next:Column>
		<next:Column id="jzdwmc" header="救助单位" field="planOrgName" width="100" align="center">
			<next:NumberField  />
		</next:Column>
		<next:Column id="jzrqQ" header="开始时间" field="planBegin" width="80" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="jzrqZ" header="结束时间" field="planEnd" width="80" align="center" >
			<next:TextField  />
		</next:Column>
		<next:Column id="jzhs" header="救助户数" field="familyNum" summaryType="sum" width="80" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="jzrs" header="救助人数" field="peopleNum" summaryType="sum" width="80" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="jzzjJe" header="资金投入（元）" field="fund" summaryType="sum" width="100" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="ssztbz" header="实施状态标志" field="status" width="100" hidden="true" align="center">
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