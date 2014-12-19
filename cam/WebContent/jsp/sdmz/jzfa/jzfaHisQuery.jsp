<%@ page contentType="text/html; charset=utf-8" import="com.inspur.sdmz.comm.util.*"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%
   String organArea = BspUtil.getCorpOrgan().getOrganCode();
%>
<script language="javascript">
	var organArea = "<%=organArea%>";
</script>
<html>
<head>
<title>救助历史信息</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jzfaHisQuery.js "></script>
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
<body >
<model:datasets>
	<model:dataset id="familyDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" method="getFamilyAssist"   pageSize="10">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="personDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" method="getPersonAssist"   pageSize="10">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="otherPersonDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" method="getOtherPersonAssist">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="DmJzlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" pageSize="20" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel autoScroll="true">
	<next:AnchorLayout>
		<next:Panel name="form" width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
					<div>
						<form onsubmit="return false;" class="L5form">
							<table border="1" style="width:98%;word-wrap:break-word;overflow:hidden;">
								<tr>
									<td class="FieldLabel" width="10%" nowrap="nowrap">救助类型：</td>
									<td class="FieldInput" width="20%"><select id="planType" name="plantype" field="planType" style="width: 80%"><option dataset="DmJzlxDataSet"></option></select></td>
									<td class="FieldLabel" width="10%" nowrap="nowrap">救助对象名称：</td>
									<td class="FieldInput" width="20%"><input type="text" id="assistedName" class="TextEditor" /></td>
									<td class="FieldLabel" width="10%" nowrap="nowrap">救助对象身份证：</td>
									<td class="FieldInput" width="20%"><input type="text" id="assistedIdCard" class="TextEditor" style="width:140"/></td>
									<td class="FieldInput" width="10%"><button onclick="query()">查  询</button></td>									
								</tr>
								<tr>
									<td class="FieldLabel" width="10%" nowrap="nowrap">救助单位名称：</td>
									<td class="FieldInput" width="20%"><input type="text" id="assistedOrganName" class="TextEditor"/></td>
								    <td class="FieldLabel" width="10%" nowrap="nowrap">受助日期：</td>
									<td class="FieldInput" ><input type="text" id="planBegin" format="Y-m-d" name="planbegin" field="planBegin" onclick="LoushangDate(this)" style="width:70" readonly="readonly"/> -----
									<input type="text" id="planEnd" format="Y-m-d" name="planend" field="planEnd" onclick="LoushangDate(this)" style="width:70" readonly="readonly"/></td>
									<td class="FieldLabel" width="10%" nowrap="nowrap">录入日期：</td>
									<td class="FieldInput"><input type="text" id="lrrqQ" format="Y-m-d" name="lrrqQ" field="regTime" style="width:70"  onclick="LoushangDate(this)" readonly="readonly"/> -----
									<input type="text" id="lrrqZ" format="Y-m-d" name="lrrqZ" field="regTime" onclick="LoushangDate(this)" style="width:70"  readonly="readonly"/></td>
								    <td class="FieldInput" width="10%"><button type="reset">重  置</button></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="familyDataset" name="grid" notSelectFirstRow="true" title="家庭救助历史信息"  width="99%" stripeRows="true" height="150" dataset="familyDataset" >
			<next:Columns>
				<next:RowNumberColumn width="30"/>
				<next:Column header="救助方案ID" field="PLAN_ID" width="180" hidden="true" sortable="true"/>
				<next:Column header="救助类型" field="PLAN_TYPE" width="150" align="center" sortable="true" dataset="DmJzlxDataSet"/>
				<next:Column header="方案名称" field="PLAN_NAME" width="150" align="center" sortable="true"/>
				<next:Column header="受助对象" field="ASSISTED_NAME" id="ASSISTED_NAME" width="100" sortable="true"/>
			    <next:Column header="受助对象身份证" field="ID_CARD" id="ID_CARD" width="100" />
				<next:Column header="救助日期" id="ASSITANCE_DATE" field="ASSITANCE_DATE" width="100" align="center" sortable="true"/>
				<next:Column header="救助资金合计金额" id="TOTAL_FUND" field="TOTAL_FUND" width="200" align="center" sortable="true"/>
				<next:Column header="救助单位名称" field="PLAN_ORGAN_NAME" width="100" align="right" sortable="true"/>
			</next:Columns>
			<next:BottomBar><next:PagingToolBar dataset="familyDataset"/></next:BottomBar>
		</next:GridPanel>
		<next:GridPanel id="personDataset" name="grid" notSelectFirstRow="true" title="本人救助历史信息" width="99%" stripeRows="true" height="150" dataset="personDataset">
			<next:Columns>
				<next:RowNumberColumn width="30"/>
		        <next:Column header="救助方案ID" field="PLAN_ID" width="180" hidden="true" sortable="true"/>
		        <next:Column header="救助类型" field="PLAN_TYPE" width="150" align="center" sortable="true" dataset="DmJzlxDataSet"/>
				<next:Column header="方案名称" field="PLAN_NAME" width="150" align="center" sortable="true"/>
				<next:Column header="受助对象" field="ASSISTED_NAME" id="ASSISTED_NAME" width="100" sortable="true"/>
			    <next:Column header="受助对象身份证" field="ID_CARD" id="ID_CARD" width="100" />
				<next:Column header="救助日期" id="ASSITANCE_DATE" field="ASSITANCE_DATE" width="100" align="center" sortable="true"/>
				<next:Column header="救助资金合计金额" id="TOTAL_FUND" field="TOTAL_FUND" width="200" align="center" sortable="true"/>
				<next:Column header="救助单位名称" field="PLAN_ORGAN_NAME" width="100" align="right" sortable="true"/>
			</next:Columns>
			<next:BottomBar><next:PagingToolBar dataset="personDataset"/></next:BottomBar>
		</next:GridPanel>
		<next:GridPanel id="otherPersonDataset" name="grid" notSelectFirstRow="true" title="家庭其他成员救助历史信息"  width="99%" stripeRows="true" height="150" dataset="otherPersonDataset" >
			<next:Columns>
				<next:RowNumberColumn width="30"/>
				<next:Column header="救助方案ID" field="PLAN_ID" width="180" hidden="true" sortable="true"/>
				<next:Column header="救助类型" field="PLAN_TYPE" width="150" align="center" sortable="true" dataset="DmJzlxDataSet"/>
				<next:Column header="方案名称" field="PLAN_NAME" width="150" align="center" sortable="true"/>
				<next:Column header="受助对象" field="ASSISTED_NAME" id="ASSISTED_NAME" width="100" sortable="true"/>
			    <next:Column header="受助对象身份证" field="ID_CARD" id="ID_CARD" width="100" />
				<next:Column header="救助日期" id="ASSITANCE_DATE" field="ASSITANCE_DATE" width="100" align="center" sortable="true"/>
				<next:Column header="救助资金合计金额" id="TOTAL_FUND" field="TOTAL_FUND" width="200" align="center" sortable="true"/>
				<next:Column header="救助单位名称" field="PLAN_ORGAN_NAME" width="100" align="right" sortable="true"/>
			</next:Columns>
			<next:BottomBar><next:PagingToolBar dataset="otherPersonDataset"/></next:BottomBar>
		</next:GridPanel>
		
		
		
		
   </next:AnchorLayout>
</next:Panel>
</body>
</html>