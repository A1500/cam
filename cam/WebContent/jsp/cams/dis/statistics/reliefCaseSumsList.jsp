<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var ffsjq = '<%=request.getParameter("cxsjq")%>';
	var ffsjz = '<%=request.getParameter("cxsjz")%>';
</script>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="reliefCaseSumsList.js"></script>
<style>
body {
	background-color: #EAF4FD;
}

table {
	border-collapse: collapse;
}

input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

.td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	font-weight: bold;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets>
	<!--救灾类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel name="form" width="100%" border="0" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 100%; height: 100%;" id="queryform"
				class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" nowrap>起止日期:</td>
					<td class="FieldInput"><input type="text"
						id="ffsj_q" format="Y-m-d" style="width: 100px;" maxlength="10"
						onpropertychange="changeDateStyle(this)" /><img
						src="../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this);">&nbsp;至&nbsp;<input type="text"
						id="ffsj_z" format="Y-m-d" style="width: 100px;" maxlength="10"
						onpropertychange="changeDateStyle(this)" /><img
						src="../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this);"></td>
					<td class="FieldLabel">救助类型:</td>
					<td class="FieldInput"><select type="text" id="qReliefType"
						class="TextEditor" title="救助类型" style="width: 200" />
						<option dataset="ReliefTypeDataset"></option>
					</select></td>
					<td class="FieldButton">
					<button id="queryButton" onclick="query()">查 询</button>
					&nbsp;&nbsp;
					<button onclick="pageReset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	
	<next:Panel width="100%" height="100%" id="subPanel">
		<next:Html>
			<iframe id="subIframe" src="" frameborder="no" border="0"
				marginwidth="0" marginheight="0" scrolling="no"
				allowtransparency="yes" width="100%" height="100%"> </iframe>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>