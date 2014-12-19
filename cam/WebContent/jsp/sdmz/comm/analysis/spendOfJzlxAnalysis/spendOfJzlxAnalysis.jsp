<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>救助项目投入统计</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
		<script type="text/javascript" src="spendOfJzlxAnalysis.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.sdmz.comm.analysis.spendOfJzlxAnalysis.cmd.SpendOfJzlxPieCommand" global="true" autoLoad="true" pageSize="100">
	</model:dataset>
	<model:dataset id="jzlxDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" pageSize="35">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean">
		</model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" height="200" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 95%; height: 100%;" class="L5form">
				<table  border="1" width="100%" height="100">
					<tr>
						<td class="FieldLabel" nowrap>救助时间 从:</td>
						<td class="FieldInput"><input type="text" id="startDateQuery" format="Y-m-d" onclick="LoushangDate(this)"/>
						</td>
						<td class="FieldLabel" nowrap>&nbsp;&nbsp;至:&nbsp;&nbsp;</td>
						<td class="FieldInput"><input type="text" id="endDateQuery" format="Y-m-d" onclick="LoushangDate(this)"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>救助类型:</td>
						<td colspan="3" class="FieldInput">
							<input type="text" id="jzlxDisplay" readOnly="true" style="width:65%" ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" />
							<img src="<%=SkinUtils.getImage(request, "help.gif")%>" style="cursor:hand" onclick="mutiHelp('jzlxDs','jzlxDisplay','jzlxquery')"/>
							<input type="hidden" id="jzlxquery"><button onclick="query()">查 询</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:Panel name="tabpanel-div" height="550"  width="100%" autoScroll="true">
	<next:Defaults>
		{bodyStyle:'padding:15px;'}
	</next:Defaults>
	<next:Html>
		<div id = "svgDiv"></div>
	</next:Html>
</next:Panel>

</body>
</html>