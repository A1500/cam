<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>一站式结算住院结算按医院、时间段查询条件统计报表</title>
<next:ScriptManager />
<script>
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>

<script type="text/javascript" src="samMBalanceReportByHosBpt.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
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
	<!-- 一站式救助报表统计 -->
	<model:dataset id="reportDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForBpt">
		<model:record>
			<model:field name="bptName" type="string" />
			<model:field name="BPT_TYPE" type="string" />
			<model:field name="hospitalName" type="string" />
			<model:field name="HOSPITAL_ID" type="string" />
			<model:field name="HOSPITAL_AREA" type="string" />
			<model:field name="SUMTOTALEXP" type="string" />
			<model:field name="SUMINSEXP" type="string" />
			<model:field name="SUMINSPAY" type="string" />
			<model:field name="SUMHOSPITALPAY" type="string" />
			<model:field name="SUMSPECIALPAY" type="string" />
			<model:field name="SUMASSPAY" type="string" />
			<model:field name="SUMPERSONALPAY" type="string" />
			<model:field name="NUM" type="string" />
			<model:field name="ILLNESS_INSURANCE_PAY" type="string" />
		</model:record>
	</model:dataset>
	<!-- 医院 -->
	<model:dataset id="extOrganDs"
		cmd="com.inspur.cams.comm.extuser.cmd.ComExtOrganQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtOrgan"></model:record>
	</model:dataset>
	<!-- 医疗救助类型 -->
	<model:dataset id="assitanceTypeDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='01,02,03,11'></model:param>
		</model:params>
	</model:dataset>
	<!-- 优抚对象类别 -->
	<model:dataset id="bptTypeDS" enumName="SAM.MEDICAL.TYPE" global="true" autoLoad="true">
	</model:dataset>
	<!-- 属地 -->
	<model:dataset id="domicileDataset" autoLoad="false"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="99.9%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%">医院名称：</td>
				<td><input type="text" id="hosName" readonly="readonly" onclick="backHos();" /></td>
				<td style="display: none;"><input  type="text"  id="hosId" /></td>
					
				<td class="FieldLabel">优抚对象类别：</td>
				<td class="FieldInput"><select id="bptType" type="text" name="优抚对象类别"
					 id="bptType">
						<option dataset="bptTypeDS"></option>
					</select></td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">救助（补助）日期：</td>
				<td class="FieldInput" nowrap="nowrap" colspan="3"><input type="text"
					id="beginTime" format="Y-m-d" name="beginTime"
					onclick="LoushangDate(this)" readonly="readonly" /> ----- <input
					type="text" id="endTime" format="Y-m-d" name="endTime"
					onclick="LoushangDate(this)" readonly="readonly" /></td>
				<td class="FieldButton">
				<button type="reset">重 置</button></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
	width="99.9%" stripeRows="true" height="100%" dataset="reportDataset"
	title="住院结算报表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="inHosRegButton" iconCls="detail" text="查看明细"
			handler="lookDetail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="20" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		
		<next:Column id="hospitalName" header="医院" field="hospitalName" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="bptName" header="优抚对象类别" field="bptName" width="13%">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="sumTotalExp" header="住院总费用（元）" field="SUMTOTALEXP" align="right" 
			width="17%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumInsExp" header="纳入保险报销费用（元）" field="SUMINSEXP" align="right" 
			width="22%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumInsPay" header="保险支付金额（元）" field="SUMINSPAY" align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="illnessInsurancePay" header="商业保险金额（元）" field="ILLNESS_INSURANCE_PAY" align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumAssPay" header="医院减免金额（元）" field="SUMHOSPITALPAY" align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumAssPay" header="优抚补助金额（元）" field="SUMSPECIALPAY" align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumPersonalPay" header="自付费用（元）" field="SUMPERSONALPAY" align="right" 
			width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="num" header="人次" field="NUM" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="reportDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="selectHosWin" height="300" width="380"
	closeAction="hide">
	<next:Panel>
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
				<next:Column hidden="true" field="organId" header="医院ID" width="220">
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