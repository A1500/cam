<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>系统签名管理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="sysSign.js"></script>
		<script language="javascript"> 	
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="sysds" cmd="org.loushang.live.sign.cmd.SignQueryCmd" method="sysExecute" global="true" pageSize="20" >
		<model:record fromBean="org.loushang.live.sign.data.Sign">
		</model:record>
	</model:dataset>
	<model:dataset id="signStatDs" enumName="SIGN.STAT" global="true"  autoLoad="true"></model:dataset>
</model:datasets>

<next:Panel title="系统签名" closable="false" id="sysPanel" name="sysPanel" height="100%"width="100%">
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>	
				<next:ToolBarItem id="sys" text="保存" iconCls="edit" handler="clickSave"/>	
		    </next:TopBar>			
	<next:Html>
	<br></br>
	<center>			
			
			<form class="L5form" id="sysform" dataset="sysds">
				<table  width="60%">
						<tr>
							<td class="FieldLabel" width="20%" ><center>系统前签名</center></td>
							<td>
								<input type="text" id="ssSign" name="ssSign" onclick=""field="ssign" style="width:300" onfocus="warn(this)" onblur="afterWarn(this)" ></input>
								<font id="ssSigntest" color="red" style="font-size:12">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" ><center>系统后签名</center></td>
							<td>
								<input type="text" id="sfSign" name="sfSign" field="fsign" style="width:300"onfocus="warn(this)" onblur="afterWarn(this)" ></input>
								<font id="sfSigntest" color="red" style="font-size:12">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" ><center>使用状态</center></td><td>
								<select field="stat"  style="width:140" id="statselect" onfocus="warn(this)" onblur="afterWarn(this)" >
									<option dataset="signStatDs"/>
								</select>
							<font id="statselecttest" color="red" style="font-size:12">*</font>
							</td>
						</tr>
				</table>
			</form>	
			</center>		
			</next:Html>
		</next:Panel>

</body>
</html>
