
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>登记员资格考试信息表编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="mrmqualificationexam_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmQualificationExamQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmQualificationExam"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="登记员资格考试信息表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >登记机关ID</td>
				<td class="FieldInput"><input type="text" name="organId" field="organId"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >考试信息ID</td>
				<td class="FieldInput"><input type="text" name="ksxxId" field="ksxxId"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >考试安排ID</td>
				<td class="FieldInput"><input type="text" name="ksapId" field="ksapId"  /> </td>
			
				<td  class="FieldLabel" >人员ID</td>
				<td class="FieldInput"><input type="text" name="personId" field="personId"  /> </td>
			</tr> 
	   		<tr>
				<td  class="FieldLabel" >年度</td>
				<td class="FieldInput"><input type="text" name="ndYear" field="ndYear"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >考试期数</td>
				<td class="FieldInput"><input type="text" name="ksqs" field="ksqs"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >考试时间</td>
				<td class="FieldInput"><input type="text" name="kssjTime" field="kssjTime" onclick="LoushangDate(this)" format="Y-m-d" /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >考试结果</td>
				<td class="FieldInput"><input type="text" name="ksjg" field="ksjg"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >补考结果</td>
				<td class="FieldInput"><input type="text" name="bkjg" field="bkjg"  /> </td>
			
				<td  class="FieldLabel" >初考复考标志</td>
				<td class="FieldInput"><input type="text" name="ckfkbz" field="ckfkbz"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >资格证编号</td>
				<td class="FieldInput"><input type="text" name="certificateId" field="certificateId"  /> </td>
			
				<td  class="FieldLabel" >是否补证</td>
				<td class="FieldInput"><input type="text" name="fillCardTime" field="fillCardTime"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >发证时间</td>
				<td class="FieldInput"><input type="text" name="giveOutTime" field="giveOutTime" onclick="LoushangDate(this)" format="Y-m-d"/> </td>
			
				<td  class="FieldLabel" >超期未参加考试自动失效时间</td>
				<td class="FieldInput"><input type="text" name="automaticFailureTime" field="automaticFailureTime" onclick="LoushangDate(this)" format="Y-m-d" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上级撤销资格证时间</td>
				<td class="FieldInput"><input type="text" name="backoutTime" field="backoutTime" onclick="LoushangDate(this)" format="Y-m-d" /> </td>
			
				</tr>				
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
