<%@page import="com.inspur.cams.comm.extuser.util.CamsExtLoginServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
	String assistanceType = request.getParameter("assistanceType");
	String incomeName="";
	String incomeField="";
	if("01".equals(assistanceType)){
		incomeName="人均月收入（元）";
		incomeField="MONTH_AVERAGE_INCOME";
	}else if("02".equals(assistanceType)||"03".equals(assistanceType)){
		incomeName="人均年收入（元）";
		incomeField="YEAR_AVERAGE_INCOME";
	}
%>
<html>
<head>
<title>保障金调整</title>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="samTreatmentAdjustList.js"></script>

<script language="javascript">
  //查询条件打开合并函数
 var organArea='<%=organArea%>';
 var assistanceType='<%=assistanceType%>';
 var organName = '<%=organName%>';
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
    <!-- 救助待遇基本信息 -->
    <model:dataset id="treamentLisDs" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyTreatmentQueryCmd"  method="queryAdjustList" global="true"  pageSize="20">
        <model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyTreatment" />
    </model:dataset>
    <model:dataset id="treamentDs" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyTreatmentQueryCmd"  method="queryAdjustList" global="true"  pageSize="20">
        <model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyTreatment" />
    </model:dataset>
	<!-- 分类施保类别 -->
	<model:dataset id="asisstanceClassDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
			<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
			<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="samLowStandardsDataset" cmd="com.inspur.cams.drel.esurey.cmd.SamLowStandardsQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamLowStandards"></model:record>
		<model:params>
		    <model:param name="DOMICILE_CODE" value='<%=BspUtil.getOrganCode().substring(0,6)+"000000"%>' />
		    <model:param name="ASSITANCE_TYPE" value="<%=assistanceType%>" />
		    <model:param name="VALID_BEGIN_DATE" value="<%=DateUtil.getMonth()%>" />
		    <model:param name="IN_USE" value="1" />
		</model:params>
	</model:dataset>
    <model:dataset id="samTreatmentAdjustDataset" cmd="com.inspur.cams.drel.sam.cmd.SamTreatmentAdjustQueryCmd" global="true" sortField="ADJUST_TIME" sortDirection="desc">
        <model:record fromBean="com.inspur.cams.drel.sam.data.SamTreatmentAdjust" />
    </model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form id="queryForm"   style="width: 100%; height: 100%;" class="L5form">
		<table border="1" style="width:100%;table-layout:fixed;">
			<tr>
				<td class="FieldLabel" width="10%" nowrap="nowrap">地区</td>
				<td class="FieldInput" width="20%" nowrap="nowrap">
					<input type="text" style="width: 60%" readonly name="lrdwmc" id="lrdwmc" />
					<input type="text" style="display: none;" name="lrdwId" id="lrdwId" value='<%=organArea %>' /> 
					<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor: hand" onclick="func_ForDomicileSelect()" />
				</td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">户主姓名</td>
				<td class="FieldInput" width="16%" nowrap="nowrap">
					<input type="text" id="familyName" name="familyName" maxlength="25" class="TextEditor" title="户主姓名" style="width: 90%" />
				</td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">户主身份证</td>
				<td class="FieldInput" width="17%" nowrap="nowrap">
					<input type="text" id="familyCardNo" name="familyCardNo" maxlength="18" class="TextEditor" title="户主身份证" style="width: 90%" />
				</td>

				<td width="10%" class="FieldButton" nowrap="nowrap">
					<button id="queryBtn" onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="10%" nowrap="nowrap">户月保障金</td>
				<td class="FieldInput" colspan="1" nowrap="nowrap">
					<input type="text" id="assistanceMoneyStart" name="assistanceMoneyStart" style="width: 35%" /> 
					----- 
					<input type="text" id="assistanceMoneyEnd" name="assistanceMoneyEnd" style="width: 35%" />
				</td>

				<td class="FieldLabel" nowrap width=10%>保障人口数</td>
				<td class="FieldInput" colspan="1" nowrap="nowrap">
					<input type="text" id="assistancePeopleNumStart" style="width: 36.5%" />
					----- 
					<input type="text" id="assistancePeopleNumEnd" style="width: 36.5%" />
				</td>
				<td class="FieldLabel" width="10%" nowrap="nowrap"></td>
				<td class="FieldInput" colspan="1" nowrap="nowrap"></td>
				<td class="FieldButton" nowrap="nowrap">
					<button onclick="reset()">重 置</button>
				</td>
			</tr>

		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" width="100%" stripeRows="true" height="100%" dataset="treamentLisDs"  title="救助对象列表" autoScroll="true"  
            clickToSelectedForChkSM="true" autoWidth="true" autoHeight="" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="调整选中救助对象" iconCls="edit" handler="adjustSelected" />
		<next:ToolBarItem text="调整所有救助对象" iconCls="select" handler="adjustAll"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
        <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="TREATMENT_ID" header="ID" field="TREATMENT_ID" hidden="true" align="center"/>
		<next:Column id="FAMILY_ID" header="家庭ID" field="FAMILY_ID" hidden="true" align="center"/>
		<next:Column id="DOMICILE_NAME" header="地区" field="DOMICILE_NAME" width="10%" align="center" />
		<next:Column id="FAMILY_NAME" header="户主姓名" field="FAMILY_NAME" width="10%" align="center" />
		<next:Column id="FAMILY_CARD_NO" header="身份证号" field="FAMILY_CARD_NO" width="17%" align="center"/>
		<next:Column id="ASSISTANCE_PEOPLE_NUM" header="保障人口数" field="ASSISTANCE_PEOPLE_NUM" width="10%" align="center"/>
	    <next:Column id="<%=incomeField %>" header="<%=incomeName %>" field="<%=incomeField %>" width="10%" align="right" hidden="true"/>
		<next:Column id="ASSISTANCE_MONEY" header="户月保障金（元）" field="ASSISTANCE_MONEY" width="10%" align="right" renderer="formatMoney"/>
		<next:Column id="ASSISTANCE_CLASS" header="分类施保类别" field="ASSISTANCE_CLASS" width="10%" align="right" ><next:ComboBox dataset="asisstanceClassDataset" /></next:Column>
		<next:Column id="ASSISTANCE_CLASS_MONEY" header="分类施保金（元）" field="ASSISTANCE_CLASS_MONEY" width="10%" align="right" renderer="formatMoney"/>
		<next:Column id="ADJUST_DATE" header="调整日期" field="ADJUST_DATE" width="10%" align="center" renderer="getAdjustRecord"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="treamentLisDs" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="adjustWin" title="保障金调整" closeAction="hide"  width="640" modal="true">
    <next:TopBar>
        <next:ToolBarItem symbol="->"/>
        <next:ToolBarItem iconCls="save" text="保存" handler="waitMsg"/>
        <next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"/>
    </next:TopBar>
    <next:Html>
        <form  onsubmit="return false"  class="L5form">
            <table width='100%'>
            	<tr>
            		<td colspan="4">
            		<label style="color:red" id="adjuestLog"></label>
            		</td>
            	</tr>
               <tr>
                  <td class="FieldLabel" style="width:15%"><label>调整对象</label></td>
                  <td class="FieldInput" style="width:35%">
                      <select name="调整对象" id="adjustTarget"  style="width:85%" >   
                          <option value='01'>家庭</option>
                          <option value='02'>保障人口</option>
                      </select><span style="color:red">*</span>
                  </td>
                  <td class="FieldLabel" id="valueLabel" style="width:15%">增加</td>
                  <td class="FieldInput" style="width:35%">
                  	<input type="text" name="计算金额或浮动比例" id="adjustMoney"  style="width:80%" maxlength="14"/>
                 	<span id="valueUnit">元</span> <span style="color:red">*</span>
                  </td>
               </tr>   
            </table>
        </form>
   </next:Html>   
