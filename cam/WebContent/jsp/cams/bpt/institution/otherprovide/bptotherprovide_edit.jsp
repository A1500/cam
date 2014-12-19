
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>其他供养情况编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var organName = '<%=BspUtil.getOrganName()%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="bptotherprovide_edit.js"></script>
		<script type="text/javascript" src="../../comm/bptComm.js"></script>
		
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptOtherprovideQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.bptinstitution.data.BptOtherprovide">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="其他供养情况">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td class="FieldLabel" width="20%">年度</td>
				<td class="FieldInput" width="30%"><input type="text" name="years" style="width:80%" maxlength="4" field="years" format="Y" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" width="20%">单位名称</td>
				<td class="FieldInput" width="30%"><input type="text" name="area" style="width:80%" field="area" /><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getArea()"/><font color="red">*</font> </td>
			</tr>
			<tr>
				<td class="FieldLabel" >所属行政区划</td>
				<td class="FieldInput" >
				<input type="text" name="domicilename" style="width:80%" field="domicilename"  onclick="func_ForDomicileSelect1()" readonly="readonly"/><font color="red">*</font> 
				<input type="hidden" name="domicilecode" field="domicilecode"  />
				</td>
				<td class="FieldLabel" >光荣间（间）</td>
				<td class="FieldInput" ><input type="text" name="gloryroom" style="width:80%" field="gloryroom"  /> </td>
			</tr>	
	   		<tr>
				<td class="FieldLabel" >孤老优抚对象（人）</td>
				<td class="FieldInput" ><input type="text" name="specialassistance" style="width:80%" field="specialassistance"  /> </td>
				<td class="FieldLabel" ></td>
				<td class="FieldInput" ></td>
				
				
				<input type="hidden" name="id" field="id"  />
			</tr>
				
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
