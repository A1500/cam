
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<html>
	<head>
		<title><%=res.get("ID.IDEDITTITLE") %></title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var idorganId='<%=request.getParameter("organId")%>';
		</script>
		<script type="text/javascript" src="pubidtable_edit.js"></script>
		<script language="javascript">
			/*Javascript文件中的消息：用于国际化处理*/
			var alerttitle='<%=res.get("ID.ALERTTITLE")%>';//提示
			var methodnull='<%=res.get("ID.METHODNULL")%>';//方法名为空!
			var unknownorder='<%=res.get("ID.UNKNOWNORDER")%>';//未知的页面命令!
			var failedverify='<%=res.get("ID.FAILEDVERIFY")%>';//校验未通过,不能保存!
			var savesuccessful='<%=res.get("ID.SAVESUCCESSFUL")%>';//保存成功!
			var title='<%=res.get("ID.IDMANAGER")%>';//业务流水管理
			var setprefix='<%=res.get("ID.SETPREFIX")%>';//选择了使用前缀，请设置前缀!
			var delprefix='<%=res.get("ID.DELPREFIX")%>';//设置了前缀，但没有选择使用前缀，如不使用前缀，请删除前缀信息!
			var setsuffix='<%=res.get("ID.SETSUFFIX")%>';//选择了使用后缀，请设置后缀!
			var delsuffix='<%=res.get("ID.DELSUFFIX")%>';//设置了后缀，但没有选择使用后缀，如不使用后缀，请删除后缀信息!
			var setorganid='<%=res.get("ID.SETORGANID")%>';//不使用全局流水，请选择组织内码!
			var delorganid='<%=res.get("ID.DELORGANID")%>';//设置了组织内码，但选择了全局流水，如使用全局流水，请删除组织内码信息!
			var prefixincludeyyyy='<%=res.get("ID.PREFIXINCLUDEYYYY")%>';//选择了按年流水，请设置前缀，并且前缀必须包含YYYY !
			var prefixincludeyyyymm='<%=res.get("ID.PREFIXINCLUDEYYYYMM")%>';//选择了按月流水，请设置前缀，并且前缀必须包含YYYYMM !
			var prefixincludeyyyymmdd='<%=res.get("ID.PREFIXINCLUDEYYYYMMDD")%>';//选择了按日流水，请设置前缀，并且前缀必须包含YYYYMMDD !
			var prelength='<%=res.get("ID.PRELENGTH")%>';//前缀长度不能超过60位
			var suflength='<%=res.get("ID.SUFLENGTH")%>';//后缀长度不能超过60位
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="useStatus" enumName="BSP.IN_USE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="idTypes" enumName="ID.TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="ds" cmd="org.loushang.bsp.id.cmd.PubIdtableQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.id.data.PubIdtable"></model:record>
	</model:dataset>
	
</model:datasets>

<next:Panel  >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text='<%=res.get("ID.SAVE") %>' handler="save"/>
		<next:ToolBarItem iconCls="undo"  text='<%=res.get("ID.BACK") %>' handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" class="L5form">
		<table border="1" id="idTable" width="100%" >

	   		<tr>
				<td  class="FieldLabel" ><%=res.get("ID.ID") %></td> 
				<td class="FieldInput"><input id="idInput" type="text" name=<%=res.get("ID.ID") %> field="idId" maxlength="30"
				 onchange="checkSpecialChar(this)"/><font color="red">*</font> </td>

				<td  class="FieldLabel" ><%=res.get("ID.NAME") %></td>
				<td  class="FieldInput"><input type="text" name=<%=res.get("ID.NAME") %> id="idName"  field="idName" maxlength="50" /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("ID.LENGTH") %></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("ID.LENGTH") %> id="idLength" field="idLength" maxlength="10" /><font color="red">*</font> </td>

				<td  class="FieldLabel" ><%=res.get("ID.VALUE") %></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("ID.VALUE") %> id="idValue"  field="idValue" maxlength="10" /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("ID.ISPREFIX") %></td>
				<td class="FieldInput">
					<input type="checkbox"  onclick="setisPrefix(this)" id="isPrefix" name="isPrefix"  />
					<input id="idPrefix" type="text" name="idPrefix"  style="width:60%" field="idPrefix" style="display: none" maxlength="60"/>
				</td>
				<td  class="FieldLabel" ><%=res.get("ID.ISSUFFIX") %></td>
				<td class="FieldInput">
					<input type="checkbox"  onclick="setisSuffix(this)" id="isSuffix" name="isSuffix" />
					<input id="idSuffix" type="text" name="idSuffix" style="width:60%"  field="idSuffix" style="display: none" maxlength="60" />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("ID.ISGLOBAL") %></td>
				<td class="FieldInput">
					<input type="checkbox"   onclick="setisGlobal(this)" id="isGlobal" name="isGlobal"  />
					<input id="organId" type="text" name="organId" field="organId" style="display: none"   />
					<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand;display: none" onclick="selectOrganId()" id="imgSrc"/>
				</td>
				<td  class="FieldLabel" ><%=res.get("ID.IDTYPE") %></td>
				<td class="FieldInput">
					<select id="idType" name="idType" field="idType" ><option dataset="idTypes"></option></select>
				</td>
			</tr>
			<tr>
				<td  class="FieldInput" colspan="4"><font color="red">
					说明：
					<br>
					1)假设当前时间为2010年1月2日3时11分23秒，如果前缀或后缀包含下列字符串<br>
					YYYY：生成的业务流水号将该字符串替换为2010<br>
					YY：生成的业务流水号将该字符串替换为10<br>
					MM：生成的业务流水号将该字符串替换为01<br>
					DD：生成的业务流水号将该字符串替换为02<br>
					HH：生成的业务流水号将该字符串替换为03<br>
					MI：生成的业务流水号将该字符串替换为11<br>
					SS：生成的业务流水号将该字符串替换为23<br>
					2）流水类型：按年流水表示按年份进行流水，比如当前年份为2009年，当变为2010年时，流水号从1开始重新计数；
					按年流水需结合前缀进行使用，当选择了按年流水时，前缀必须包含“YYYY”，按月流水和按日流水原理相同，按月流水前缀必须包含“YYYYMM”,按日流水前缀必须包含“YYYYMMDD”
					<br>
					3)以上日期时间字符，YYYYMMDDHHMISS，不区分大小写
				</font>
			</td>
			</tr>

		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
