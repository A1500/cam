<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>人员基本信息表编辑</title>
<next:ScriptManager/>
<script>
	var idField='<%=request.getParameter("dataBean")%>';
	var method='<%=request.getParameter("method")%>';
	var personId='<%=request.getParameter("personId")%>';
	var deptId='<%=request.getParameter("deptId")%>';
	
</script>
<script type="text/javascript" src="mrmBasePersonTreeEdit.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="mrmBasePersonDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmBasePersonQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmBasePerson"></model:record>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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

<next:Panel title="人员基本信息表" width="100%" height="98%" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="mrmBasePersonDataSet" onsubmit="return false" style="padding:5px;" class="L5form">
		<fieldset>
		<legend>人员基本信息</legend>
		<table border="1" width="100%">
			
	   		<tr>
	   		<td class="FieldLabel" nowrap="nowrap">登录帐号：</td>
				<td class="FieldInput"><input type="text" name="loginid" field="loginid"/><font color="red">*</font></td>

				<td class="FieldLabel">登录密码：</td>
				<td class="FieldInput"><input type="password" name="pwd" id="pwd" field="pwd" style="width:90%"/><font color="red">*</font></td>
				<td class="FieldLabel">确认密码：</td>
				<td class="FieldInput"><input type="password" name="repwd" id="repwd" style="width:90%"/><font color="red">*</font></td>

			</tr>
	   		
	   		<tr>
	   		<td class="FieldLabel" nowrap="nowrap">角色：</td>
				<td class="FieldInput">
					<select name="roleId" id="roleId" field="roleId">
						<option value=''></option>
						<option value='898bbe340187500134019780550006'>婚姻登记员</option>
						<option value='898bbe340187500134019681360004'>婚姻登记处主任</option>
						
					</select><font color="red">*</font>
				</td>
				<td class="FieldLabel" nowrap="nowrap">姓名：</td>
				<td class="FieldInput"><label type="text" name="name" field="name"  /></td>
				<td  class="FieldLabel" nowrap="nowrap">民族：</td>
				<td class="FieldInput">
				<label name="nation" id="nation" field="nation" dataset="NationDataset" />
				</td>
			</tr>
	   		<tr>
				
				<td class="FieldLabel" nowrap="nowrap">性别：</td>
				<td class="FieldInput">
					<label name="sex" id="sex" field="sex" dataset="SexDataset" />
				</td>
				<td  class="FieldLabel" nowrap="nowrap">出生日期：</td>
				<td class="FieldInput"><label type="text" name="birthDate" field="birthDate"  onclick="LoushangDate(this)"  format="Y-m-d"  /> </td>
			<td  class="FieldLabel" nowrap="nowrap">身份证件号：</td>
				<td class="FieldInput"><label type="text" name="cardNo" field="cardNo"/></td>
			</tr>
		
			
	   		<tr>
				<td  class="FieldLabel" >籍贯：</td>
				<td class="FieldInput"><label type="text" name="nativePlace" field="nativePlace"  /></td>
			
				<!--<td  class="FieldLabel" >入党入团时间：</td>
				<td class="FieldInput"><input type="text" name="partyTime" field="partyTime"  /> </td>
			
				-->
				<td  class="FieldLabel" >学位：</td>
				<td class="FieldInput"><label type="text" name="degree" field="degree"  /> </td>
				<td  class="FieldLabel" >工作证号：</td>
				<td class="FieldInput"><label type="text" name="workNo" field="workNo"  /> </td>
			</tr>
	   		<!--<tr>
				<td  class="FieldLabel" >专业：</td>
				<td class="FieldInput"><input type="text" name="specialty" field="specialty"  /> </td>
			
				<td  class="FieldLabel" >毕业院校：</td>
				<td class="FieldInput"><input type="text" name="college" field="college"  /> </td>
			
				<td  class="FieldLabel" >毕业时间：</td>
				<td class="FieldInput"><input type="text" name="graduateDate" field="graduateDate"  onclick="LoushangDate(this)"  format="Y-m-d"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >婚姻状况：</td>
				<td class="FieldInput"><input type="text" name="marry" field="marry"  /> </td>
			
				<td  class="FieldLabel" >职称：</td>
				<td class="FieldInput"><input type="text" name="technical" field="technical"  /> </td>
			
				<td  class="FieldLabel" >职务：</td>
				<td class="FieldInput"><input type="text" name="duty" field="duty"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >工作证号：</td>
				<td class="FieldInput"><input type="text" name="workNo" field="workNo"  /> </td>
			
				<td  class="FieldLabel" >手机：</td>
				<td class="FieldInput"><input type="text" name="mobile" field="mobile"  /> </td>
			
				<td  class="FieldLabel" >办公电话：</td>
				<td class="FieldInput"><input type="text" name="officeTel" field="officeTel"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >学历：</td>
				<td class="FieldInput"><input type="text" name="culture" field="culture"  /> </td>
			
				<td  class="FieldLabel" >政治面貌：</td>
				<td class="FieldInput"><input type="text" name="politics" field="politics"  /> </td>
			
				<td  class="FieldLabel" >参加工作时间：</td>
				<td class="FieldInput"><input type="text" name="workDate" field="workDate"  onclick="LoushangDate(this)"  format="Y-m-d"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >所属部门：</td>
				<td class="FieldInput"><input type="text" name="deptId" field="deptId"  /> </td>
			
				<td  class="FieldLabel" >婚姻登记部门：</td>
				<td class="FieldInput"><input type="text" name="deptIdMarry" field="deptIdMarry"  /> </td>
			
				<td  class="FieldLabel" >婚姻登记部门编号：</td>
				<td class="FieldInput"><input type="text" name="deptIdMarryNum" field="deptIdMarryNum"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >家庭地址：</td>
				<td class="FieldInput"><input type="text" name="address" field="address"  /> </td>
			
				<td  class="FieldLabel" >岗位：</td>
				<td class="FieldInput"><input type="text" name="postId" field="postId"  /> </td>
			
				<td  class="FieldLabel" >考评等级：</td>
				<td class="FieldInput"><input type="text" name="testLevelId" field="testLevelId"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >系统皮肤颜色：</td>
				<td class="FieldInput"><input type="text" name="skinType" field="skinType"  /> </td>
			
				<td  class="FieldLabel" >所属行政区：</td>
				<td class="FieldInput"><input type="text" name="regionCode" field="regionCode"  /> </td>
			
				<td  class="FieldLabel" >人员性质：</td>
				<td class="FieldInput"><input type="text" name="kind" field="kind"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >从事婚姻工作开始时间：</td>
				<td class="FieldInput"><input type="text" name="marryStartDate" field="marryStartDate"  onclick="LoushangDate(this)"  format="Y-m-d"  /> </td>
			
				<td  class="FieldLabel" >从事婚姻工作结束时间：</td>
				<td class="FieldInput"><input type="text" name="marryEndDate" field="marryEndDate"  onclick="LoushangDate(this)"  format="Y-m-d"  /> </td>

				<td  class="FieldLabel" >结婚印制号的缺省值：</td>
				<td class="FieldInput"><input type="text" name="printNumJh" field="printNumJh"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >文化程度默认值（男）：</td>
				<td class="FieldInput"><input type="text" name="degreeMan" field="degreeMan"  /> </td>
			
				<td  class="FieldLabel" >文化程度默认值（女）：</td>
				<td class="FieldInput"><input type="text" name="degreeWoman" field="degreeWoman"  /> </td>
			
				<td  class="FieldLabel" >民族（男）：</td>
				<td class="FieldInput"><input type="text" name="folkMan" field="folkMan"  dataset="NationDataset" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >民族（女）：</td>
				<td class="FieldInput"><input type="text" name="folkWoman" field="folkWoman"  dataset="NationDataset" /> </td>
			
				<td  class="FieldLabel" >职业（男）：</td>
				<td class="FieldInput"><input type="text" name="jobMan" field="jobMan"  /> </td>
			
				<td  class="FieldLabel" >职业（女）：</td>
				<td class="FieldInput"><input type="text" name="jobWoman" field="jobWoman"  /> </td>
			</tr>
	   		<tr>
			 	<td  class="FieldLabel" >SYSTEM_ROLE</td>
				<td class="FieldInput"><input type="text" name="systemRole" field="systemRole" /> </td>
			 
				<td  class="FieldLabel" >有效标志：</td>
				<td class="FieldInput"><input type="text" name="validFlag" field="validFlag"  /> </td>
			
				<td  class="FieldLabel" >离岗原因：</td>
				<td class="FieldInput"><input type="text" name="departureReason" field="departureReason"  /> </td>
			
			 	<td  class="FieldLabel" >REGISTSTATUS</td>
				<td class="FieldInput"><input type="text" name="registstatus" field="registstatus"  /> </td>
			
				<td  class="FieldLabel" >PRIORITY</td>
				<td class="FieldInput"><input type="text" name="priority" field="priority"  /> </td>
			 
				<td  class="FieldLabel" >离婚印制号的缺省值：</td>
				<td class="FieldInput"><input type="text" name="printNumLh" field="printNumLh"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >是否编制：</td>
				<td class="FieldInput"><input type="text" name="organization" field="organization"  /> </td>
			
				<td  class="FieldLabel" >资格证编号：</td>
				<td class="FieldInput"><input type="text" name="certificateId" field="certificateId"  /> </td>
			
				<td  class="FieldLabel" >计算机管理类型：</td>
				<td class="FieldInput"><input type="text" name="computerType" field="computerType"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >离岗时间：</td>
				<td class="FieldInput"><input type="text" name="departureTeme" field="departureTeme"  /> </td>
			
				<td  class="FieldLabel" >备注：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="remark" field="remark" style="width:90%" /> </td>
			</tr>

		--></table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>