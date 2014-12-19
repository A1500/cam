<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.sdmz.comm.util.BspUtil"%>
<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	int sign=0;
	//联动
	if(organArea.substring(4,12).equals("00000000")){//市用户
		sign=1;
	}else if(organArea.substring(6,12).equals("000000")){//区用户
		sign=2;
	}
%>
<style type="text/css">
#svgid { position: relative; }
</style>
<html>
	<head>
		<title>救助对象民族分布统计</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
		<script type="text/javascript" src="knhByFolkAnalysis_list.js"></script>
		<script language="javascript">
			var organArea='<%= organArea%>';
			var sign='<%= sign%>';
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
	<model:dataset id="ds" cmd="com.inspur.sdmz.comm.analysis.knhByFolkAnalysis.cmd.KnhByFolkAnalysisPieCommand" global="true" autoLoad="true" pageSize="100">
	</model:dataset>
	<model:dataset id="jzlxDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" pageSize="35">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean">
		</model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean">
		</model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="DmXzqhDataSetState" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetStreet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetVillage" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" height="200">
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 95%; height: 100%;" class="L5form">
				<table  border="1" width="100%" height="100">
				
					<tr>
					<%if(sign==1) {%>
						<td class="FieldLabel">区县：</td>
						<td class="FieldInput"><select id="county" name="区" field="county" onchange="setXzqhStreet()" >
							<option dataset="DmXzqhDataSetState"></option></select></td>
					<%}%>
					
						<td class="FieldLabel">街镇:</td>
						<td class="FieldInput">
							<select id="dzZhenquery" onchange="getDzCun()">
								<option dataset="DmXzqhDataSetStreet"></option>
							</select>
						</td>	
					
						<td class="FieldLabel">村居:</td>
						<td class="FieldInput">
							<select id="dzCunquery">
								<option dataset="DmXzqhDataSetVillage"></option>
							</select>
						</td>
						<td class="FieldLabel" nowrap>民族:</td>
						<td class="FieldInput">
							<select id="nation" name="民族" field="nation" >
								<option dataset="folkDs"></option>
							</select>
						</td>	
					</tr>
				
				
					<tr>
						<td class="FieldLabel" nowrap>救助类型:</td>
						<td <%if(sign==1) {%>colspan="7"<%}else{%>colspan="5"<%}%> class="FieldInput">
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

<next:Panel id="svgid" name="tabpanel-div" height="550"  width="100%" autoScroll="true" >
	<next:Defaults>
		{bodyStyle:'padding:15px;'}
	</next:Defaults>

	<next:Html>
		<div id = "svgDiv"></div>
	</next:Html>
</next:Panel>
 
</body>
</html>