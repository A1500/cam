<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
<!-- 一站结算_救助封顶线主页面-->
<head>
<script type="text/javascript">
   var struId='<%=BspUtil.getStruId()%>';
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organName='<%=BspUtil.getDeptOrgan().getOrganName()%>';
   var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samMedicalTopLine.js"></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!--  救助封顶线列表 -->
	<model:dataset id="SamMedicalTopLineDS" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalTopLineQueryCmd" pageSize="15" >
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalTopLine">
		
				<model:field name="domicileName" type="string"/>
		</model:record>
	</model:dataset>
	<!--  救助封顶线增加修改校验 -->
	<model:dataset id="querySamMedicalTopLineDS" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalTopLineQueryCmd" pageSize="15" >
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalTopLine">
		
				<model:field name="domicileName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 救助封顶线添加 -->
	<model:dataset id="SMTLForAdd" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalTopLineQueryCmd" >
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalTopLine">
			<model:field name="domicileCode" type="string" rule="require|length{12}" />
			<model:field name="type" type="string" rule="require" />
			<model:field name="year" type="string" rule="require|length{4}" />
			<model:field name="topLine" type="string" rule="require|length{14}" />
		</model:record>
	</model:dataset>
	<!--  救助封顶线修改 -->
	<model:dataset id="SMTLForUpdate"  cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalTopLineQueryCmd" >
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalTopLine">
				<model:field name="domicileName" type="string"/>
			<model:field name="domicileCode" type="string" rule="require|length{12}" />
			<model:field name="type" type="string" rule="require" />
			<model:field name="year" type="string" rule="require|length{4}" />
			<model:field name="topLine" type="string" rule="require|length{14}" />
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
				<td class="FieldLabel" style="width: 20%;"><label>救助对象属地：</label></td>
				<td class="FieldInput" style="width:20%;"><input type="text" onclick="forCityHelp(this.id)"
					id="qdomicile" style="width: 100%;" /></td>
				<td style="display:none;"><input type="text" id="qdomicileCode" /></td>
				<td class="FieldLabel" style="width:10%;"><label>年份：</label></td>
				<td class="FieldInput" style="width:10%;"><input type="text" id="year" maxlength="4"  /></td>
				<td class="FieldLabel" style="width:20%;"><label>救助对象类别：</label></td>
				<td class="FieldInput" style="width:10%;"><select id="type" name="救助对象类别"><option dataset="assitanceTypeDataset"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel" ><label>封顶线区间（元）：</label></td>
				<td class="FieldInput" colspan="3"><input type="text" maxlength="16" id="topLineUP" onblur="checkAssMon(this.id)" />-----<input type="text" id="topLineLOW" onblur="checkAssMon(this.id)"/></td>
				<td class="FieldButton" style="width:10%;">
				<button onclick="forQuery();">查询</button>
				<td class="FieldButton">
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>




<next:EditGridPanel id="hlistPanel" dataset="SamMedicalTopLineDS" height="100%"  width="99.9%" title="救助封顶线管理">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="addMedical"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="detail" handler="updateMedical" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="救助对象属地" field="domicileName" 
			 width="15%" editable="false" >
			<next:TextField />
		</next:Column>
		<next:Column header="救助对象类别"  field="type" 
			 width="16%" editable="false" dataset="assitanceTypeDataset">
			<next:ComboBox dataset="assitanceTypeDataset" displayField="text"
								valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column header="年份" field="year" 
			 width="7%" editable="false">
			<next:TextField/>
		</next:Column>
		<next:Column header="救助封顶线（元）" field="topLine"  align="right" 
			 width="17%"  editable="false" >
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="SamMedicalTopLineDS" />
	</next:BottomBar>
</next:EditGridPanel>


<!-- 救助封顶线添加 -->
<next:Window id="addWin" closeAction="hide" title="救助封顶线添加" width="500">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="forAdd"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="SMTLForAdd">
			<table width="100%">
				<tr>
					
				<td class="FieldLabel" ><label>救助对象属地：</label></td>
				<td class="FieldInput" ><label id="domicile" 
					 name="救助对象属地"/></td>
				<td style="display: none;"><input type="text" id="domicileCode" field="apanage" /></td>
					<td class="FieldLabel"><label>救助对象类别：</label></td>
					<td class="FieldInput"><select id="type" field="type" name="救助对象类别"><option dataset="assitanceTypeDataset"></option></select></td>
				</tr>
				
				<tr>
					<td class="FieldLabel"><label>年份：</label></td>
					<td class="FieldInput"><input type="text" field="year" name="年份" maxlength="4" /></td>
					<td class="FieldLabel"><label>封顶线（元）：</label></td>
					<td class="FieldInput"><input type="text" maxlength="16" field="topLine" name="救助封顶线" onblur="checkAssMon(this.id)"/></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>


<!-- 救助封顶线修改 -->
<next:Window id="updateWin" closeAction="hide" title="救助封顶线修改" width="500">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="save" handler="forUpdate"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="closeWin1"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="SMTLForUpdate">
			<table width="100%">
				<tr>
					<td class="FieldLabel"><label>救助对象属地：</label></td>
				<td class="FieldInput" ><label field="domicileName" id="updatedomicile" 
					 name="救助对象属地" /></td>
				<td style="display:none;"><input type="text" id="updatedomicileCode" field="domicileCode" /></td>
					<td class="FieldLabel" ><label>救助对象类别：</label></td>
					<td class="FieldInput"><select id="type" field="type" name="救助对象类别"><option dataset="assitanceTypeDataset"></option></select></td>
				</tr>
				
				<tr>
					<td class="FieldLabel"><label>年份：</label></td>
					<td class="FieldInput"><input type="text" field="year" name="年份" maxlength="4" /></td>
					<td class="FieldLabel"><label>封顶线（元）：</label></td>
					<td class="FieldInput"><input type="text" maxlength="16" field="topLine" name="救助封顶线" onblur="checkAssMon(this.id)"/></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>