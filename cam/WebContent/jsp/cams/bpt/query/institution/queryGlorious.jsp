<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var cxsj = '<%=request.getParameter("cxsj")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="queryGlorious.js"></script>
<script type="text/javascript" src="../querycomm.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.query.cmd.GloriousCmd" global="true" autoLoad="false">
		<model:record>
			<model:field name="ID" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="BUILDED" type="string" />
			<model:field name="BUILD" type="string" />
			<model:field name="BUILDING" type="string" />
			<model:field name="JOINTLYBUILT" type="string" />
			<model:field name="SINGLEBUILDING" type="string" />
			<model:field name="APPROVAL_NUM" type="string" />
			<model:field name="UNAPPROVAL_NUM" type="string" />
			<model:field name="PREPARE_NUM" type="string" />
			<model:field name="BED_NUM" type="string" />
			<model:field name="TOTAL_FUNDS" type="string" />
			<model:field name="COUNTYFUNDS" type="string" />			
			<model:field name="CITYFUNDS" type="string" />
			<model:field name="ABOVE_CITYFUNDS" type="string" />
			<model:field name="SPECIALASSISTANCE" type="string" />
			<model:field name="OTHER_NUM" type="string" />			
			<model:field name="CARE_ROTATION" type="string" />
			<model:field name="GLORYROOM" type="string" />
			<model:field name="CARE_PEOPLE" type="string" />
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
					<td colspan="3" align="center" class="FieldLabel" id="time">查询年份：</td>
					<td class="FieldInput"> 
						<input type="text" id="cxsj" format="Y" style="width: 100px;"
							maxlength="4" /><img
							src="../../../../../skins/images/default/rl.gif" align="middle"
							onClick="getTimes(this);">
					</td>
					<td class="FieldLabel" style="width: 150px;">
						<button onClick="query()" id="queryButton">查 询</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button onClick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">光荣院发展情况统计表</span></div>
			<div align="right" class="L5form">
			<button onclick="printBill()">打印</button>
			</div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
			<table width="104%" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
				<tr>
					<td class="tdTitle" width="10%" rowspan="4" align="center">单位</td>
					<td class="tdTitle" colspan="5" align="center">建设情况</td>
					<td class="tdTitle" width="5%" rowspan="2" colspan="2" align="center">有无<br/>编委批文</td>
					<td class="tdTitle" width="5%" rowspan="4" align="center">编制<br/>人数</td>
					<td class="tdTitle" width="5%" rowspan="4" align="center">床位数</td>
					<td class="tdTitle" colspan="4" align="center">资金投入情况</td>
					<td class="tdTitle" colspan="5" align="center">服务情况</td>
				</tr>
				<tr>
					<td class="tdTitle" colspan="3" align="center">建设状况</td>
					<td class="tdTitle" colspan="2" align="center">建设方式</td>
					<td class="tdTitle" width="6%" rowspan="2" align="center">总计投入</td>
					<td class="tdTitle" colspan="3" align="center">其 中</td>
					<td class="tdTitle" colspan="2" align="center">集中供养</td>
					<td class="tdTitle" width="5%" rowspan="2" align="center">轮养</td>
					<td class="tdTitle" width="5%" rowspan="2" align="center">敬老院<br/>光荣间</td>
					<td class="tdTitle" width="5%" rowspan="2">在敬老院<br/>孤老优抚<br/>对象</td>
				</tr>
				<tr>
					<td class="tdTitle" width="5%" rowspan="2" align="center">建成<br/>并使用</td>
					<td class="tdTitle" width="5%" rowspan="2" align="center">建成<br/>未使用</td>
					<td class="tdTitle" width="5%" rowspan="2" align="center">在建</td>
					<td class="tdTitle" width="5%" rowspan="2" align="center">合建</td>
					<td class="tdTitle" width="5%" rowspan="2" align="center">单建</td>
					<td class="tdTitle" width="5%" rowspan="2" align="center">是</td>
					<td class="tdTitle" width="5%" rowspan="2" align="center">否</td>
					<td class="tdTitle" width="6%" align="center">县级投入</td>
					<td class="tdTitle" width="6%" align="center">市级投入</td>
					<td class="tdTitle" width="6%" align="center">市级以上<br/>投入</td>
					<td class="tdTitle" width="5%" align="center">孤老<br/>优抚对象</td>
					<td class="tdTitle" width="5%" align="center">其他<br/>优抚对象</td>
				</tr>
				<tr>
					<td class="tdTitle" align="center">万元</td>
					<td class="tdTitle" align="center">万元</td>
					<td class="tdTitle" align="center">万元</td>
					<td class="tdTitle" align="center">万元</td>
					<td class="tdTitle" align="center">人</td>
					<td class="tdTitle" align="center">人</td>
					<td class="tdTitle" align="center">人次</td>
					<td class="tdTitle" align="center">间</td>
					<td class="tdTitle" align="center">人</td>
				</tr>
				<tr repeat="true">
					<td style="display: none" class="td">
						<label readonly="true" field="ID"></label>
					</td>
					<td align="left" nowrap="nowrap" class="td">
						<a href="#" style="cursor:hand">
						<label readonly="true" onclick="test(this)" field="NAME" style="line-height:20px;"></label> 
						<label style="display: none" readonly="true" field="ID" ></label>
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#"	style="cursor: hand"> 
						<label onClick="querydetail(this,'buildState','1')" readonly="true" field="BUILDED"></label> 
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'buildState','2')" readonly="true" field="BUILD" ></label> 
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'buildState','3')" readonly="true" field="BUILDING"></label> 
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'buildingapproach','1')" readonly="true" field="JOINTLYBUILT"></label> 
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'buildingapproach','2')" readonly="true" field="SINGLEBUILDING"></label> 
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'approval','1')" readonly="true" field="APPROVAL_NUM"></label> 
						</a>
					</td>					
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'approval','0')" readonly="true" field="UNAPPROVAL_NUM"></label> 
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'prepareNum','1')" readonly="true" field="PREPARE_NUM"></label> 
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'bedNum','1')" readonly="true" field="BED_NUM"></label> 
						</a>
					</td>
					<td align="right" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'totalFunds','1')" readonly="true" field="TOTAL_FUNDS"></label> 
						</a>
					</td>
					<td align="right" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand"> 
						<label onClick="querydetail(this,'countyfunds','1')" readonly="true" field="COUNTYFUNDS"></label> 
						</a>
					</td>
					<td align="right" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand">
						<label onclick="querydetail(this,'cityfunds','1')" readonly="true" field="CITYFUNDS"></label>
						</a>
					</td>
					<td align="right" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand">
						<label onclick="querydetail(this,'aboveCityfunds','1')" readonly="true" field="ABOVE_CITYFUNDS"></label>
						</a>
					</td>					
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand">
						<label onclick="querydetail(this,'specialassistance','1')" readonly="true" field="SPECIALASSISTANCE"></label>
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand">
						<label onclick="querydetail(this,'otherNum','1')" readonly="true" field="OTHER_NUM"></label>
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand">
						<label onclick="querydetail(this,'careRotation','1')" readonly="true" field="CARE_ROTATION"></label>
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand">
						<label onclick="querydetail(this,'gloryroom','1')" readonly="true" field="GLORYROOM"></label>
						</a>
					</td>
					<td align="center" nowrap="nowrap" class="td">
						<a href="#" style="cursor: hand">
						<label onclick="querydetail(this,'carePeople','1')" readonly="true" field="CARE_PEOPLE"></label>
						</a>
					</td>					
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>