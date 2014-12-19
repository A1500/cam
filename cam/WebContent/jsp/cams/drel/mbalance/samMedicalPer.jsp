<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
<!-- 一站结算_救助比例主页面-->
<head>
<script type="text/javascript">
   var struId='<%=BspUtil.getStruId()%>';
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organName='<%=BspUtil.getDeptOrgan().getOrganName()%>';
   var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samMedicalPer.js">
</script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!--  救助比例列表 -->
	<model:dataset id="SamMedicalPerDS" pageSize="10"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalPer">
				<model:field name="domicileName" type="string"/>
			</model:record>
	</model:dataset>
	
	<!--  救助比例列表 -->
	<model:dataset id="SamMedicalLastPerDS" pageSize="100"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalPer">
				<model:field name="domicileName" type="string"/>
			</model:record>
	</model:dataset>
	
	<!--  救助比例列表 -->
	<model:dataset id="SamMedicalLastCheckPerDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalPer">
				<model:field name="domicileName" type="string"/>
			</model:record>
	</model:dataset>
	
	<!--  救助比例（用于验证） -->
	<model:dataset id="querySamMedicalPerDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalPer">
				<model:field name="domicileName" type="string"/>
			</model:record>
	</model:dataset>
	<!-- 救助比例添加 -->
	<model:dataset id="SMTLForAdd"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalPer">
			<model:field name="domicileCode" type="string" rule="require|length{12}" />
			<model:field name="type" type="string" rule="require" />
			<model:field name="year" type="string" rule="require|length{4}" />
			<model:field name="assitanceLevel" type="string" rule="require" />
			<model:field name="upperLimit" type="string"
				rule="require|length{14}" />
			<model:field name="lowerLimit" type="string"
				rule="require|length{14}" />
			<model:field name="percentage" type="string"
				rule="require|length{10}" />
		</model:record>
	</model:dataset>
	<!-- 档级 -->
	<model:dataset id="helpLvDS" enumName="SAM_MBALANCE_HELP_LEVEL" global="true" autoLoad="true">
	</model:dataset>
	<!--  救助比例修改 -->
	<model:dataset id="SMTLForUpdate"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalPer">
				<model:field name="domicileName" type="string"/>
			<model:field name="domicileCode" type="string" rule="require|length{12}" />
			<model:field name="type" type="string" rule="require" />
			<model:field name="year" type="string" rule="require|length{4}" />
			<model:field name="assitanceLevel" type="string" rule="require" />
			<model:field name="percentage" type="string"
				rule="require|number|length{10}" />
		</model:record>
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
</model:datasets>
<next:Panel width="99.9%" border="0">
	<next:Html>
		<form class="L5form">
		<fieldset><legend>查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 20%;">救助对象属地：</td>
				<td class="FieldInput" style="width: 15%;"><input type="text" onclick="forCityHelp(this.id)"
					id="qdomicile"/></td>
				<td style="display:none;"><input type="text" id="qdomicileCode" /></td>
				<td class="FieldLabel" style="width: 10%;">年份：</td>
				<td class="FieldInput" style="width: 10%;"><input type="text"  
					id="year" /></td>
				<td class="FieldLabel" style="width: 15%;">档级：</td>
				<td class="FieldInput"><select id="assitanceLevel">
					<option dataset="helpLvDS"></option>
				</select></td>
				<td class="FieldButton" style="width: 10%;">
				<button onclick="forQuery();">查询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">救助对象类别：</td>
				<td class="FieldInput"><select id="type">
					<option dataset="assitanceTypeDataset"></option>
				</select></td>
				<td class="FieldLabel">救助比例：</td>
				<td class="FieldInput"><input type="text" maxlength="16" onblur="checkNum(this.id)"
					id="percentage" /></td>
				<td class="FieldLabel"></td>
				<td class="FieldInput"></td>
				<td class="FieldLabel"></td>
			</tr>
			<tr>		
				<td class="FieldLabel" style="width: 18%;">上限（元）：</td>
				<td class="FieldInput"><input type="text" maxlength="16"
					id="upperLimit" /></td>
				<td class="FieldLabel" style="width: 18%;">下限（元）：</td>
				<td class="FieldInput"><input type="text" maxlength="16" onblur="checkAssMon(this.id)"
					id="lowerLimit" /></td>	
				<td class="FieldLabel"></td>
				<td class="FieldInput"></td>
				<td class="FieldButton">
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>




