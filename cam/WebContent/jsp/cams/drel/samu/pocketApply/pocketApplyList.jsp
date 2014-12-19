<%@page import="com.inspur.cams.comm.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>零花钱发放</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="pocketApplyList.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
        <script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
	        var organId = '<%=BspUtil.getCorpOrganId()%>';
		    var applyType='<%=request.getParameter("applyType")%>';	 
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
			String organCode=BspUtil.getCorpOrgan().getOrganCode();//用于行政区划过滤
			if(organCode.endsWith("0000000000")){//省370000000000
				organCode= organCode.substring(0,2);
			} else if (organCode.endsWith("00000000")){//市370100000000
				organCode=  organCode.substring(0,4);
			} else if (organCode.endsWith("000000")){//县370104000000
				organCode=  organCode.substring(0,6);
			} else if (organCode.endsWith("000")){//乡370104003000
				organCode=  organCode.substring(0,9);
			}
	    	%>
	     	var organCode='<%=organCode%>';
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';   
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
     <!-- 敬老院业务主表 -->
	<model:dataset id="geroApplyDs" cmd="com.inspur.cams.drel.samu.cmd.SamGeroApplyQueryCmd" method="queryMoneryList" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroApply">
		<model:field name="GEROCOMIUM_ID" />
		<model:field name="GEROCOMIUM_NAME" />
        <model:field name="POCKET_YM"/>
        <model:field name="POCKET_STATUS"/>
        <model:field name="TOTAL_NUM"/>
        <model:field name="APPLY_MONEYNUM"/>
		</model:record>
	</model:dataset>	
	<!--业务类型 -->
	<model:dataset id="applyTypeDS" enumName="SAM_APPLY_TYPE" autoLoad="true" global="true"></model:dataset>
	<!--零花钱发放确认状态 -->
	<model:dataset id="pocketStatusDS" enumName="SAM_POCKET_STATUS" autoLoad="true" global="true"></model:dataset>
	<!--服装发放确认状态-->
	<model:dataset id="clothStatusDS" enumName="SAM_CLOTH_STATUS" autoLoad="true" global="true"></model:dataset>
    <!--服装类型 -->
	<model:dataset id="clothTypeDS" enumName="SAM_CLOTH_TYPE" autoLoad="true" global="true"></model:dataset>
    <!-- 敬老院下拉框选项 -->
	<model:dataset id="samGeroDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_GEROCOMIUM_INFO'></model:param>
			<model:param name="value" value='GEROCOMIUM_ID'></model:param>
			<model:param name="text" value='GEROCOMIUM_NAME'></model:param>
		</model:params>
	</model:dataset>	
	
  
	<!-- 供养对象信息表 -->
    <model:dataset id="keptPersonDs" cmd="com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonQueryCmd" global="true">
        <model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroKeptPerson">
        </model:record>
    </model:dataset>
   
	<!-- 敬老院基础信息 -->
    <model:dataset id="geroComiumInfoDs" cmd="com.inspur.cams.drel.samu.cmd.SamGerocomiumInfoQueryCmd" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.drel.samu.data.SamGerocomiumInfo"></model:record>
    </model:dataset>   
</model:datasets>  

<next:Panel  name="form" width="100%%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form" id="queryForm">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" style="width:15%">敬老院名称</td>
								<td class="FieldInput" style="width:18%"><input type="text" id="gerocomiumNameQuery" style="width:80%"/><img
									src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand" onclick="func_ForGeroSelect()" /> <input
									type="text" id="gerocomiumIdQuery" name="gerocomiumIdQuery" 
									style="display: none" /></td>
								<td class="FieldLabel" style="width: 15%">发放年月:</td>
								<td class="FieldInput" style="width: 18%"><input type="text"  id="pocketYmQuery" onclick="setmonth(this)" style="width: 80%" readonly="readonly"  /></td>	
								
								<td class="FieldButton" style="width: 15%" ><button onclick="query()" id="queryBtn">查 询</button>&nbsp;&nbsp;<button type="reset">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="samreleasesummaryGrid" title="零花钱发放名册列表" width="100%" stripeRows="true"  
				notSelectFirstRow="true" clickToSelectedForChkSM="true" height="100%" dataset="geroApplyDs"  >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="登记名册" iconCls="add" handler="openApplyWin" id="inserButton"/>
		<next:ToolBarItem text="维护名册" iconCls="edit" handler="chooseAssPeople" id="editButton"/>
		<next:ToolBarItem text="确认名册" iconCls="select" handler="confirmApply" id="confirmButton"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" id="delButton"/>
	</next:TopBar>
	
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="敬老院名称" field="GEROCOMIUM_NAME" width="15%" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column  header="发放年月" field="POCKET_YM" width="10%" align="center" renderer="detailRender">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="applyPeopleNum" header="发放总人数" field="TOTAL_NUM" width="100" align="right">
            <next:NumberField  />
        </next:Column>
		<next:Column  header="发放总额（元）" field="APPLY_MONEYNUM" width="10%"   renderer="formatMoney" align="right">
			<next:NumberField allowBlank="false" />
		</next:Column>
		<next:Column id="applyStatus" header="发放确认状态" field="POCKET_STATUS" width="10%" dataset="pocketStatusDS"  align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		</next:Columns>
	
	<next:BottomBar>
		<next:PagingToolBar dataset="geroApplyDs"/>
	</next:BottomBar>
</next:GridPanel>

<next:Window id="applyWin" title="登记名册" closeAction="hide"  width="540" modal="true">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="save" text="保存" handler="saveApply" ></next:ToolBarItem>
        <next:ToolBarItem iconCls="return" text="关闭" handler="closeApplyWin"></next:ToolBarItem>
    </next:TopBar>
    <next:Html>
        <form   onsubmit="return false"  class="L5form">
            <table width='100%'>
                <tr>
            <td class="FieldLabel" id="valueLabel" style="width:18%;">敬老院</td>
                    <td class="FieldInput" style="width:15%"><select
					id="gerocomiumName" name="敬老院" title="敬老院" style="width:80%"onchange="testCheck()">
					<option dataset="samGeroDataSet"></option>
					</select></td>
            
                    <td class="FieldLabel" style="width:18%">发放年月</td>
                    <td class="FieldInput"style="width:15%" >
                        <input type="text" name="发放日期"  id="pocketYm" style="width:80%" onclick="setmonth(this)" readonly/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td class="FieldLabel" style="width:100;display:none">发放确认状态</td>
                    <td class="FieldInput"style="width:100;display:none">
                        <select id="pocketStatus" name="发放确认状态">
                            <option dataset="pocketStatusDS"/>
                        </select>
                    </td>
                    <td class="FieldLabel" style="width:18%;">发放金额（元）</td>
                    <td class="FieldInput" style="width:15%"  >
                        <input type="text" name="发放金额"  id="pocketMoney" style="width:80%" />
                        <font color="red">*</font>
                    </td>
                </tr>
               
            </table>
        </form>
   </next:Html>
</next:Window>



</body>
</html>
