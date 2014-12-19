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
<title>城市最低生活保障家庭成员信息列表</title>
<next:ScriptManager />
<script type="text/javascript" src="lowAreaSort_Family.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
L5.lib.Ajax.timeout='300000';
    var organCode = '<%=organArea%>';
	var organName="";
	var query_organCode="<%=request.getParameter("query_organCode")%>";//点击的行政区划
	var autoQuery = "<%=request.getParameter("autoQuery")%>"
	var startTime = "<%=request.getParameter("startTime")%>";//起始时间
	var endTime="<%=request.getParameter("endTime")%>";//结束时间
	var sortType="<%=request.getParameter("sortType")%>";//属别
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseDetail"></model:record>
	</model:dataset>
	<model:dataset id="bankDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dic" value='DIC_BANK'></model:param>
        </model:params>
    </model:dataset>
	<!-- 救助类别 -->
    <model:dataset id="assistanceTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
			<model:param name="includeCode" value='01,02,03'></model:param>
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
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel">姓名：</td>
				<td class="FieldInput"><input type="text" id="name" class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="idCard" class="TextEditor" title="身份证件号码" style="width: 135" maxlength="18"/></td>
				<td class="FieldInput"  style="text-align: center"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="100%" stripeRows="true" height="100%" dataset="ds"    title="最低生活保障家庭成员信息列表" autoScroll="true" collapsible="true" autoWidth="true">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
    </next:TopBar>
    <next:Columns>
		<next:RowNumberColumn width="25" />
		<next:Column id="detailId" header="DETAIL_ID" field="detailId" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyId" header="FAMILY_ID" field="familyId" hidden="true" >
			<next:TextField  />
		</next:Column>
		<next:Column id="domicileName" header="地区" field="domicileName" width="120"  align="center" >
            <next:TextField  />
        </next:Column>
		<next:Column id="name" header="名称" field="name" width="90"   align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="idCard" header="身份证号码" field="idCard" width="150"  align="center" >
			<next:TextField  />
		</next:Column>
		<next:Column id="assistancePeopleNum" header="保障人数" field="assistancePeopleNum" width="90"  align="right">
			<next:NumberField  />
		</next:Column>
		<next:Column id="releaseMonSum" header="发放合计(元)" field="releaseMonSum" width="90"   renderer="formatMoney" align="right">
            <next:NumberField  />
        </next:Column>
        <next:Column id="baseMon" header="保障金(元)" field="baseMon" width="90"  renderer="formatMoney" align="right">
            <next:NumberField  />
        </next:Column>
        <next:Column id="classMon" header="分类施保金(元)" field="classMon" width="90"  renderer="formatMoney" align="right">
            <next:NumberField  />
        </next:Column>
        <next:Column id="accountName" header="账户名称" field="accountName" width="90"   align="center">
            <next:TextField  />
        </next:Column>
        <next:Column id="bank" header="开户银行" field="bank" width="120" dataset="bankDs"  align="center">
            <next:TextField  />
        </next:Column>
        <next:Column id="accountNumber" header="账号" field="accountNumber" width="150"  align="center" >
            <next:TextField  />
        </next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>

</html>
