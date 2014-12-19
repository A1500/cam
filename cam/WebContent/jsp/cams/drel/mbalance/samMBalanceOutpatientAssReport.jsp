<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>定点医疗机构门规信息列表</title>
<next:ScriptManager />
<script type="text/javascript" src="samMBalanceOutpatientAssReport.js"></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
			var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
			var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';;
		</script>
<script language="javascript">
	 	     //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){	
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';	
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";				
					element.expand =true;
				}
			}
		</script>

</head>

<body>
<model:datasets>
	<!-- 医院 -->
	<model:dataset id="extOrganDs"
		cmd="com.inspur.cams.comm.extuser.cmd.ComExtOrganQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtOrgan"></model:record>
	</model:dataset>

	<model:dataset id="hosDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd"
		global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='com_ext_organ'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ds"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpQueryCmd"
		method="queryForClinic" pageSize="10">
	</model:dataset>
	<!-- 个人信息 -->
	<model:dataset id="peopleDS"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
	<!-- 个人信息 -->
	<model:dataset id="basePeopleDs"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
	<model:dataset id="basePeopleDs2"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
	<model:dataset id="signDS" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="typeDS" enumName="EXT.BPTTYPE" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="sexDS" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="DmJzlxDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		pageSize="20" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel name="dep_rule" width="100%">
	<next:Html>
		<fieldset><legend>查询条件 <img
			class="GroupBoxExpandButton"
			src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
			onclick="collapse(this);" /> </legend>
		<div>
		<form class="L5form"><input type="hidden" id="peopleId"
			name="人员信息" /> <input type="hidden" name="regTime" id="regTime"
			value="<%=DateUtil.getTime() %>" title="录入时间" />
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="15%">医院名称:</td>
				<td width="10%"><input type="text" id="hosName" readonly="readonly" onclick="backHos();" /></td>
				<td style="display: none;"><input  type="text"  id="hosId" /></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">补助日期：</td>
				<td class="FieldInput" nowrap="nowrap"><input type="text"
					id="beginTime" format="Y-m-d" name="beginTime" style="width: 35%"
					onclick="LoushangDate(this)" readonly="readonly" /> ----- <input
					type="text" id="endTime" format="Y-m-d" name="endTime"
					style="width: 35%" onclick="LoushangDate(this)" readonly="readonly" /></td>
				<td class="FieldButton" width="10%">
				<button onclick="query();">查 询</button>
				</td>
				<td class="FieldButton" width="10%">
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="rule_Grid" name="rule_Grid" dataset="ds"
	title="普通门规查询报表" stripeRows="true" notSelectFirstRow="true"
	autoScroll="true" collapsible="true" width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="detail_rules"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="10" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="hospitalId" header="医院" field="ORGAN_NAME"
			width="15%">
			<next:TextField />
		</next:Column>
		<next:Column id="totalExpense" header="总费用(元)" field="SUMTOTAL" align="right" 
			width="10%" renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column id="specialPay" header="救助金额(元)" field="SUMSPEC" width="15%" align="right" 
			renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column id="SUMPSN" header="自付费用(元)" field="SUMPSN" width="15%" align="right" 
			renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column id="SUMNUM" header="人次" field="SUMNUM" width="10%">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="selectHosWin" height="300" width="380"
	closeAction="hide">
	<next:Panel width="98%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="查询" iconCls="query" handler="selectHos"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="select" handler="pickHos"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="return" handler="colseWin"></next:ToolBarItem>
			<next:ToolBarItem text="清除" iconCls="no" handler="removeName"></next:ToolBarItem>
		</next:TopBar>
		<next:Panel>
			<next:Html>
				<table>
					<tr>
						<td>医院：</td>
						<td><input type="text" id="qhosName" /></td>
					</tr>
				</table>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="hosGrid" dataset="extOrganDs" height="230">
			<next:Columns>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column field="organName" header="医院名称">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column field="organId" header="医院ID" width="220">
					<next:TextField></next:TextField>
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="extOrganDs" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:Window>
</body>
</html>