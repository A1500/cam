<%@ page contentType="text/html; charset=utf-8" import="com.inspur.sdmz.comm.util.*"%>
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
<title>救助活动查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jzfafxQuery.js"></script>
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
<body style="width:100%">
<model:datasets>
	<model:dataset id="jzfaDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" global="true" pageSize="10">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
			<model:params>
				<model:param name="REG_ORGAN_TYPE" value='A1'></model:param>
			</model:params>
	</model:dataset>
	<model:dataset id="sjtjDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" method="sjtjAnalyze" global="true" autoLoad="false" pageSize="10">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="dictSet" cmd="org.loushang.bsp.dict.DataDictQuery" global="true">
		<model:record>
			<model:field name="text" mapping="ITEM_VALUE" type="string"/>
			<model:field name="value" mapping="ITEM_CODE" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="ssztbzDataset" enumName="SSZTBZ.TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="98%" autoScroll="true" autoWidth="true">
	<next:AnchorLayout> 
		<next:Panel width="99%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
					<div>
						<form style="width:99%; height: 99%;" class="L5form">
							<table border="1" style="width:99%;word-wrap:break-word;overflow:hidden;">
								<tr>
									<td class="FieldLabel" width="10%">活动状态：</td>
									<td class="FieldInput" width="20%">
									<select name="status" field="status">
										<option dataset="ssztbzDataset"></option>
									</select></td>
									<td class="FieldLabel" width="10%"  nowrap="nowrap">救助方案名称：</td>
									<td class="FieldInput" width="25%"><input type="text" id="planName" class="TextEditor"/></td>
									<td class="FieldLabel" width="10%" nowrap="nowrap">救助单位名称：</td>
									<td class="FieldInput" width="20%"><input type="text" id="planOrgName" class="TextEditor"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="10%">开始日期：</td>
									<td class="FieldInput" width="25%" colspan="1"><input type="text" id="planBegin" format="Y-m-d" style="width:70" name="jzrqQ" field="planBegin" onclick="LoushangDate(this)" readonly="readonly"/>-----<input type="text" id="planEnd" style="width:70"  format="Y-m-d" name="jzrqZ" field="planEnd" onclick="LoushangDate(this)" readonly="readonly"/></td>
								    <td class="FieldLabel" width="10%" nowrap="nowrap"  >录入日期：</td>
									<td class="FieldInput" ><input type="text" id="lrrqQ" format="Y-m-d" style="width:70"  name="lrrqQ" field="regtime" onclick="LoushangDate(this)" readonly="readonly"/>-----
									<input type="text" id="lrrqZ" format="Y-m-d" style="width:70"  name="lrrqZ" field="regtime" onclick="LoushangDate(this)" readonly="readonly"/></td>
									<td class="FieldInput"  colspan="2"  ><center><button type="button" onclick="query()">查  询</button><button type="reset">重  置</button></center></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="jzfaGrid" name="grid" notSelectFirstRow="true"
			 width="98%" stripeRows="true" height="270" dataset="jzfaDataset" autoWidth="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"/>
				<next:ToolBarItem iconCls="query" text="查看方案" handler="detail"/>
				<next:ToolBarItem iconCls="add" text="分析选中活动" handler="analyze"/>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30"/>
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column header="救助方案ID" field="planId"   hidden="true" sortable="true"/>
				<next:Column header="救助方案名称" field="planName" width="100" sortable="true"/>
				<next:Column header="救助单位" field="planOrgName" width="100" sortable="true"/>
				<next:Column header="救助类型" field="assistedType" id="jzlxdm"  dataset="dictSet" sortable="true"/>
				<next:Column header="开始日期" field="planBegin"  width="80" align="center" sortable="true"/>
				<next:Column header="结束日期" field="planEnd" width="80" align="center" sortable="true"/>
				<next:Column header="救助资金金额" field="fund" width="100" align="right" sortable="true"/>
				<next:Column header="救助户数" field="familyNum"  width="60" align="right" sortable="true"/>
				<next:Column header="救助人数" field="peopleNum"  width="60" align="right" sortable="true"/>
				<next:Column header="登记单位" field="regOrgName" width="80" sortable="true"/>
				<next:Column header="登记时间" field="regTime" width="140" align="center" sortable="true"/>
			</next:Columns>
			<next:BottomBar><next:PagingToolBar dataset="jzfaDataset"/></next:BottomBar>
		</next:GridPanel>
		<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">数据统计</legend>
					<div>
						<form onsubmit="return false;" dataset="sjtjDataset">
							<table border="0" width="100%">
								<tr>
									<td class="FieldLabel">救助户数</td>
									<td class="FieldInput"><input type="text" id="familySum" field="FAMILYSUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">救助人数</td>
									<td class="FieldInput"><input type="text" id="peopleSum" field="PEOPLESUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">投入资金</td>
									<td class="FieldInput"><input type="text" id="moneySum" field="MONEYSUM" class="TextEditor" readonly="readonly"/></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
	</next:Panel>
</body>
</html>