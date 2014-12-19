<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>除义务兵家庭外其他优抚对象优待金发放添加</title>
		<next:ScriptManager/>
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
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var struId='<%=BspUtil.getStruId()%>';
            var organType='<%=BspUtil.getOrganType()%>';
		</script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="nonCompulsoryGrantAdd.js"></script>
		 <script type="text/javascript" src="../../../comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="NonCompulsoryDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsQueryCommand" method="queryCompulsoryUpdate" pageSize="500" global="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCompulsoryDetails">
			<model:field name="domicileCode" type="string"/>
			<model:field name="domicileName" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="accountCode" type="string"/>
			<model:field name="domicileType" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 优抚对象类别 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileTypeEnum" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否孤老 -->
	<model:dataset id="LoneIfEnum" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>
	<!-- 供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="99%" >
							<!--<tr>
								<td class="FieldLabel">所属机构 :</td>
								<td class="FieldInput"><input type="text"  id="organId" style="width:40%" class="TextEditor" title="所属机构" onclick="help()"/></td>	
								<td class="FieldLabel">所属年度 :</td>
								<td class="FieldInput"> 
									  <select id="startYear">
									     <option dataSet="dsYear"/>
									  </select>
							    </td>
						   </tr>
						   --><tr>
						   		<td class="FieldLabel">生成日期</td>
								<td align="left"><input type="text"  id="generateDate" class="TextEditor" style="width:80" format="Y-m-d" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
						        <td class="FieldLabel">应发时间(起)：</td>
								<td class="FieldInput"><input type="text"  id="shouldTimeStart" class="TextEditor" style="width:80" format="Y-m" maxlength="7" onpropertychange="changeDateStyle_Mon(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
								(止)：<input type="text"  id="shouldTimeEnd" class="TextEditor" format="Y-m" style="width:80"  maxlength="7" onpropertychange="changeDateStyle_Mon(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
								<td align="left"><button onclick="query()">生成明细</button> </td>
						   </tr>	
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="editGridPanel" name="bptcompulsorydetailsGrid" width="100%" stripeRows="true" height="100%" dataset="NonCompulsoryDataset" autoExpandColumn="note">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="save"/>
		<next:ToolBarItem iconCls="disable"  text="关闭" handler="fun_close"/>
    </next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="40" header="序号"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="domicileName" header="户籍地" field="domicileName" sortable="true"></next:Column>   
		<next:Column id="name" header="姓名" field="name" width="90"  sortable="true"></next:Column>
		<next:Column id="idCard" header="身份证号" field="idCard" width="140"  sortable="true"></next:Column>
		<next:Column id="objectTypeCode" header="优抚对象类别" field="objectTypeCode" width="130" dataset="ObjectTypeDataset" sortable="true"></next:Column>
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="90" sortable="true" dataset="DomicileTypeEnum"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag" width="90" sortable="true" dataset="LoneIfEnum"></next:Column>
		<next:Column id="supportPattern" header="供养方式" field="supportPattern" width="90" sortable="true" dataset="SupportPatternEnum"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode" width="140" sortable="true"></next:Column>
		<next:Column id="grantMonSta" header="发放标准" field="grantMonSta" width="90" align="right" renderer="formatNum(this)" sortable="true"></next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths" width="80" editable="false"></next:Column>
		<next:Column id="oldLonelyMon" header="孤老增发" field="oldLonelyMon" width="90" renderer="formatNum(this)" align="right" sortable="true"></next:Column>
		<next:Column id="otherSubsidyOne" header="其他补助1" field="otherSubsidyOne" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyTwo" header="其他补助2" field="otherSubsidyTwo" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyThree" header="其他补助3" field="otherSubsidyThree" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyFour" header="其他补助4" field="otherSubsidyFour" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyFive" header="其他补助5" field="otherSubsidyFive" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="grantMonSum" header="发放总额" field="grantMonSum" renderer="formatNum(this)" width="90" align="right" sortable="true">
			<next:NumberField/>
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="90" sortable="true">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="NonCompulsoryDataset"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>