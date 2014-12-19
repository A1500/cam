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
<title>阳光救助_家庭信息列表(综合查询)</title>
<next:ScriptManager />
<script type="text/javascript" src="ygjzjtxx_query_list.js"></script>
<script type="text/javascript" src="../IDCard.js"></script>
<script type="text/javascript" src="../jtxxComm.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>

<script language="javascript">
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
	<model:dataset id="DmActivityDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ACTIVITY'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmOpinionDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_OPINION'></model:param>
		</model:params>
	</model:dataset>
		<!-- 救助类型 -->
	 <model:dataset id="DmJzlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" pageSize="20" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
		<model:dataset id="roleGroupDataSet" cmd="org.loushang.bsp.permit.pap.rolegroup.cmd.RoleGroupQueryCmd" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.rolegroup.data.RoleGroup">
			<model:field name="useCorporation" type="string"/>
			<model:field name="useCorporationName" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="ds" cmd="com.inspur.sdmz.jtxx.cmd.JtxxQueryCommand" pageSize="10" global="true" autoLoad="false">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form id="queryForm"   style="width: 100%; height: 100%;" class="L5form">
		<table border="1" style="width:100%;table-layout:fixed;">
			<tr>
				<td class="FieldLabel" width="10%" nowrap="nowrap">户主姓名:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><input type="text"  id="hzxmquery" name="hzxmquery" maxlength="25" class="TextEditor" title="户主姓名" style="width:90%"/></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">户主身份证:</td>
				<td class="FieldInput" width="17%" nowrap="nowrap"><input type="text" style="width:90%" id="sfzhquery" name="sfzhquery" maxlength="18"  class="TextEditor" title="户主身份证" /></td>
				<td   width="10%" class="FieldInput"  nowrap="nowrap">
			   	<button onclick="jtxxQuery()">查 询</button></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="10%" nowrap="nowrap">审核状态:</td>
				<td class="FieldInput" width="15%"nowrap="nowrap"><select name="shbz" id="shbzquery"  field="shbz" style="width:90%">
										<option dataset="DmOpinionDataSet"></option>
									   </select></td>
			   <td class="FieldLabel" nowrap width=10%>救助类型:</td>
			    <td class="FieldInput" colspan="1" nowrap="nowrap" ><input type="text" id="jzlxDisplay" style="width:60%" readOnly="true" ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="mutiHelp('DmJzlxDataSet','jzlxDisplay','jzlxquery')"/>
							<input type="hidden" id="jzlxquery">
			    </td>

			   <td class="FieldInput"  nowrap="nowrap">
			    <button onclick="reset()">重 置</button>
			    <input  type="hidden"  name="queryFlag"  id="queryFlag" value="QUERY"/>
			  </td>
			   </tr>

		  </table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="98%" stripeRows="true" height="100%" dataset="ds"  title="困难家庭信息查询列表" autoScroll="true" collapsible="true" autoWidth="true">
	<next:Columns>
		<next:RowNumberColumn width="25" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="FAMILY_ID" header="家庭ID" field="FAMILY_ID" hidden="true" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="FAMILY_NAME" header="户主姓名" field="FAMILY_NAME" width="10%" align="center" renderer="jtxxQueryHref"/>
		<next:Column id="FAMILY_CARD_NO" header="身份证号" field="FAMILY_CARD_NO" width="17%" align="center"/>
		<next:Column id="PEOPLE_NUM" header="人口数量" field="PEOPLE_NUM" width="10%" align="center"/>
	    <next:Column id="YEAR_INCOME" header="家庭年收入" field="YEAR_INCOME" width="10%" align="right"/>
	    <next:Column id="CUR_ACTIVITY"  header="当前环节" field="CUR_ACTIVITY" width="11%" align="center" dataset="DmActivityDataSet"/>
		<next:Column id="REG_PEOPLE" header="录入人姓名" field="REG_PEOPLE" width="11%" align="center"/>
		<next:Column id="REG_ORG_NAME" header="录入单位名称" field="REG_ORG_NAME" width="11%" align="center"/>
		<next:Column id="REG_TIME" header="录入时间" field="REG_TIME" width="16%" align="center"/>
		<next:Column id="PHOTO_ID" header="照片ID" field="PHOTO_ID" width="10%" hidden="true" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
