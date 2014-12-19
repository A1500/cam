<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
%>
<html>
<head>
<title>困难户男女比例分析</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
<script type="text/javascript" src="samMBalanceReportByDomMoney.js"></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
<script language="javascript">
			var organArea='<%= organArea%>';
		    var struId='<%=BspUtil.getStruId()%>';
			var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>'
			var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>';
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
	<!-- 一站式救助报表统计 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForFlex" global="true">
		<model:record>
			<model:field name="domicileName" type="string" />
			<model:field name="SUMASSPAY" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel name="form" width="99.9%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 100%; height: 100%;" class="L5form">
			<table border="1">
				<tr>
					<td class="FieldLabel" style="width: 20%;"><label>救助对象属地：</label></td>
					<td class="FieldInput" style="width: 20%;" ><input type="text" onclick="forHelp(this.id)"
						id="qapanage" /></td>
					<td style="display:none;"><input type="text" id="qapanageCode" /></td>
					<td class="FieldLabel" nowrap="nowrap" width="10%" >救助（补助）日期：</td>
					<td class="FieldInput" nowrap="nowrap" width="45%"><input type="text"
						id="beginTime" format="Y-m-d" name="beginTime" style="width: 35%"
						onclick="LoushangDate(this)" readonly="readonly" /> ----- <input
						type="text" id="endTime" format="Y-m-d" name="endTime"
						style="width: 35%" onclick="LoushangDate(this)"
						readonly="readonly" /></td>
					<td class="FieldButton">
						<button onclick="query()">查 询</button>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%;"></td>
					<td class="FieldInput" style="width: 20%;" ></td>
					<td class="FieldLabel" nowrap="nowrap">救助金额区间（元）：</td>
					<td class="FieldInput" nowrap="nowrap" width=""><input type="text"
						id="minPay" format="Y-m-d" name="minPay" style="width: 35%"
						 /> ----- <input
						type="text" id="maxPay" format="Y-m-d" name="maxPay"
						style="width: 35%"  /></td>
					<td class="FieldButton">
					<button onclick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel name="tabpanel-div" height="120%">
		<next:Defaults>
		{bodyStyle:'padding:15px;'}
	</next:Defaults>
		<next:Html>
			<div id="svgDiv"></div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>