<next:EditGridPanel id="hlistPanel" dataset="SamMedicalPerDS" stripeRows="true" title="救助比例管理"
	height="100%" width="99.9%">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="批量预设明年救助比例" iconCls="add" handler="setAsLastYear"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="addMedical"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="detail" handler="updateMedical"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="救助对象属地" field="domicileName" width="13%"
			editable="false">
			<next:TextField />
		</next:Column>
		<next:Column header="救助对象类别" field="type" width="13%" editable="false">
			<next:ComboBox dataset="assitanceTypeDataset" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column header="年份" field="year" width="5%" editable="false"  sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column header="档级" field="assitanceLevel" width="10%" dataset="helpLvDS"
			editable="false">
			<next:TextField />
		</next:Column>
		<next:Column header="下限（元）" field="lowerLimit" width="10%" align="right" 
			editable="false">
			<next:TextField />
		</next:Column>
		<next:Column header="上限（元）" field="upperLimit" width="10%" align="right" 
			editable="false">
			<next:TextField />
		</next:Column>
		<next:Column header="救助比例(%)" field="percentage" width="15%"
			editable="false">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="SamMedicalPerDS" />
	</next:BottomBar>
</next:EditGridPanel>


<!-- 救助比例添加 -->
<next:Window id="addWin" closeAction="hide" title="救助比例添加" width="500">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="forAdd"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="SMTLForAdd">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%"><label>救助对象属地：</label></td>
				<td class="FieldInput" colspan="3"><label type="text" id="domicile" 
					 name="救助对象属地" style="width: 100%;" /></td>
				<td style="display:none;"><input type="text" id="domicileCode" field="domicileCode" /></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label>年份：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="4" 
					field="year" name="年份" /></td>
				<td class="FieldLabel" style="width: 10%"><label>救助对象类别：</label></td>
				<td class="FieldInput" style="width: 10%"><select id="type"
					field="type" name="救助对象类别">
					<option dataset="assitanceTypeDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>档级：</label></td>
				<td class="FieldInput"><select field="assitanceLevel" name="档级">
					<option dataset="helpLvDS"></option>
				</select></td>
				<td class="FieldLabel" style="width: 10%"><label>救助比例（%）：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16" onblur="checkNum(this.id)"
					field="percentage" name="救助比例" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%"><label>下限（元）：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16" onblur="checkAssMon(this.id)"
					field="lowerLimit" name="下限" /></td>
				<td class="FieldLabel"><label>上限（元）：</label></td>
				<td class="FieldInput"><input type="text" maxlength="16" field="upperLimit" onblur="checkAssMon(this.id)"
					name="上限" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>


<!-- 救助比例修改 -->
<next:Window id="updateWin" closeAction="hide" title="救助比例修改"
	width="500">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="save" handler="forUpdate"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="closeWin1"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="SMTLForUpdate">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%"><label>救助对象属地：</label></td>
				<td class="FieldInput" colspan="3"><label field="domicileName" id="updatedomicile"
					 name="救助对象属地" style="width: 100%;" /></td>
				<td style="display:none;"><input type="text" id="updatedomicileCode" field="domicileCode" /></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label>年份：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="4"
					field="year" name="年份" /></td>
				<td class="FieldLabel" style="width: 10%"><label>救助对象类别：</label></td>
				<td class="FieldInput" style="width: 10%"><select id="type"
					field="type" name="救助对象类别">
					<option dataset="assitanceTypeDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>档级：</label></td>
				<td class="FieldInput"><select field="assitanceLevel" name="档级">
					<option dataset="helpLvDS"></option>
				</select></td>
				<td class="FieldLabel" style="width: 10%"><label>救助比例（%）：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16" onblur="checkNum(this.id)"
					field="percentage" name="救助比例" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%"><label>下限（元）：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16" onblur="checkAssMon(this.id)"
					field="lowerLimit" name="下限" /></td>
				<td class="FieldLabel"><label>上限（元）：</label></td>
				<td class="FieldInput"><input type="text" maxlength="16" field="upperLimit" onblur="checkAssMon(this.id)"
					name="上限" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>
<!-- 上限选择窗口 -->
<next:Window id="upperLimitWin" closeAction="hide" title="上限选择"
	width="360">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="forAddUpperLimit"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="closeWinLimit"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel height="150" id="tabPanel">
		<next:Tabs>
			<next:Panel title="具体数值" bodyStyle="background-color:honeydew;">
				<next:Html>
			具体数值：<input type="text" id="detial" />
				</next:Html>
			</next:Panel>
			<next:Panel title="按照区间" bodyStyle="background-color:honeydew;">
				<next:Html>
			大于：<input type="text" maxlength="16" id="betweenU" />小于：<input type="text" maxlength="16" id="betweenL" />
				</next:Html>
			</next:Panel>
			<next:Panel title="大于数值" bodyStyle="background-color:honeydew;">
				<next:Html>
			大于数值：<input type="text" maxlength="16" id="forUp" />
				</next:Html>
			</next:Panel>
			<next:Panel title="小于数值" bodyStyle="background-color:honeydew;">
				<next:Html>
			小于数值：<input type="text" maxlength="16" id="forLow" />
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Window>
</body>
</html>