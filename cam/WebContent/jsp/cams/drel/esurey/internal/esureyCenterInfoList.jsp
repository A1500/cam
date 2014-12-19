<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>城乡居民家庭经济状况申报列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="esureyCenterInfoList.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
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
    <model:dataset id="EsureyFamilyDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
      <model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily">
     	 <model:field name="domicileName" type="string"/>
         <model:field name="apanageName" type="string"/>
      </model:record>
	</model:dataset>
	<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"  global="true"></model:dataset>	
	<!-- 救助类型 -->	
	<model:dataset id="assistanceTypeDS" enumName="ASSISTANCE_TYPE"  autoLoad="true" global="true"></model:dataset>		
	<model:dataset id="curDS" enumName="ESUREY.CUR_ACTIVITY" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="curStatusDS" enumName="CUR_STATUS"  autoLoad="true" global="true"></model:dataset>
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
								<td class="FieldLabel"><label>户主姓名:</label></td>
								<td class="FieldInput"><input type="text"  id="qName"/></td>					
								<td class="FieldLabel"><label>身份证号:</label></td>
								<td class="FieldInput"><input type="text"  id="qIdCard" style="width:140" /></td>		
								<td class="FieldButton" ><button onclick="query();">查 询</button>&nbsp;<button type="reset">重 置</button> </td>	
							</tr>
						</table>
				</form>
			</div>	
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="esurey_Grid" name="esurey_Grid"   dataset="EsureyFamilyDS" title="城乡居民家庭经济状况申报列表" stripeRows="true" autoScroll="true" collapsible="true"  width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="detail_esurey"></next:ToolBarItem>
		<next:ToolBarItem text="移交" iconCls="detail" handler="submit_esurey"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="20"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="familyId" header="家庭ID" field="familyId" hidden="true" width="10">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyName" header="户主姓名" field="familyName" width="10%"  renderer="FamilyDetailHref">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyCardNo" header="身份证件号码" field="familyCardNo" width="20%">
			<next:TextField />
		</next:Column>
		<next:Column id="peopleNum" header="家庭人数" field="peopleNum" width="8%">
			<next:TextField />
		</next:Column>
		<next:Column id="assistanceType" header="救助类型" field="assistanceType" width="10%" dataset="assistanceTypeDS">
			<next:TextField />
		</next:Column>
		<next:Column id="domicileType" header="家庭性质" field="domicileType" width="10%" dataset="familyTypeDS">
			<next:TextField />
		</next:Column>
		<next:Column id="curActivity" header="当前环节" field="curActivity" width="10%" hidden="true"  dataset="curDS">
			<next:TextField />
		</next:Column>
		<next:Column id="curState" header="当前环节状态" field="curState"  dataset="curStatusDS" hidden="true" width="15%">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="EsureyFamilyDS"  />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>