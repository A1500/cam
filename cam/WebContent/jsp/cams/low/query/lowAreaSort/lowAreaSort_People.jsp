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
	<model:dataset id="ds" cmd="com.inspur.cams.low.query.cmd.LowAreaSortQueryCmd" pageSize="20" method="queryPeople" global="true" autoLoad="false">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="99%" border="0" autoScroll="true"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>"
			onclick="collapse(this)" /></legend>
		<div>
		<form style="width: 98%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">成员姓名：</td>
				<td class="FieldInput"><input type="text" id="name" class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap="nowrap">成员身份证：</td>
				<td class="FieldInput"><input type="text" id="idCard" class="TextEditor" title="身份证件号码" style="width: 135" maxlength="18"/></td>
			    <td class="FieldLabel" nowrap="nowrap">所属机构：</td>
				<td class="FieldInput" ><input type="text" id="domicileName" style="width: 150"
					class="TextEditor" title="属地行政区划" onclick="query_selectDomicile()" /> <input
					type="hidden" id="domicileCode" class="TextEditor" title="属地行政区划" />
				</td>
				<td class="FieldInput"  style="text-align: center"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="99%" stripeRows="true" height="470" dataset="ds"    title="最低生活保障家庭信息列表" autoScroll="true" collapsible="true" autoWidth="true">
	<next:Columns>
		<next:RowNumberColumn width="25" />
		<next:Column id="HZXM"        header="户主姓名"   field="HZXM"    width="6%"    align="center"/>
		<next:Column id="PEOPLE_NAME" header="成员姓名"   field="PEOPLE_NAME"  width="6%"  align="center" />
		<next:Column id="ID_CARD"      header="成员身份证"   field="ID_CARD"   width="11%" align="center"/>
		<next:Column id="LOW_NO"      header="低保证号"    field="LOW_NO"     width="8%" align="center"/>
		<next:Column id="FAMILY_NUM"  header="家庭人口数"  field="FAMILY_NUM"  width="6%" align="right"/>
	    <next:Column id="LOW_NUM"     header="保障人口数"  field="LOW_NUM"     width="6%" align="right"/>
	    <next:Column id="AUDIT_TIME"  header="审批时间"    field="AUDIT_TIME" width="8%" align="center" />
		<next:Column id="ADDRESS"     header="家庭地址"   field="ADDRESS"   width="15%" align="center"/>
		<next:Column id="TOWN"        header="区县"      field="TOWN"      width="6%" align="center"/>
		<next:Column id="STREET"      header="街道"      field="STREET"     width="10%" align="center"/>
		<next:Column id="VILLAGE"     header="居委会"     field="VILLAGE"    width="10%" align="center"/>
		<next:Column id="CARD_NO"     header="银行卡卡号" field="CARD_NO"     width="10%" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>

</html>
