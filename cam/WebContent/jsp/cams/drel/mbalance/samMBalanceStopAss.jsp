<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>一站结算住院登记列表</title>
<next:ScriptManager />
<script type="text/javascript">
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>
<script type="text/javascript" src="samMBalanceStopAss.js"></script>
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
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 住院登记信息 -->
	<model:dataset id="gvnListDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamList"  sortField="inTime" sortDirection="desc">
	</model:dataset>
	<model:dataset id="hosDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance"></model:record>
	</model:dataset>
	<!-- 救助状态 -->
	<model:dataset id="statusDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMStatusQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMStatus"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MEDICAL_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="assitanceTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='01,02,03,11'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="hosStatusDataset" enumName="HOS_STATUS"
		autoLoad="true">
	</model:dataset>
	<!-- 证书类型 -->
	<model:dataset id="cardTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_sam_card_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助状态 -->
	<model:dataset id="StatusDataset" enumName="STATUS" autoLoad="true">
	</model:dataset>
	<!-- 医院 -->
	<model:dataset id="extOrganDs"
		cmd="com.inspur.cams.comm.extuser.cmd.ComExtOrganQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtOrgan"></model:record>
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
				<td class="FieldLabel">身份证号码：</td>
				<td class="FieldInput"><input type="text" maxlength="18" id="idCard"
					class="TextEditor" title="身份证号码" /></td>
					<td class="FieldLabel">救助类型：</td>
				<td class="FieldInput"><select id="assitanceType"
					name="assitanceType" field="assitanceType">
					<option dataset="assitanceTypeDataset"></option>
				</select></td>
				
				<td class="FieldLabel">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="15%">医院名称:</td>
				<td class="FieldInput">
				  <input type="text" id="hosName" readonly="readonly" onclick="backHos();" />
				  <input  type="hidden"  id="hosId" />
				</td>
				<td class="FieldLabel">入院时间：</td>
				<td class="FieldInput"><input type="text" name="inTime"
					id="inTime" format="Y-m-d" readonly="readonly"
					onclick="LoushangDate(this)"></td>
			    <td class="FieldLabel">
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
	width="99.9%" stripeRows="true" height="100%" dataset="gvnListDS"
	title="住院登记信息列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="停助" iconCls="remove" handler="stopAss" />
		<next:ToolBarItem text="恢复救助" iconCls="add" handler="resumeAss" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
        
		<next:Column id="peopleId" header="姓名" field="NAME" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="peopleId" header="身份证号" field="ID_CARD" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="hospitalName" header="医院" field="HOSPITAL_NAME" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="hospitalRecordId" header="住院号"
			field="HOSPITAL_RECORD_ID" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="status" header="救助状态" field="STATUS"
			dataset="StatusDataset" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="病种" field="DISEASE" width="130" sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="insuranceType" header="保险险种" field="INSURANCE_TYPE"
			width="130">
			<next:ComboBox dataset="SafeguardDataset" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column id="assitanceType" header="医疗救助类型" field="ASSITANCE_TYPE"
			width="90">
			<next:ComboBox dataset="assitanceTypeDataset" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		
		<next:Column id="inTime" header="入院日期" field="IN_DATE" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="gvnListDS" />
	</next:BottomBar>
</next:GridPanel>
<!-- 停助窗口 -->
<next:Window id="stopAssWin" closeAction="hide" width="500" height="170"  title="停助">
	<next:AnchorLayout>
		<next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="确定" handler="saveStop" />
				<next:ToolBarItem iconCls="undo" text="取消" handler="undoStop" />
			</next:TopBar>
			<next:Html>
				<form id="editForm"  onsubmit="return false" dataset="statusDataset"
					style="padding: 5px;" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel">原因：</td>
						<td class="FieldInput" colspan="3"><TextArea field="note" cols="60" rows="3"></TextArea></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="17%">姓名</td>
						<td class="FieldInput"><label id="stopName" name="name"></label></td>
						<td class="FieldLabel" width="17%">身份证件号码</td>
						<td class="FieldInput"><label id="stopIdCard" name="idCard"></label></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:Window>
<!-- 恢复救助窗口 -->
<next:Window id="resumeAssWin" closeAction="hide" width="500" height="170"  title="恢复救助">
	<next:AnchorLayout>
		<next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="确定" handler="saveResume" />
				<next:ToolBarItem iconCls="undo" text="取消" handler="undoResume" />
			</next:TopBar>
			<next:Html>
				<form id="editForm1"  onsubmit="return false" dataset="statusDataset"
					style="padding: 5px;" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel">原因：</td>
						<td class="FieldInput" colspan="3"><TextArea field="note" cols="60" rows="3"></TextArea></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="17%">姓名</td>
						<td class="FieldInput"><label id="resumeName" name="name"></label></td>
						<td class="FieldLabel" width="17%">身份证件号码</td>
						<td class="FieldInput"><label id="resumeIdCard" name="idCard"></label></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:Window>
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
