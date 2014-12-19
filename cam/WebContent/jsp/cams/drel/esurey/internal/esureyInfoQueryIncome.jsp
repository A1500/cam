<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>核对明细查询</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="esureyInfoQueryIncome.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
			 var struId='<%=BspUtil.getStruId()%>';
		     var organId='<%=BspUtil.getCorpOrganId()%>';
		     var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		    
	 	     //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){	
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';	
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";				
					element.expand =true;
				}
			}
		</script>

	</head>
	
<body>
<model:datasets>
    <model:dataset id="EsureyFamilyDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd" method="queryIncomeWorth">
	</model:dataset>	
	<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"  global="true"></model:dataset>	
	<!-- 救助类型 -->	
	<model:dataset id="assistanceTypeDS" enumName="ASSISTANCE_TYPE"  autoLoad="true" global="true"></model:dataset>	
</model:datasets>
<next:Panel name="esurey_info" width="100%"  >
	<next:Html>
	<fieldset >
		<legend>查询条件
		<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this);"/>										
		</legend>
			<div>
				<form  class="L5form">
						<table width="100%" >
							<tr>
								<td class="FieldLabel" width="10%"><label>行政区划:</label></td>
								<td class="FieldInput" width="15%"><input type="text"  id="qArea" onclick="func_ForDomicileSelect()" style="width:90%"/></td>	
								<td class="FieldLabel" width="15%"><label>汇总审核时间:</label></td>
								<td class="FieldInput" width="30%"><input type="text"  id="qDateBegin" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" />---<input type="text"  id="qDateEnd" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/>
								</td>
								<td class="FieldButton" width="10%"><button onclick="query();">查 询</button></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>救助类型:</label></td>
								<td class="FieldInput"><select id="qAssistance" style="width:90%"><option dataset="assistanceTypeDS"></option></select></td>					
								<td class="FieldLabel"><label>收入范围(/元):</label></td>
								<td class="FieldInput" ><input type="text"  id="qIncomeBegin"   />---<input type="text"  id="qIncomeEnd" />
								</td>
								<td class="FieldLabel"></td>	
							</tr>
							<tr>
								<td class="FieldLabel"><label>家庭性质:</label></td>
								<td class="FieldInput"><select  id="qDomicleType" style="width:90%" ><option dataset="familyTypeDS"></option></select></td>
								<td class="FieldLabel"><label>家庭财产范围(/元):</label></td>
								<td class="FieldInput" ><input type="text"  id="qEsureyBegin"   />---<input type="text"  id="qEsureyEnd" />
								</td>
								<td class="FieldButton" ><button type="reset">重 置</button></td>	
							</tr>
							<tr>
								<td class="FieldInput" colspan="5"><font color="red" size="2">*说明:行政区划,救助类型,家庭性质为必填项;收入范围和家庭财产范围不能同时为空</font></td>
							</tr>
						</table>
						<input type="hidden" id="qAreah"/>
					</form>
				</div>	
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="esurey_Grid" name="esurey_Grid"  dataset="EsureyFamilyDS"  title="收入及财产统计" stripeRows="true" autoScroll="true" collapsible="true"  width="100%" height="99.9%">
	<next:Columns>
	     <next:RowNumberColumn width="10"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="FAMILY_ADDRESS" header="行政区划" field="FAMILY_ADDRESS" width="12%" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="APPLY_NUM" header="申报数量" field="APPLY_NUM" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column id="CHECK_NUM" header="汇总审核数量" field="CHECK_NUM" width="15%"  >
			<next:TextField />
		</next:Column>
		<next:Column id="ASSISTANCE_TYPE" header="救助类型" field="ASSISTANCE_TYPE"  dataset="assistanceTypeDS" width="10%"  >
			<next:TextField />
		</next:Column>
		<next:Column id="INCOME_NUM" header="平均收入" field="INCOME_NUM" width="9%"  >
			<next:TextField />
		</next:Column>
		<next:Column id="WORTH_NUM" header="平均财产" field="WORTH_NUM" width="9%"  >
			<next:TextField />
		</next:Column>
		<next:Column id="QWORTHIN_NUM" header="收入及财产符合范围数量" field="QWORTHIN_NUM" width="20%"  >
			<next:TextField />
		</next:Column>
		<next:Column id="WORTHIN_RATE" header="收入及财产符合率" field="WORTHIN_RATE" width="15%"  >
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="EsureyFamilyDS" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>