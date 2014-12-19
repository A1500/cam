
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>社会组织外网用户编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			idField=decodeURIComponent(idField);
			var method='<%=request.getParameter("method")%>';
			var areaCode = '<%=BspUtil.getOrganCode()%>';
		</script>
		<script type="text/javascript" src="onlinecomextuser_edit.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser">
			<model:field name="userId" type="string" rule="require|length{500}" />
			<model:field name="pwd" type="string" rule="require|length{30}" />
			<model:field name="userName" type="string" rule="require|length{500}" />
			<model:field name="organType" type="string" rule="require" />
			<model:field name="sorgCode" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="somExtuserMenuds" cmd="com.inspur.cams.sorg.online.extusermenu.cmd.SomExtuserMenuQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.online.extusermenu.data.SomExtuserMenu">
		</model:record>
	</model:dataset>
	<%--社团基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="som_lastYearCheckResult" enumName="SOM.LAST_YEAR_CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  title="社会组织外网用户信息" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<fieldset>
		<legend>用户基本信息</legend>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >

	   		<tr>
				<td  class="FieldLabel"  style="width:17%">用户名</td>
				<td class="FieldInput"><input type="text" name="userId" id="userId" field="userId" style="width:68%" onchange="this.value=this.value.toUpperCase();checkUserId();fillSorgCode(this.value)" title="用户名"/><font color="red">*</font><font id="userCheck" style="display:none" color="red">该用户名已经存在</font> </td>
				<td  class="FieldLabel" >社会组织名称</td>
				<td class="FieldInput"><input type="text" name="userName"  id="userName" field="userName" title="社会组织名称" style="width:70%" /><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >密码</td>
				<td class="FieldInput"><input type="password" name="pwd" field="pwd"  title="密码"/><font color="red">*</font> </td>
	   			<td  class="FieldLabel" >登记证号</td>
				<td class="FieldInput"><input type="text" name="sorgCode" id="sorgCode" onchange="fillSorgName(this.value)" title="登记证号"/></td>
			</tr>
			<tr>
	   			<td  class="FieldLabel" >社会组织类型</td>
				<td class="FieldInput">
					<select id="organType" field="organType" id="organType" blank="false" onchange="organTypeOnChange(this.value)">
						<option value ="ST">社会团体</option>
						<option value ="MF">民办非企业</option>
						<option value ="JJ">基金会</option>
					</select><font color="red">*</font>
				</td>
				<td  class="FieldLabel" ></td>
				<td class="FieldInput">
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >是否启用</td>
				<td class="FieldInput">
				<select field="accountStatus" id="accountStatus" name='"是否启用"'>
					<option dataset="comm_yesorno"></option>
				</select>
				</td>
				<td  class="FieldLabel" >住址</td>
				<td class="FieldInput"><input type="text" name="adds" field="adds"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >联系电话</td>
				<td class="FieldInput"><input type="text" name="phone" field="phone"  /> </td>

				<td  class="FieldLabel" >电子邮件</td>
				<td class="FieldInput"><input type="text" name="email" field="email"  /> </td>
			</tr>
		</table>
		</form>
		</fieldset>
		<fieldset>
		<legend>请选择办理业务种类（说明:用户登陆后会显示选择的业务种类相对应的菜单;下边的业务种类根据上方选择的社会组织类型进行变化;）</legend>
		<form id="editForm"   dataset="somExtuserMenuds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table style="margin:auto;text-align:center;width:100%">
			<tr>
				<td>
				<input type="hidden" systype="itemselector" id="menuInfo" field="menuInfo">
				<div id="menuInfoDiv" style="margin:0 auto"></div>
				</td>
			</tr>
		</table>
		</form>
		</fieldset>
   </next:Html>
</next:Panel>
</body>
</html>
