<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>添加临时救助申请</title>
<next:ScriptManager />
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var id='<%=request.getParameter("id")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
<script type="text/javascript" src="temporaryHelpAdd.js"></script>
<script type="text/javascript" src = "../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpQueryCommand" autoLoad="false" method="queryTemporary" global="true" >
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptTemporaryHelp">
			</model:record>
	</model:dataset>
	<!--救助类别-->
	<model:dataset id="dsHelp" enumName="HELP.TYPE" autoLoad="true"></model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel    width="100%" border="0"   autoScroll="true" autoHeight="true" >
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
	    <legend class="GroupBoxTitle">请选择</legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
						<tr>		
								<td class="FieldLabel" width="20%" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<select id="serviceType" style="width:180px;" >
								   		<option value="16" selected="selected">添加伤残人员</option>
								   		<option value="23">添加三属人员</option>
								   		<option value="43">添加在乡复员人员</option>
								   		<option value="47">添加带病回乡人员</option>
								   		<option value="53">添加参战人员</option>
								   		<option value="63">添加参试人员</option>
								   		<option value="83">添加60岁退役士兵人员</option>
								   		<option value="B3">添加部分烈士子女人员</option>
		   							</select>
						 			</td>
						</tr>		
						</table>
					</form>
				</div>
				</fieldset>
	 </next:Html>
</next:Panel> 
<next:Panel autoHeight="true" autoWidth="true" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="fun_close" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<input type="hidden" name="peopleId" field="peopleId" />
				<td class="FieldLabel" colspan="2" nowrap>姓名:</td>
				<td class="FieldInput"><input type="text" name="name"
					field="name" disabled="disabled" />
					<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getIdCard()"/></td>
				<td class="FieldLabel" nowrap>性别:</td>
				<td class="FieldInput"><label id="sex" name="sex" field="sex" dataSet="SexDataset"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>年龄:</td>
				<td class="FieldInput"><label name="age" field="age" id="age"/></td>
				<td class="FieldLabel" nowrap>民族:</td>
				<td class="FieldInput"><label id="nation" name="nation"
					field="nation" dataSet="NationDataset">
				</label> </td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>优抚对象类别:</td>
				<td class="FieldInput"><label id="objectType" name="objectType" field="objectType" dataSet="objectDs"></label></td>
				<td class="FieldLabel" nowrap>家庭人口:</td> 
				<td class="FieldInput"><label id="familyNum" name="familyNum" field="familyNum" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>身份证号码:</td>
				<td class="FieldInput"><label id="idCard" name="idCord" field="idCord"/></td>
                
				<td class="FieldLabel"  nowrap>家庭住址:</td>
				<td class="FieldInput"><label id = "address" name="address" field="address" rows="2" cols="40" ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>救助类别:</td>
				<td class="FieldInput"><select id="helpType" name="helpType" field="helpType">
					<option dataSet="dsHelp"/>
				</select><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>申请救助金额:</td>
				<td class="FieldInput"><input type="text" name="applyMon" field="applyMon"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>申请事由:</td>
				<td colspan="3"><textarea rows="2" cols="136" name="applySubject" field="applySubject"></textarea><font color="red">*</font>
					</td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2">备注</td>
				<td class="FieldInput" colspan="3"><textarea rows="2"
					cols="136" name="note" field="note"></textarea></td>
			</tr>
            <input type="hidden" name="domicileCode" field="domicileCode" />
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>
