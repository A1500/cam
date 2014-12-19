<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
</script>
<html>
<head>
<title>义务兵家庭信息编辑</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="bptcompulsory_edit.js"></script>
<script type="text/javascript" src="../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryQueryCommand"
		global="true" method="queryUpdateCompulsory">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCompulsory">
			<model:field name="domicileName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 是否进藏、进疆 -->
	<model:dataset id="composedPort" enumName="COMM.YESORNO"
		global="true" autoLoad="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 开户银行 -->
	<model:dataset id="bank" enumName="BANK.CODE" global="true"
		autoLoad="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="save" />
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="ds" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="1" width="99%">

					<!-- 	<tr><td  class="FieldLabel" >ID</td>
				<td class="FieldInput"><input type="text" name="id" field="id"  /><font color="red">*</font> </td></tr>
				<input type="hidden" name="id" field="id"  /> -->
					<tr>
						<td class="FieldLabel" nowrap>姓名：</td>
						<td class="FieldInput"><input type="text" name="name" title="姓名"
							field="name" /><font color="red">*</font></td>

						<td class="FieldLabel" nowrap>性别：</td>
						<td class="FieldInput"><!-- <input type="text" name="sex" field="sex"  />  -->
						<select name="sex" field="sex">
							<option dataset="SexDataset"></option>
						</select></td>

						<td class="FieldLabel" nowrap>身份证号：</td>
						<td class="FieldInput"><input type="text" name="idCard" maxlength="18" title="身份证号"
							field="idCard" onchange="queryIdCard();showBirthday()"
							style="width: 135" /><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>出生日期：</td>
						<td class="FieldInput"><input type="text" format="Y-m-d"
							style="width: 100px;" maxlength="10" id ="birthday" name="birthday"  onpropertychange="changeDateStyle(this)" field="birthday" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
						</td>

						<td class="FieldLabel" nowrap>民族：</td>
						<td class="FieldInput"><select name="nation" field="nation">
							<option dataset="NationDataset"></option>
						</select> <font color="red">*</font></td>

						<td class="FieldLabel" nowrap>优待安置证编号：</td>
						<td class="FieldInput"><input type="text" title="优待安置证编号" maxlength="12"
							name="specialSettingNo" field="specialSettingNo" /><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>入伍时间：</td>
						<td class="FieldInput"><input type="text" format="Y-m-d" title="入伍时间"
							maxlength="10" id="conscriptDate" name="conscriptDate"  onpropertychange="changeDateStyle(this)" field="conscriptDate" style="width: 100px;" /><img  src="../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  >
							<font color="red">*</font>
						</td>
						<td class="FieldLabel" nowrap>进藏 进疆：</td>
						<td class="FieldInput"><select name="composedPortrait" field="composedPortrait" title="进藏 进疆">
							<option dataset="composedPort"></option>
						</select> <font color="red">*</font></td>
						<td class="FieldLabel">户籍类别：</td>
						<td class="FieldInput">
							   <select name="domicileType" field="domicileType" id="domicileType" title="户籍类别">
								 <option dataset="DomicileDataset"></option>
							   </select><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>联系方式：</td>
						<td class="FieldInput"><input type="text" name="telContact"
							field="telContact"/></td>

						<td class="FieldLabel" nowrap>邮编：</td>
						<td class="FieldInput" colspan="3"><input type="text" name="postcode"
							field="postcode" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>家庭所属行政区划：</td>
						<td class="FieldInput"><input type="text" name="domicileName" field="domicileName"
							title="属地行政区划" onclick="forHelp()" readonly="readonly" /><input
							type="hidden" id="domicileCode" field="domicileCode" /><font
							color="red">*</font></td>

						<td class="FieldLabel" nowrap>住址：</td>
						<td class="FieldInput" colspan="3"><input type="text"
							name="address" field="address" style="width: 240" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>父亲姓名：</td>
						<td class="FieldInput"><input type="text" name="fatherName"
							field="fatherName" /></td>

						<td class="FieldLabel" nowrap>父亲单位：</td>
						<td class="FieldInput"><input type="text" name="fatherUnit"
							field="fatherUnit" /></td>

						<td class="FieldLabel" nowrap>父亲联系方式：</td>
						<td class="FieldInput"><input type="text"
							name="fatherContact" field="fatherContact" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>母亲姓名：</td>
						<td class="FieldInput"><input type="text" name="motherName"
							field="motherName" /></td>

						<td class="FieldLabel" nowrap>母亲单位：</td>
						<td class="FieldInput"><input type="text" name="motherUnit"
							field="motherUnit" /></td>

						<td class="FieldLabel" nowrap>母亲联系方式：</td>
						<td class="FieldInput"><input type="text"
							name="motherContact" field="motherContact" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>开户银行：</td>
						<td class="FieldInput"><select name="bank" field="bank">
							<option dataset="bank"></option>
						</select></td>

						<td class="FieldLabel" nowrap>开户账号：</td>
						<td class="FieldInput"><input type="text" name="accountCode"
							field="accountCode" /></td>
						<td class="FieldInput" colspan="2">&nbsp;</td>

						<input type="hidden" name="regId" field="regId" />
						<!-- 录入人ID -->
						<input type="hidden" name="regTime" field="regTime" />
						<!-- 录入时间 -->
						<input type="hidden" name="modId" field="modId" />
						<!-- 修改人ID -->
						<input type="hidden" name="modTime" field="modTime" />
						<!-- 修改时间 -->
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>备注：</td>
						<td class="FieldInput" colspan="5"><textarea rows="3"
							cols="120" name="note" field="note"></textarea></td>
					</tr>

				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
