<%@ page contentType="text/html; charset=utf-8"
	import="com.inspur.sdmz.comm.util.*"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>

<%	
	String struId = BspUtil.getStruId();
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
%>
<script language="javascript">
	var organArea = "<%=organArea%>";
	 var struId='<%=struId%>';
</script>
<html>
<head>
<title>救助活动查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jzfassQuery.js"></script>
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
<body style="width: 100%">
<model:datasets>
	<model:dataset id="DmJzlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" pageSize="20" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jzfaDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" global="true" autoLoad="false" pageSize="10">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
			<model:params>
				<model:param name="STATUS" value='1'></model:param>
			</model:params>
			<model:params>
				<model:param name="REG_ORGAN_TYPE" value='A1'></model:param>
			</model:params>
	</model:dataset>
	<model:dataset id="sjtjDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" method="sjtjss" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="jzfaUpdateDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" method="jzfaQuery" autoLoad="true" global="true" pageSize="10">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="jzfaDatasetNew" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd"  global="true" >
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel autoScroll="true">
	<next:AnchorLayout>
		<next:Panel width="98%" border="0"
			bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件<img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>"
					onclick="collapse(this)" /></legend>
				<div>
				<form onsubmit="return false;" class="L5form">
				<table border="0"
					style="width: 98%; word-wrap: break-word; overflow: hidden;">
					<tr>
						<td class="FieldLabel" width="10%" nowrap="nowrap">救助类型：</td>
						<td class="FieldInput" width="20%" nowrap="nowrap"><select name="plantype" field="planType" style="width: 60%"><option dataset="DmJzlxDataSet"></option></select></td>
						<td class="FieldLabel" width="10%" nowrap="nowrap">救助方案名称：</td>
						<td class="FieldInput" width="20%" nowrap="nowrap"><input type="text" id="planName" style="width: 60%" class="TextEditor" /></td>
						<td class="FieldLabel" width="10%">所属单位:</td>
						<td class="FieldInput" width="20%"><input type="text" style="width:60%"  id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" />
							<input type="text" style="display: none;"  name="lrdwId" id="lrdwIdquery" field="lrdwId" />
							<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="10%" nowrap="nowrap">救助开始日期：</td>
						<td class="FieldInput" width="20%"><input type="text" id="planBegin"
							format="Y-m-d" name="planbegin" field="planBegin"
							onclick="LoushangDate(this)" style="width: 70"
							readonly="readonly" /> ----- <input type="text" id="planEnd"
							format="Y-m-d" name="planend" field="planEnd"
							onclick="LoushangDate(this)" style="width: 70"
							readonly="readonly" /></td>
						<td class="FieldLabel" width="10%" nowrap="nowrap">录入日期：</td>
						<td class="FieldInput" width="20%"><input type="text" id="lrrqQ"
							format="Y-m-d" name="lrrqQ" field="regTime" style="width: 70"
							onclick="LoushangDate(this)" readonly="readonly" /> ----- <input
							type="text" id="lrrqZ" format="Y-m-d" name="lrrqZ"
							field="regTime" onclick="LoushangDate(this)" style="width: 70"
							readonly="readonly" /></td>
						<td class="FieldLabel" width="10%"></td>
						<td class="FieldInput" width="20%">
						<center>
						<button type="button" onclick="query()">查 询</button>
						<button type="reset">重 置</button>
						</center>
						</td>
					</tr>
				</table>
				</form>
				</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="jzfaGrid" name="grid" notSelectFirstRow="true"
			width="98%" stripeRows="true" height="280" dataset="jzfaDataset">
			<next:TopBar>
				<next:ToolBarItem symbol="->" />
		<%if(organArea.substring(4,12).equals("00000000")||organArea.substring(6,12).equals("000000")){ %>
				<next:ToolBarItem iconCls="edit" text="修改方案" handler="forupdate"/>
		<%} %>
				<next:ToolBarItem iconCls="query" text="查看" handler="query2" />
				<next:ToolBarItem iconCls="detail" text="明细" handler="detail" />
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column header="救助方案ID" field="planId" width="180" hidden="true" sortable="true" />
				<next:Column header="救助方案名称" field="planName" id="planName" width="100" sortable="true" />
				<next:Column header="救助类型" field="planType" id="planType" width="100" dataset="DmJzlxDataSet" sortable="true" />
				<next:Column header="救助单位" field="planOrgName" id="planOrgName" width="100" />
				<next:Column header="开始日期" field="planBegin" width="100" align="center" sortable="true" />
				<next:Column header="结束日期" field="planEnd" width="100" align="center" sortable="true" />
				<next:Column header="救助资金金额" field="fund" width="100" align="right" sortable="true" />
				<next:Column header="救助户数" field="familyNum" width="80" align="right" sortable="true" />
				<next:Column header="救助人数" field="peopleNum" width="80" align="right" sortable="true" />
				<next:Column header="登记单位" field="regOrgName" width="80" sortable="true" />
				<next:Column header="登记时间" field="regTime" width="140" align="center" sortable="true" />
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="jzfaDataset" />
			</next:BottomBar>
		</next:GridPanel>
		<next:Panel width="98%" border="0"
			bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">数据统计</legend>
				<div>
				<form onsubmit="return false;" dataset="sjtjDataset">
				<table border="0" width="90%">
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
<next:Window id="jzfaWin" title="救助方案查询" width="550" height="200"
	closeAction="hide" modal="true" resizable="true">
	<next:AnchorLayout>
		<next:Panel title="基本信息" collapsible="true">
			<next:Html>
				<form id="jzfaForm" name="jzfaForm" method="post"
					dataset="jzfaUpdateDataset" onsubmit="return false" class="L5form">
			<table border="0" width="98%">
						<tr>
							<td class="FieldLabel" style="width:10%">救助方案名称:</td>
							<td class="FieldInput"><label name="jzfamcInsert" field="planName" readonly="readonly"/></td>
							<td class="FieldLabel" style="width:10%">救助单位:</td>
							<td class="FieldInput"><label name="jzdwmc" field="planOrgName" readonly="readonly"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%">救助类型:</td>
							<td class="FieldInput" style="width:20%"><label name="jzlxdm" field="planType" dataset="DmJzlxDataSet"></label></td>
							<td class="FieldLabel" style="width:10%">救助资金金额:</td>
							<td class="FieldInput" style="width:20%"><label name="jzzjJe" field="fund"  readonly="readonly"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">开始日期:</td>
							<td class="FieldInput"><label format="Y-m-d" name="jzrqQ" field="planBegin" readonly="readonly"/></td>
							<td class="FieldLabel">结束日期:</td>
							<td class="FieldInput"><label format="Y-m-d" name="jzrqZ" field="planEnd" readonly="readonly"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">救助户数:</td>
							<td class="FieldInput"><label name="jzhs" field="familyNum"  readonly="readonly"/></td>
							<td class="FieldLabel">救助人数:</td>
							<td class="FieldInput"><label name="jzrs" field="peopleNum"  readonly="readonly"/></td>
						</tr>
					</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:Window>
