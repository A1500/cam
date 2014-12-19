
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>等级评定信息表编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="mrmlevelevalutioninfo_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmLevelEvalutionInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmLevelEvalutionInfo"></model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="EvaluLevelDataset" enumName="MRM.EVALULEVEL.TYPE" autoLoad="true" global="true" pageSize="-1"></model:dataset>
<!-- 是否首次评定 -->
	<model:dataset id="FirstEvaluDataset" enumName="MRM.IF.FIRSTEVALU" autoLoad="true" global="true" pageSize="-1"></model:dataset>

</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="等级评定信息表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
			<td  class="FieldLabel" >登记机关</td>
				<td class="FieldInput">
				<input type="hidden" name="deptId" field="deptId"  /> 
				<input type="text" name="deptName" field="deptName"  onclick="func_djjg()" style="width: 200px"/> <font color="red">*</font>
				</td>
					<td  class="FieldLabel" >等级</td>
				<td class="FieldInput">
				<select name="evaluLevel" id="evaluLevel" field="evaluLevel" >
					 <option dataset="EvaluLevelDataset"/>
				</select> <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >评定时间</td>
				<td class="FieldInput"><input type="text" name="evaluTime" field="evaluTime"     format="Y-m-d" style="width: 100px"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> </td>
			<td  class="FieldLabel" >复核时间</td>
				<td class="FieldInput"><input type="text" name="reviewTime" field="reviewTime"     format="Y-m-d" style="width: 100px"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /></td>
			
			</tr>
	   		<tr>
				
				<td  class="FieldLabel" >整改合格时间</td>
				<td class="FieldInput"><input type="text" name="rectificPassTime" field="rectificPassTime"     format="Y-m-d" style="width: 100px" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /></td>
			<td  class="FieldLabel" >不合格撤销等级时间</td>
				<td class="FieldInput"><input type="text" name="revokeTime" field="revokeTime"     format="Y-m-d" style="width: 100px"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />  </td>
			
			</tr>
	   		<tr>
				
				<td  class="FieldLabel" >主动申请取消等级时间</td>
				<td class="FieldInput"><input type="text" name="主动申请取消等级时间" field="cancelLevelTime"     format="Y-m-d" style="width: 100px"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> <font color="red">*</font> </td>
			<td  class="FieldLabel" >是否首次评定</td>
				<td class="FieldInput">
				<select name="firstEvalu" id="firstEvalu" field=firstEvalu>
					<option dataset="FirstEvaluDataset"/>
				</select>
				 </td>
			
			</tr>
	   		<tr>
				
				<td  class="FieldLabel" >不合格降级时间</td>
				<td class="FieldInput"><input type="text" name="nhgjjTime" field="nhgjjTime"     format="Y-m-d" style="width: 100px"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> </td>
			<td  class="FieldLabel" >不合格降级原等级</td>
				<td class="FieldInput">
				<select name="nhgjjBlevel" id="nhgjjBlevel" field=nhgjjBlevel>
				    <option value="03">国家5A级</option>
					<option value="02">国家4A级</option>
				</select>
				</td>
			</tr>
	   		<tr>
				
			
				<td  class="FieldLabel" >不合格降级现等级</td>
				<td class="FieldInput">
				<select name="nhgjjNlevel" id="nhgjjNlevel" field=nhgjjNlevel>
					<option value="02">国家4A级</option>
					<option value="01">国家3A级</option>
				</select>
				</td>
				<td  class="FieldLabel" >主动申请降级时间</td>
				<td class="FieldInput"><input type="text" name="zdsqjjTime" field="zdsqjjTime"    format="Y-m-d"  style="width: 100px"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> </td>
			
			</tr>
	   		<tr>
				
				<td  class="FieldLabel" >主动申请降级原等级</td>
				<td class="FieldInput">
				<select name="zdsqjjBlevel" id="zdsqjjBlevel" field=zdsqjjBlevel>
					<option value="03">国家5A级</option>
					<option value="02">国家4A级</option>
				</select>
				
				</td>
				<td  class="FieldLabel" >主动申请降级现等级</td>
				<td class="FieldInput">
				<select name="zdsqjjNlevel" id="zdsqjjNlevel" field=zdsqjjNlevel>
					<option value="02">国家4A级</option>
					<option value="01">国家3A级</option>
				</select>
				</td>
			
			</tr>
	   			
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