</next:Window>

<next:Window id="adjustRecordWin" title="保障金调整记录" closeAction="hide"  width="800" modal="true">
	<next:GridPanel stripeRows="true" height="330" dataset="samTreatmentAdjustDataset" notSelectFirstRow="true">
	  <next:TopBar>
	        <next:ToolBarItem symbol="->"/>
	        <next:ToolBarItem iconCls="return" text="关闭" handler="closeaAjustRecordWin"/>
	    </next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="30"/>
			<next:Column header="调整类型" field="adjustType" width='100' renderer="getAdjustType" hidden="true"/>
			<next:Column header="调整日期" field="adjustTime" width='100' align="center" renderer="getAdjustTime"/>			
			<next:Column header="调整对象" field="adjustTarget" width='100' renderer="getAdjustTarget" hidden="true"/>
			<next:Column header="调整金额（元）" field="adjustMoney" width='120' align="right" hidden="true" />			
			<next:Column header="调整前金额（元）" field="assistanceBeforeMoney" width='120' align="right" renderer="formatMoney"/>					
			<next:Column header="调整后金额（元）" field="assistanceMoney" width='120' align="right" renderer="formatMoney"/>			
			<next:Column header="调整单位" field="organName" width='150' align="center"/>					
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="samTreatmentAdjustDataset"/>
		</next:BottomBar>
    </next:GridPanel>
</next:Window>
</body>
</html>