<next:Window id="jzfaUpdateWin" title="救助方案修改" width="550" height="300" closeAction="hide" modal="true" resizable="true">
	<next:AnchorLayout>
		<next:Panel title="基本信息" collapsible="true">
			<next:Html>
				<form id="jzfaUpdateForm" name="jzfaUpdateForm" method="post" dataset="jzfaUpdateDataset" onsubmit="return false" class="L5form">
					<table border="0" width="98%">
						<tr>
							<td class="FieldLabel" style="width:10%">救助方案名称:</td>
							<td class="FieldInput"><input type="text" name="jzfamc" field="planName" maxlength="50"/><font color="red">*</font></td>
							<td class="FieldLabel" style="width:10%">救助单位:</td>
							<td class="FieldInput"><input type="text" name="jzdwmc" field="planOrgName" readonly="readonly"/><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%">救助类型:</td>
							<td class="FieldInput" style="width:20%"><select name="jzlxdm" field="planType"><option dataset="DmJzlxDataSet" value="1"></option></select><font color="red">*</font></td>
							<td class="FieldLabel" style="width:10%">救助资金金额:</td>
							<td class="FieldInput" style="width:20%"><input type="text" name="jzzjJe" field="fund" readonly="true"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">开始日期:</td>
							<td class="FieldInput"><input type="text" id="planBegin" format="Y-m-d" name="jzrqQ" field="planBegin" onclick="LoushangDate(this)" readonly="readonly"/> <font color="red">*</font></td>
							<td class="FieldLabel">结束日期:</td>
							<td class="FieldInput"><input type="text" id="planEnd" format="Y-m-d" name="jzrqZ" field="planEnd" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">救助户数:</td>
							<td class="FieldInput"><input type="text" name="jzhs" field="familyNum" readonly="true"/></td>
							<td class="FieldLabel">救助人数:</td>
							<td class="FieldInput"><input type="text" name="jzrs" field="peopleNum" readonly="true"/></td>
						</tr>
						 <input type="hidden" name="regOrganType" id="regOrganType" value="A1" />
					</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
	<next:Buttons>
		<next:ToolButton text="确认" handler="update"></next:ToolButton>
		<next:ToolButton text="关闭" handler="hideUpdateWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>