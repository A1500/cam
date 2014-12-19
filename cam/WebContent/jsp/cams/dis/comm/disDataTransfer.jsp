<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>救灾数据自动转储</title>
<next:ScriptManager></next:ScriptManager>

<script type="text/javascript" src="disDataTransfer.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>

<next:Panel width="100%" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">转储条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 100%;height: 10%;" class="L5form">
				<table  border="1" width="100%" height="10%">
					<tr>
						<td class="FieldLabel">开始时间:</td>
				        <td class="FieldInput"><input type="text" id="startTime" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"
					        class="TextEditor" title="开始时间" /></td>
					
                        <td class="FieldLabel">结束时间:</td>
				        <td class="FieldInput"><input type="text" id="endTime" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"
					        class="TextEditor" title="结束时间" /></td>
					 	<td class="FieldLabel">
							<button onclick="excuteProvinceToCpc()">救灾数据自动转储</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
</body>
</html>