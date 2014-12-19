<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%
	//String struId = BspUtil.getStruId();
	String organArea = ExtBspInfo.getUserInfo(request).getAreaCode();
	String organType = ExtBspInfo.getUserInfo(request).getOrganType();
%>
<html>
<head>
<title>阳光救助_家庭信息列表</title>
<next:ScriptManager />
<script type="text/javascript" src="ygjzjtxx_list.js"></script>
<script type="text/javascript" src="IDCard.js"></script>
<script type="text/javascript" src="jtxxComm.js"></script>
<script type="text/javascript" src="multiGrid.js"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>

<script language="javascript">
		 	 //查询条件打开合并函数
		 	 var organArea='<%= organArea%>';
		 	 var organType='<%= organType%>';
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
	<model:dataset id="DmOpinionDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_OPINION'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmActivityDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ACTIVITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	 <model:dataset id="DmJzlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" pageSize="20" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="roleGroupDataSet"
		cmd="org.loushang.bsp.permit.pap.rolegroup.cmd.RoleGroupQueryCmd"
		global="true">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.rolegroup.data.RoleGroup">
			<model:field name="useCorporation" type="string" />
			<model:field name="useCorporationName" type="string" />
		</model:record>
	</model:dataset>

	<model:dataset id="ds" cmd="com.inspur.sdmz.jtxx.cmd.JtxxQueryCommand"
		autoLoad="false">
		<model:params>
			<model:param name="CUR_ACTIVITY" value='EXAM'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jtxxNumDs"
		cmd="com.inspur.sdmz.jtxx.cmd.JtxxQueryCommand" global="true"
		autoLoad="false" method="getJtxxNum">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoFamily"></model:record>
		<model:params>
			<model:param name="CUR_ACTIVITY" value='EXAM'></model:param>
		</model:params>
	</model:dataset>

</model:datasets>

<next:Panel name="form" width="98%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form id="queryForm" style="width: 99%; height: 100%;" class="L5form">
		<table border="1" style="width: 100%; table-layout: fixed;">
			<tr>
				<td class="FieldLabel" width="15%">户主姓名:</td>
				<td class="FieldInput" width="25%"><input type="text"
					id="hzxmquery" name="hzxmquery" maxlength="25" class="TextEditor"
					title="户主姓名" style="width: 80%"/><font color="red">*</font></td>
				<td class="FieldLabel" width="15%">户主身份证:</td>
				<td class="FieldInput" width="25%"><input type="text"
					id="sfzhquery" maxlength="18" style="width: 80%" class="TextEditor"
					title="户主身份证" /></td>
				<input type="hidden" name="shbz" id="shbzquery" />
					<td class="FieldInput" style="text-align: center">
				<button onclick="jtxxQuery()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap" width="15%">救助类型:</td>
				<td class="FieldInput"  width="25%"><input type="text" id="jzlxDisplay"
					style="width: 65%" readOnly="true"
					ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" /> <img
					src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
					style="cursor: hand"
					onclick="mutiHelp('DmJzlxDataSet','jzlxDisplay','jzlxquery')" /> <input
					type="hidden" id="jzlxquery"></td>
				<td class="FieldLabel" width="15%" nowrap="nowrap" width="25%">录入日期：</td>
				<td class="FieldInput" nowrap="nowrap"><input type="text"
					id="lrrqQ" format="Ymd" name="lrrqQ" style="width: 35%" 
					onclick="LoushangDate(this)" readonly="readonly" /> ----- <input
					type="text" id="lrrqZ" format="Ymd" name="lrrqZ" style="width: 35%" 
					onclick="LoushangDate(this)" readonly="readonly" /></td>
				<td class="FieldInput" style="text-align: center">
				<button onclick="reset()" >重 置</button>
				</td>
			</tr>
			<input type="hidden" name="queryFlag" id="queryFlag" value="EXAM" />
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="98%"
	stripeRows="true" height="295" dataset="ds" title="困难家庭信息审核列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="审核" iconCls="add" handler="jtxxExam" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="FAMILY_ID" header="家庭ID" field="FAMILY_ID"
			hidden="true" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="FAMILY_NAME" header="户主姓名" field="FAMILY_NAME"
			width="10%" align="center" renderer="jtxxExamHref" />
		<next:Column id="FAMILY_CARD_NO" header="身份证号" field="FAMILY_CARD_NO"
			width="20%" align="center" />
		<next:Column id="PEOPLE_NUM" header="人口数量" field="PEOPLE_NUM"
			width="10%" align="right" />
		<next:Column id="YEAR_INCOME" header="家庭年收入" field="YEAR_INCOME"
			width="12%" align="right" />
		<next:Column header="当前环节" width="10%" align="center"
			field="CUR_ACTIVITY" id="CUR_ACTIVITY" dataset="DmActivityDataSet" />
		<next:Column id="REG_PEOPLE" header="录入人姓名" field="REG_PEOPLE"
			width="11%" align="center" />
		<next:Column id="REG_ORG_NAME" header="录入单位名称" field="REG_ORG_NAME"
			width="11%" align="center" />
		<next:Column id="REG_TIME" header="录入时间" field="REG_TIME" width="11%"
			align="center" />
		<next:Column id="PHOTO_ID" header="照片ID" field="PHOTO_ID" 
			hidden="true" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
<!--<next:Panel autoWidth="true" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">数据统计</legend>
		<div>
		<form onsubmit="return false;" dataset="jtxxNumDs">
		<table border="0" width="70%">
			<tr>
				<td class="FieldLabel" width="20%">困难家庭户数:</td>
				<td class="FieldInput" width="25%"><label id="hsnum"
					name="hsnum" field="HSNUM" /></td>
				<td class="FieldLabel" width="20%">困难家庭成员人数:</td>
				<td class="FieldInput" width="25%"><label id="rsnum"
					name="rsnum" field="RSNUM" /></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
--></body>
</html>
