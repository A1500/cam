<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.bpt.query.cmd.NewDisabilityDeviceTongJiCmd"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="page_disabilityDevice.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>

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
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<%
String devType = request.getParameter("devType");
devType=devType==null?"1":devType;
String devName="";
switch (Integer.parseInt(devType)){
	case 1:
		devName="假肢";
		break;
	case 2:
		devName="矫形器";
		break;
	case 3:
		devName="移动辅助器具";
		break;
	case 4:
		devName="生活自理类辅助器";
		break;
	case 5:
		devName="信息交流辅助器具";
		break;
	case 6:
		devName="其他辅助器具";
		break;
}
%>
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
<input type="hidden" id="state" value="2"/>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.query.cmd.NewDisabilityDeviceTongJiCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="Y1" type="string" />
			<model:field name="Y2" type="string" />
			<model:field name="Y3" type="string" />
			<model:field name="Y4" type="string" />
			<model:field name="Y5" type="string" />
			<model:field name="Y6" type="string" />
			<model:field name="Y7" type="string" />
			<model:field name="Y8" type="string" />
			<model:field name="Y9" type="string" />
			<model:field name="Y10" type="string" />
			<model:field name="Y11" type="string" />
			<model:field name="Y12" type="string" />
			<model:field name="Y13" type="string" />
			<model:field name="Y14" type="string" />
			<model:field name="Y15" type="string" />
			<model:field name="Y16" type="string" />
			<model:field name="Y17" type="string" />
			<model:field name="Y18" type="string" />
			<model:field name="Y19" type="string" />
			<model:field name="Y20" type="string" />
			<model:field name="Y21" type="string" />
			<model:field name="Y22" type="string" />
			<model:field name="Y23" type="string" />
			<model:field name="Y24" type="string" />
			<model:field name="Y25" type="string" />
			<model:field name="Y26" type="string" />
			<model:field name="Y27" type="string" />
			<model:field name="Y28" type="string" />
			<model:field name="Y29" type="string" />
			<model:field name="Y30" type="string" />
			<model:field name="Y31" type="string" />
			<model:field name="Y32" type="string" />
			<model:field name="Y33" type="string" />
			<model:field name="Y34" type="string" />
			<model:field name="Y35" type="string" />
			<model:field name="Y36" type="string" />
			<model:field name="Y37" type="string" />
			<model:field name="Y38" type="string" />
			<model:field name="Y39" type="string" />
			<model:field name="Y40" type="string" />
			<model:field name="Y41" type="string" />
			<model:field name="Y42" type="string" />
			<model:field name="Y43" type="string" />
			<model:field name="Y44" type="string" />
			<model:field name="Y45" type="string" />
			<model:field name="Y46" type="string" />
			<model:field name="Y47" type="string" />
			<model:field name="Y48" type="string" />
			<model:field name="Y49" type="string" />
			<model:field name="Y50" type="string" />
			<model:field name="Y51" type="string" />
			<model:field name="Y52" type="string" />
			<model:field name="Y53" type="string" />
			<model:field name="Y54" type="string" />
			<model:field name="Y55" type="string" />
			<model:field name="Y56" type="string" />
			<model:field name="Y57" type="string" />
			<model:field name="Y58" type="string" />
			<model:field name="Y59" type="string" />
			<model:field name="Y60" type="string" />
			<model:field name="Y61" type="string" />
			<model:field name="Y62" type="string" />
			<model:field name="Y63" type="string" />
			<model:field name="Y64" type="string" />
			<model:field name="Y65" type="string" />
			<model:field name="Y66" type="string" />
			<model:field name="Y67" type="string" />
			<model:field name="Y68" type="string" />
			<model:field name="Y69" type="string" />
			<model:field name="Y70" type="string" />
			<model:field name="Y71" type="string" />
			<model:field name="Y72" type="string" />
			<model:field name="Y73" type="string" />
			<model:field name="Y74" type="string" />
			<model:field name="Y75" type="string" />
			<model:field name="Y76" type="string" />
			<model:field name="Y77" type="string" />
			<model:field name="Y78" type="string" />
			<model:field name="Y79" type="string" />
			<model:field name="Y80" type="string" />
			<model:field name="Y81" type="string" />
			<model:field name="Y82" type="string" />
			<model:field name="Y83" type="string" />
			<model:field name="Y84" type="string" />
			<model:field name="Y85" type="string" />
			<model:field name="Y86" type="string" />
			<model:field name="Y87" type="string" />
			<model:field name="Y88" type="string" />
			<model:field name="Y89" type="string" />
			<model:field name="Y90" type="string" />
			<model:field name="Y91" type="string" />
			<model:field name="Y92" type="string" />
			<model:field name="Y93" type="string" />
			<model:field name="Y94" type="string" />
			<model:field name="Y95" type="string" />
			<model:field name="Y96" type="string" />
			<model:field name="Y97" type="string" />
			<model:field name="Y98" type="string" />
			<model:field name="Y99" type="string" />
			<model:field name="Y100" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td  style="background-color: #f5fafa;text-align: center;font: normal 12px tahoma, arial, helvetica, sans-serif;"><select id ="timeType" onchange="showTime()">
					<option value="2">批准截止日期</option>
					<option value="1">批准起止日期</option>
					</select> </td>
					<td class="FieldInput"  colspan="3" id ="times" style="display: none;" ><input type="text" id="cxsj_qs"
						format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_zs" format="Y-m-d"
						style="width: 100px;" maxlength="10"   onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					
					<td class="FieldInput" colspan="3"  id = "time" ><input type="text" id="cxsj_z"
						format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					
					<td class="FieldInput"   >
					<select id ="devType" onchange="loadpanel(this)" >
							<option value="1" <%="1".equals(devType)?"selected ='selected'":""%>>假 肢</option>
							<option value="2" <%="2".equals(devType)?"selected ='selected'":""%>>矫形器</option>
							<option value="3" <%="3".equals(devType)?"selected ='selected'":""%>>移动辅助器具</option>
							<option value="4" <%="4".equals(devType)?"selected ='selected'":""%>>生活自理类辅助器具</option>
							<option value="5" <%="5".equals(devType)?"selected ='selected'":""%>>信息交流辅助器具</option>
							<option value="6" <%="6".equals(devType)?"selected ='selected'":""%>>其他 辅助器具</option>
					</select> </td>
					<td>
					<button id="queryButton" onclick="query()">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="set()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0" id="spanel"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">革命伤残军人<%=devName %>配备情况表</span></div>
			<div align="right" class="L5form">
			<button onclick="method()">打印</button>
			</div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
					<table  dataset="ds" align="center"  style="margin-left:40px;margin-right:40px;">
						<tr>
							
							<td class="tdTitle" rowspan="2" align="center">单位</td>
							<td class="tdTitle" width="30" rowspan="2"  align="center">人次</td>
							
							<%
							
							NewDisabilityDeviceTongJiCmd  ndjcmd= new NewDisabilityDeviceTongJiCmd();
							DataSet ds = ndjcmd.queryDevicesInfo(devType);
							for(int i=0;i<ds.getCount();i++){
								Record record=ds.getRecord(i);
							%>
							<td class="tdTitle" width="60" colspan="2" align="center"><%=record.get("apparatusName") %>(<%=record.get("unit") %>)</td>
							<%
							}
							%>
							
						</tr>
						<tr>
							<%
							for(int i=0;i<ds.getCount();i++){
								Record record=ds.getRecord(i);
							%>
							<td class="tdTitle" width="30" align="center">配置</td>
							<td class="tdTitle" width="30" align="center">维修</td>
							<%
							}
							%>
						</tr>
						<tr repeat="true">
							
							<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
								onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>
							<td align="right" width="30" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'<%=devType %>0000','')" field="Y1" ></label></a></td>
							<%
							int n1=2;
							int n2=3;
							for(int i=0;i<ds.getCount();i++){
								Record record=ds.getRecord(i);
								
							%>
							<td align="right" width="30" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'<%=record.get("applyApparatusId") %>','0')" field="Y<%=n1 %>" ></label></a></td>
							<td align="right" width="30" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'<%=record.get("applyApparatusId") %>','1')" field="Y<%=n2 %>" ></label></a></td>
							<%
								n1+=2;
								n2+=2;
							}
							%>

							
						</tr>
					</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>