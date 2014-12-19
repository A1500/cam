<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>

<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
%>
<script language="javascript">
	var organArea = "<%=organArea%>";
	
</script>
<html>
<head>
<title>明细查询列表</title>
<next:ScriptManager />
<script type="text/javascript">
<%
	String planId=new String(request.getParameter("planId").getBytes("ISO-8859-1"), "UTF-8");
	String returnJsp=new String(request.getParameter("returnJsp"));
	%>
	var planId = '<%=planId %>';
	var returnJsp = '<%=returnJsp %>';
</script>
<script type="text/javascript" src="jzfamxQuery.js"></script>
<script type="text/javascript" src="../jtxx/IDCard.js"></script>
<script type="text/javascript" src="../jtxx/jtxxComm.js"></script>
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
	<model:dataset id="jzfaInsertDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
	</model:dataset>
	<model:dataset id="jzfaUpdateDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
	</model:dataset>
	<model:dataset id="sjtjDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" method="sjtjmx" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
		<model:params>
			<model:param name="PLAN_ID" value='<%=request.getParameter("planId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jzfamxDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
		<model:params>
			<model:param name="PLAN_ID" value='<%=request.getParameter("planId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="szdxlxDataset" enumName="SZDXLX.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="DmJzfxDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_SIDE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel autoScroll="true" autoWidth="true">
<next:Panel name="form" width="99%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" title="->  您的位置 : 救助方案 >> 救助方案明细">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
		<div>
		<form style="width:99%; height: 100%;" class="L5form">
		<table border="1"  style="width:99%;word-wrap:break-word;overflow:hidden;">
			<tr>
				<td class="FieldLabel" nowrap="nowrap">受助人/单位名称:</td>
				<td class="FieldInput"><input type="text" id="assistedName" name="szdxmc" field="assistedName" ldclass="TextEditor" title="受助人" maxlength="50" /></td>
				<td class="FieldLabel">类型:</td>
				<td class="FieldInput"><select name="szdxlxdm" id="assistedType" field="assistedType">
										<option dataset="szdxlxDataset"></option>
										</select></td>
				<td class="FieldInput"><center><button onclick="query()">查  询</button></center></td>
			</tr>
			<tr>
				<td class="FieldLabel">开始日期:</td>
				<td class="FieldInput"><input type="text" id="planBegin" format="Y-m-d" style="width:70" name="planbegin" field="planBegin" onclick="LoushangDate(this)" readonly="readonly"/> 
				-----<input type="text" id="planEnd" format="Y-m-d" name="planend" style="width:70" field="planEnd" onclick="LoushangDate(this)" readonly="readonly"/> 
				</td>
				<td class="FieldLabel" width="10%" nowrap="nowrap" >录入日期：</td>
				<td class="FieldInput" colspan="1"><input type="text" id="lrrqQ" style="width:70" format="Y-m-d" name="lrrqQ" field="regTime" onclick="LoushangDate(this)" readonly="readonly"/>-----
				<input type="text" id="lrrqZ" format="Y-m-d" name="lrrqZ" style="width:70" field="regTime" onclick="LoushangDate(this)" readonly="readonly"/></td>
						
				<td class="FieldInput"><center><button type="reset">重  置</button></center></td>
			</tr>
		</table>
		<input type="hidden" name="planId" value='<%=request.getParameter("planId")%>'>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="editGridPanel" width="99%" stripeRows="true" height="250" dataset="jzfamxDataset" notSelectFirstRow="true" title="明细查询">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="rePage"/>
</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="szdxmc" header="受助人/单位名称" field="assistedName" width="120" sortable="true" >
			<next:TextField />
		</next:Column>
		<next:Column id="szdxlxdm" header="类型" field="assistedType" width="120" sortable="true" dataset="szdxlxDataset">
			<next:TextField />
		</next:Column>

		<next:Column id="jzrq" header="受助日期" field="assitanceDate" width="120" align="center" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="jzzjxjJe" header="救助资金现金金额" field="captial" width="120" align="right" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="jzwpmc" header="救助物品名称" field="goodsName" width="120" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="jzwpsl" header="救助物品数量" field="goodsNum" width="120" align="right" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="jzwpzjJe" header="救助物品折价金额" field="goodsNums" width="120" align="right" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="jzzjhjJe" header="合计金额" field="totalFund" width="120" align="right" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="jzfx" header="救助方向" field="assistedSide" width="120"  sortable="true" dataset="DmJzfxDataset">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jzfamxDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Panel width="99%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">数据统计</legend>
					<div>
						<form onsubmit="return false;" dataset="sjtjDataset">
							<table border="0" width="99%">
								<tr>
									<td class="FieldLabel">救助人数</td>
									<td class="FieldInput"><input type="text" id="peopleSum" field="PEOPLESUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">救助资金</td>
									<td class="FieldInput"><input type="text" id="moneySum" field="MONEYSUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">物品折款</td>
									<td class="FieldInput"><input type="text" id="goodsSum" field="GOODSSUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">合计</td>
									<td class="FieldInput"><input type="text" id="totalSum" field="TOTALSUM" class="TextEditor" readonly="readonly"/></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		</next:Panel>

</body>
</html>
