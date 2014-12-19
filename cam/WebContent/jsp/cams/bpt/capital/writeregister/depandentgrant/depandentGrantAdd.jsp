<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>三属定期抚恤金发放名册添加</title>
		<next:ScriptManager/>
		<script language="javascript">
			var struId = '<%=BspUtil.getStruId()%>';
   			var organCode = '<%=BspUtil.getOrganCode()%>';
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
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
	    <script type="text/javascript" src="../../common/comm.js"></script>
		<script type="text/javascript" src="../../../comm/bptComm.js"></script>
		<script type="text/javascript" src="depandentGrantAdd.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalDetailQueryCommand" global="true" pageSize="500">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalDetail"></model:record>
	</model:dataset>
	<!-- 发放类别 -->
	<model:dataset id="GrantTypeDataset" enumName="GRANTTYPE.FLAG" autoLoad="true" global="true"></model:dataset>
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="dsLoneFlag" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>  
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr>
								<td class="FieldLabel">生成日期：</td>
								<td class="FieldInput"><input type="text" id="buildDate" class="TextEditor" style="width:80" format="Y-m-d" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
							    <td class="FieldLabel">应发时间起：</td>
								<td class="FieldInput"><input type="text" id="startDate" class="TextEditor" style="width:80" format="Y-m" maxlength="7" onpropertychange="changeDateStyle_Mon(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
							    <td class="FieldLabel">应发时间止：</td>	
								<td class="FieldInput"><input type="text" id="endDate" class="TextEditor" format="Y-m" style="width:80"  maxlength="7" onpropertychange="changeDateStyle_Mon(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>								
								<td class="FieldInput" colspan="4" align="center"><button onclick="query()">生成明细</button></td>		
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="editGridPanel" name="bptcapitaldetailGrid" width="100%" stripeRows="true" height="100%" dataset="ds">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="disable"  text="关闭" handler="func_close"/>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="40" header="序号"/>
		<next:Column id="registerId" header="名册ID" field="registerId"
			width="90" hidden="true"></next:Column>
		<next:Column id="domicileName" header="户籍地" field="domicileName"
			width="230"></next:Column>
		<next:Column id="name" header="姓名" field="name" width="50"></next:Column>
		<next:Column id="idCord" header="身份证号" field="idCord" width="135"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode"
			width="170"></next:Column>
		<next:Column id="credentialsNo" header="优抚证号" field="credentialsNo"
			width="90"></next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType"
			width="130" dataset="DependantTypeDataset"></next:Column>
		<next:Column id="changeState" header="发放类别" field="changeState"
			width="130" dataset="GrantTypeDataset"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag"
			width="60" dataset="dsLoneFlag"></next:Column>
		<next:Column id="grantStaMon" header="省标准" field="grantStaMon" hidden="true"
			renderer="formatNum(this)" width="80" align="right">
			<next:NumberField></next:NumberField>
		</next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths"
			width="80" align="right">
			<next:NumberField></next:NumberField>
		</next:Column>
		<next:Column id="grantMon" header="发放金额" field="grantMon"
			renderer="formatNum(this)" width="80" align="right">
			<next:NumberField></next:NumberField>
		</next:Column>
		<next:Column id="subTotal" header="地方补贴小计" field="subTotal"
			renderer="formatNum(this)" width="120" align="right">
			<next:NumberField></next:NumberField>
		</next:Column>
		<next:Column id="increaseMechanism" header="自然增长机制"
			field="increaseMechanism" renderer="formatNum(this)" width="120"
			align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="grainOilMon" header="粮油补贴" field="grainOilMon"
			renderer="formatNum(this)" width="80" align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="oldLonelyMon" header="孤老增发" field="oldLonelyMon"
			renderer="formatNum(this)" width="80" align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="supplyMon" header="补发金额" field="supplyMon"
			renderer="formatNum(this)" width="80" align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyOne" header="其他补助1"
			field="otherSubsidyOne" renderer="formatNum(this)" width="80"
			align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyTwo" header="其他补助2"
			field="otherSubsidyTwo" renderer="formatNum(this)" width="80"
			align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyThree" header="其他补助3"
			field="otherSubsidyThree" renderer="formatNum(this)" width="80"
			align="right">
			<next:NumberField/>	
		</next:Column>
		<next:Column id="otherSubsidyFour" header="其他补助4"
			field="otherSubsidyFour" renderer="formatNum(this)" width="80"
			align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyFive" header="其他补助5"
			field="otherSubsidyFive" renderer="formatNum(this)" width="80"
			align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="grantMonSum" header="发放资金总额" field="grantMonSum"
			renderer="formatNum(this)" width="80" align="right">
			<next:NumberField/>	
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="200">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
