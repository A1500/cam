<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>
<%
String struId = BspUtil.getStruId();
String organArea = BspUtil.getCorpOrgan().getOrganCode();
int sign=0;
if(organArea.substring(4,12).equals("00000000")){//市级用户
	sign=1;
}
%>
<html>
<head>
<title>城市最低生活保障家庭信息列表</title>
<next:ScriptManager />
<script type="text/javascript" src="lowAreaSort_People.js"></script>
<script type="text/javascript" src="jtxxComm.js"></script>

<script language="javascript">
    var organCode = '<%=organArea%>';
	var organName="";
	var query_organCode="<%=request.getParameter("query_organCode")%>";
	var autoQuery = "<%=request.getParameter("autoQuery")%>"
	var startTime = "<%=request.getParameter("startTime")%>";
	var endTime="<%=request.getParameter("endTime")%>";
	var sortType="<%=request.getParameter("sortType")%>";
	
	var type = "<%=request.getParameter("type") == null?"":request.getParameter("type")%>";
  //查询条件打开合并函数
 var struId='<%=struId%>';
 var organArea='<%=organArea%>';
 var organName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
 var sign = '<%= sign%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" global="true" pageSize="15" method="queryAssistancePeo">
	</model:dataset>
	<model:dataset id="sexDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>	
	<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" autoScroll="true"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>"
			onclick="collapse(this)" /></legend>
		<div>
		<form style="width: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">成员姓名：</td>
				<td class="FieldInput"><input type="text" id="name" class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap="nowrap">成员身份证：</td>
				<td class="FieldInput"><input type="text" id="idCard" class="TextEditor" title="身份证件号码" style="width: 135" maxlength="18"/></td>
				<td class="FieldInput"  style="text-align: center"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="100%" stripeRows="true" height="100%" dataset="ds"    title="最低生活保障家庭信息列表" autoScroll="true" collapsible="true" autoWidth="true">
	<next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
    </next:TopBar>
    <next:Columns>
		<next:RowNumberColumn width="25" />
		<next:Column header="姓名" field="NAME" width="90"   align="center">
			<next:TextField  />
		</next:Column>
		<next:Column header="性别" field="SEX" width="180"   align="center" dataset="sexDS">
			<next:TextField  />
		</next:Column>
		<next:Column header="身份证号" field="ID_CARD" width="180"   align="center">
			<next:TextField  />
		</next:Column>
		<next:Column header="与户主关系" field="RELATIONSHIP_TYPE" width="180"   align="center" dataset="relationshipTypeDataset">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>

</html>
