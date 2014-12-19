<%@page import="com.inspur.cams.comm.extuser.util.CamsExtLoginServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>
<%
    String organArea = BspUtil.getCorpOrgan().getOrganCode();
    String assistanceType=request.getParameter("assistanceType");
    String releaseId=request.getParameter("releaseId");
%>
<html>
<head>
<title>保障金调整</title>
<next:ScriptManager />
<script language="javascript">
  //查询条件打开合并函数
 var organArea='<%=organArea%>';
 var assistanceType='<%=assistanceType%>';		    
 var releaseDate='<%=request.getParameter("releaseDate")%>';
 
 var releaseId='<%=releaseId%>';
 var organName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
var domicileCode='<%=request.getParameter("domicileCode")%>';
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
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript" src="samReleaseDetailAdd.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>

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
	<!-- 分类施保类别 -->
	<model:dataset id="assistanceDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
			<model:param name="value" value='ITEM_CODE'></model:param>
			<model:param name="text" value='ITEM_NAME'></model:param>
			<model:param name="itemType" value='01'></model:param>
		</model:params>
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
					    	<td class="FieldLabel" nowrap="nowrap" width="8%">地区</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" id="domicileName" readonly="readonly" style="width:150"/>
					        	<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" 
					        	    style="cursor: hand" onclick="func_ForDomicileSelect()"/>
								<input type="text" id="domicileCode" name="carCode" style="display: none"/>
					        </td>
					        <td class="FieldLabel" nowrap="nowrap" width="8%">低保证号</td>
					        <td class="FieldInput" width="25%">
					        	<input id="cardNo" name="cardNo" style="width:150"/>
					        </td>
					    	<td class="FieldLabel" nowrap="nowrap" width="8%">户主姓名</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" name="familyName" id="familyName"/>
					        </td>
							<td class="FieldButton" width="8%">
								<button onclick="query()" id="queryBtn">查 询</button>
							</td>
					    </tr>
					    <tr>
					        <td class="FieldLabel" nowrap="nowrap" width="8%">身份证号码</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" name="familyCardNo" id="familyCardNo"  style="width:150"/>
					        </td>
					     	<td class="FieldLabel" nowrap="nowrap" width="8%">保障人口数</td>
					        <td class="FieldInput" width="25%">
								<input type="text" id="sAssitancePeopleNum" name="sAssitancePeopleNum" style="width:68"/>
						        ~
						       	<input type="text" id="eAssitancePeopleNum" name="eAssitancePeopleNum" style="width:68"/>
					        </td>
                            <td class="FieldLabel" nowrap="nowrap" width="8%">享受保障年月</td>
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
<next:GridPanel id="editGridPanel" width="100%" stripeRows="true" height="100%" dataset="baseinfoFamilyDS"  notSelectFirstRow="true" clickToSelectedForChkSM="true"  autoScroll="true" collapsible="true" autoWidth="true" >
    <next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="低保家庭查询信息"></next:ToolBarItem>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem text="确认增加" iconCls="edit" handler="add" />
        <next:ToolBarItem text="关闭" iconCls="remove" handler="closeWin" />
    </next:TopBar>
    <next:Columns>
        <next:RowNumberColumn width="30"/>
        <next:CheckBoxColumn></next:CheckBoxColumn>
        <next:Column id="TREATMENT_ID" header="家庭ID" field="TREATMENT_ID" hidden="true" align="center"/>
        <next:Column id="FAMILY_ID" header="家庭ID" field="FAMILY_ID" hidden="true" align="center"/>
        <next:Column id="DOMICILE_CODE" header="地区" field="DOMICILE_NAME" width="10%" align="center" />
        <next:Column id="FAMILY_NAME" header="户主姓名" field="FAMILY_NAME" width="10%" align="center" />
        <next:Column id="FAMILY_CARD_NO" header="身份证号" field="FAMILY_CARD_NO" width="17%" align="center"/>
        <next:Column id="ASSISTANCE_PEOPLE_NUM" header="保障人口数" field="ASSISTANCE_PEOPLE_NUM" width="10%" align="right" />
        <next:Column id="MONTH_AVERAGE_INCOME" header="人均收入" field="MONTH_AVERAGE_INCOME" width="10%" align="right" renderer="formatMoney"/>
        <next:Column id="ASSISTANCE_MONEY" header="户月保障金" field="ASSISTANCE_MONEY" width="10%" align="right"  renderer="formatMoney"/>
        <next:Column id="ASSISTANCE_CLASS" header="分类施保类别" field="ASSISTANCE_CLASS" width="10%" align="center" dataset="assistanceDs"/>
        <next:Column id="ASSISTANCE_CLASS_MONEY" header="分类施保金" field="ASSISTANCE_CLASS_MONEY" width="10%" align="right" renderer="formatMoney" />
    </next:Columns>
    <next:BottomBar>
        <next:PagingToolBar dataset="baseinfoFamilyDS" />
    </next:BottomBar>
</next:GridPanel>
</body>
</html>
