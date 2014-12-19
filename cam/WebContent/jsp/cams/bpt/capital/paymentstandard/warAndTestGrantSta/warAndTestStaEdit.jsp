<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<title>参战参核退役人员生活补助标准</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="../../../comm/bptComm.js"></script>
		<script type="text/javascript" src="warAndTestStaEdit.js"></script>
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
			var method = '<%=request.getParameter("method")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var startDate = '<%=request.getParameter("startDate")%>';
			var organType = '<%=BspUtil.getOrganType()%>';
		</script>
	</head>
<body>
<model:datasets>
	<!-- 标准ds -->
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalstaQueryCommand" method="standardDatasetQuery" global="true" pageSize="500">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalsta">
			<model:field name="yearTotal"/>
			<model:field name="subTotal"/>
		</model:record>
	</model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 参战&参试 -->
	<model:dataset id="WarAndTestEnum" enumName="WAR.TEST" autoLoad="true" global="true" ></model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
					<div>
						<form style="width:100%; height: 100%;" class="L5form">
							<table border="0" width="100%">
								<tr>
									<td class="FieldLabel">生效日期:</td>
									<td class="FieldInput"><input type="text" id="startDate" class="TextEditor" title="生效日期"  format="Y-m-d" style="width: 100px;" maxlength="10";" onpropertychange="changeDateStyle(this)" /><img id="dateSelect" src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
									<td class="FieldLabel" style="text-align: left">标准类型：年标准&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;单位：元</td>
								</tr>
							</table>
						</form>
					</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="editGridPanel" name="bptcapitalstaGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="伤残抚恤金标准">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="add" text="增加" handler="insert"/>
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"/>
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="返回" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="objectType" header="优抚对象类别" field="objectType" width="150">
			<next:ComboBox dataset="WarAndTestEnum"/>
		</next:Column>
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="95">
			<next:ComboBox dataset="DomicileDataset"/>
		</next:Column>
		<next:Column id="provinceStandard" header="省标准" field="provinceStandard" width="95" renderer="formatNum(this)" align="right" >			
			<next:NumberField />
		</next:Column>
		<next:Column id="subTotal" header="小计" field="subTotal" width="95" editable="false" renderer="formatNum(this)" align="right">			
		</next:Column>
		<next:Column id="increaseMechanism" header="自然增长机制" field="increaseMechanism" width="95" renderer="formatNum(this)" align="right">			
			<next:NumberField />
		</next:Column>
		<next:Column id="grainOilMon" header="粮油补贴" field="grainOilMon" width="95" renderer="formatNum(this)" align="right">			
			<next:NumberField/>
		</next:Column>
		<next:Column id="oldLonelyMon" header="孤老增发" field="oldLonelyMon" width="95" renderer="formatNum(this)" align="right">			
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyOne" header="其他补助1" field="otherSubsidyOne" width="95" renderer="formatNum(this)" align="right">			
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyTwo" header="其他补助2" field="otherSubsidyTwo" width="95" renderer="formatNum(this)" align="right">			
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyThree" header="其他补助3" field="otherSubsidyThree" width="95" renderer="formatNum(this)" align="right">			
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyFour" header="其他补助4" field="otherSubsidyFour" width="95" renderer="formatNum(this)" align="right">			
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyFive" header="其他补助5" field="otherSubsidyFive" width="95" renderer="formatNum(this)" align="right">			
			<next:NumberField/>
		</next:Column>
		<next:Column id="yearTotal" header="" field="yearTotal" width="95" editable="false" renderer="formatNum(this)" align="right">			
			<next:NumberField/>
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="150" valueTip="true">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:2,colspan:3},{header:'地方补贴',start:5,colspan:9},{header:'年合计',start:14,colspan:1}]]
    		})
	</next:ExtendConfig>
</next:EditGridPanel>
</body>
</html>
