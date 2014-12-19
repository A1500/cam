<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>低保家庭查询</title>
<next:ScriptManager />
	<script type="text/javascript">
		    var releaseId='<%=request.getParameter("releaseId")%>';
		    var assistanceType='<%=request.getParameter("assistanceType")%>';
		    var releaseDate='<%=request.getParameter("releaseDate")%>';
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
	</script>
	<script type="text/javascript" src="samFamilySpecialAss.js"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
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
	<!-- 基础信息_家庭信息 -->
	<model:dataset id="baseinfoFamilyDS" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" method="querySamFamilyList" >
	</model:dataset>
	<!-- 发放名册 -->
    <model:dataset id="releaseSummaryDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryQueryCmd" global="true">
        <model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseSummary">
        	<model:field name="assistanceUnit"/>
        </model:record>
    </model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="AssistanceDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='01,02,03'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
	
<next:Panel  name="form" width="100%" border="0">
	<next:Html>	
		<fieldset>
			<legend>查询条件
				<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this)" />
			</legend>
			<div>
				<form class="L5form">
					<table width="100%" >
						<tr>
					    	<td class="FieldLabel" nowrap="nowrap" width="8%">地区:</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" id="domicileName" style="width:150" readonly="readonly" />
					        	<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand" onclick="func_ForDomicileSelect()"/>
								<input type="text" id="domicileCode" name="carCode" style="display: none"/>
					        </td>
					        <td class="FieldLabel" nowrap="nowrap" width="8%">低保证号:</td>
					        <td class="FieldInput" width="25%">
					        	<input id="cardNo" name="cardNo" style="width:150"/>
					        </td>
					    	<td class="FieldLabel" nowrap="nowrap" width="8%">户主姓名:</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" name="familyName" id="familyName"/>
					        </td>
							<td class="FieldButton" width="8%">
								<button onclick="query()" id="queryBtn">查 询</button>
							</td>
					    </tr>
					    <tr>
					        <td class="FieldLabel" nowrap="nowrap" width="8%">身份证号码:</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" style="width:150" name="familyCardNo" id="familyCardNo"/>
					        </td>
					     	<td class="FieldLabel" nowrap="nowrap" width="8%">保障人口数:</td>
					        <td class="FieldInput" width="25%">
								<input type="text" id="sAssitancePeopleNum" name="sAssitancePeopleNum" style="width:68"/>
						        ~
						       	<input type="text" id="eAssitancePeopleNum" name="eAssitancePeopleNum" style="width:68"/>
					        </td>
                            <td class="FieldLabel" nowrap="nowrap" width="8%">享受保障年月:</td>
                            <td class="FieldInput" width="25%">
                                <input type="text" id="assistanceBegin" name="assistanceBegin" format="Y-m" readonly="readonly" onclick="setmonth(this)"  />
                            </td>
                            <td nowrap="nowrap" class="FieldButton" width="8%">
                                <button onclick="resetQuery()">重 置</button>
                            </td>
					     </tr>
					</table>
				</form>
			</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="infoQueryGrid" name="baseinfoFamilyResource" stripeRows="true" height="100%" width="100%" clickToSelectedForChkSM="true" dataset="baseinfoFamilyDS" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="低保家庭查询信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="添加选中救助对象" iconCls="yes" handler="backFamilyIds"></next:ToolBarItem>
		<next:ToolBarItem text="添加全部救助对象" iconCls="yes" handler="backAllFamilyIds"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="disable" handler="closeThisWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column  header="地区" field="DOMICILE_NAME" width="200" align="center">
            <next:TextField />
        </next:Column>
		<next:Column  header="户主姓名" field="FAMILY_NAME"  width="80" align="center">
			<next:TextField />
		</next:Column>
		<next:Column  header="身份证号" field="FAMILY_CARD_NO" width="180" align="center">
			<next:TextField />
		</next:Column>
		<next:Column  header="低保证号" field="CARD_NO" width="130" align="center">
			<next:TextField />
		</next:Column>
		<next:Column  header="家庭人口数" field="PEOPLE_NUM" width="90" align="center">
			<next:TextField />
		</next:Column>
		<next:Column  header="保障人口数" field="ASSISTANCE_PEOPLE_NUM" width="90" align="center">
			<next:TextField />
		</next:Column>
		<next:Column  header="起始保障年月" field="BEGIN_DATE" width="100" align="center">
			<next:TextField />
		</next:Column>
		<next:Column  header="截止保障年月" field="END_DATE" width="100" renderer="dealEndDate" align="center">
			<next:TextField />
		</next:Column>
		<next:Column  header="救助类型" field="ASSISTANCE_TYPE" width="90" align="center" dataset="AssistanceDataset">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="baseinfoFamilyDS" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>