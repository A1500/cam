<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil" %>
<%
	//String organArea = BspUtil.getCorpOrgan().getCorpOrganId();
	String organArea = BspUtil.getCorpOrgan().getOrganCode().substring(0,6);
%>
<html>
	<head>
		<title>最新困难户查询信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="recentKnh_list.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
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
			var organArea = "<%=organArea%>";
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.sdmz.comm.query.knhQuery.cmd.knhQueryCmd" method="recentQuery" global="true" pageSize="15">
	</model:dataset>
	<!-- 行政区划 -->
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
	<model:dataset id="jzlxDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean">
		</model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1"  style="width:100%;table-layout:fixed;" >
							<tr >
								<td class="FieldLabel" nowrap="nowrap" width="10%">街镇:</td>
								<td class="FieldInput" width="20%">
									<select id="dzZhenquery" onchange="getDzCun()">
										<option dataset="DmXzqhDataSetStreet"></option>
									</select>
								</td>	
								<td class="FieldLabel" nowrap="nowrap" width="10%">村居:</td>
								<td class="FieldInput" width="20%">
									<select id="dzCunquery">
										<option dataset="DmXzqhDataSetVillage"></option>
									</select>
								</td>	
								<td class="FieldLabel" nowrap="nowrap" width="10%">录入时间:</td>
								<td class="FieldInput"  width="20%">
									<select id="lrsjquery">
										<option value="1">一天之内</option>
										<option value="7">一周之内</option>
										<option value="14">两周之内</option>
										<option value="30">一月之内</option>
										<option value="365">一年之内</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" nowrap="nowrap" width="10%">审核状态:</td>
								<td class="FieldInput" width="20%">
									<select id="shbzquery">
										<option value="">全部</option>
										<option value="0">转更正</option>
										<option value="1">未审核</option>
										<option value="2">审核未通过</option>
										<option value="3">审核通过</option>
									</select>
								</td>
							
								<td class="FieldLabel" nowrap="nowrap" width="10%">救助类型:</td>
								<td colspan="3" class="FieldInput" nowrap="nowrap">
									<input type="text" id="jzlxDisplay" readOnly="true" style="width:50%" ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" />
									<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="mutiHelp('jzlxDs','jzlxDisplay','jzlxquery')"/>
									<input type="hidden" id="jzlxquery"><button onclick="query()" >查 询</button>&nbsp&nbsp
									<button type="reset">重 置</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="100%" notSelectFirstRow="true" stripeRows="true" height="95%" dataset="ds" title="最新救助家庭信息">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="add" handler="forExcel" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns >
	    <next:RowNumberColumn width="30"/>
		<next:Column id="JTID" header="家庭ID" field="FAMILY_ID" hidden="true" align="center" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="HZXM" header="户主姓名" field="FAMILY_NAME" width="90" align="center" >
			<next:TextField  />
		</next:Column>
		<next:Column id="MEMBER_NAME" header="家庭成员" field="MEMBER_NAME" width="140" align="left">
			<next:TextField  />
		</next:Column>
		<next:Column id="JZLX" header="救助类型" field="ASSISTANCE_TYPE" renderer="jzlxRenderer" width="200" align="left" >
			<next:TextField  />
		</next:Column>
		<next:Column id="ADDRESS" header="家庭地址" field="ADDRESS" width="240" align="left">
			<next:TextField  />
		</next:Column>
		<next:Column id="LRSJ" header="录入时间" field="REG_TIME" width="140" align="center">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"></next:PagingToolBar>
	</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
</body>
</html>