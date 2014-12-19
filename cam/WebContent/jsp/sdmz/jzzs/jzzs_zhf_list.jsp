<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.sdmz.comm.util.BspUtil"%>
<%
String organArea = BspUtil.getCorpOrgan().getOrganCode().substring(0,6);
String organArea1 = BspUtil.getCorpOrgan().getOrganCode();
String sign=null;
if(organArea1.substring(4,12).equals("00000000"))
{
	organArea1=organArea1.substring(0,4);
	sign="1";
}
%>
<html>
<head>
<title>阳光救助_住房救助指数</title>
<next:ScriptManager />
<script type="text/javascript" src="jzzs_list.js"></script>
<script type="text/javascript" src="IDCard.js"></script>
<script type="text/javascript" src="jtxxComm.js"></script>
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
			var organArea1 = "<%=organArea1%>";
			var organArea2 = "<%=organArea%>"+"000000";
			var sign = "<%=sign%>";
		</script>
</head>
<body>
<model:datasets>
		<!-- 行政区划 -->
	<model:dataset id="DmXzqhDataSetStreet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetQu" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
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
		<!-- 救助类型 -->
	 <model:dataset id="DmJzlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" pageSize="20" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
		<!-- 住房类型 -->
	 <model:dataset id="DmZfzklxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_QUALITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 房屋状况 -->
	 <model:dataset id="DmFwjgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STATUS'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住房结构 -->
	 <model:dataset id="DmzfjgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STRUCTURE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ds" cmd="com.inspur.sdmz.jzzs.cmd.JzzsQueryCommand" autoLoad="flase">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form id="queryForm"   style="width: 95%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>	
					 <td class="FieldLabel" nowrap="nowrap" width="10%">区:</td>
					 <td class="FieldInput" width="20%"> <select id="quQuery"  onchange="getDzStreet()">
								<option  dataset="DmXzqhDataSetQu"></option>
							</select>
					 </td>	
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
					 <td class="FieldInput" align="center" width="10%"> 
					   <button onclick="jzzsQuery()">查 询</button>
				    </td>
			  </tr>
	          <tr>	
	          		  <td class="FieldLabel" width="10%">户主姓名:</td>
					<td class="FieldInput" width="20%"><input type="text"  id="hzxm" name="hzxm" maxlength="25" class="TextEditor" style="width:90%"/></td>
	          		<td class="FieldLabel" width="10%">户主身份证:</td>
					<td class="FieldInput" width="20%"><input type="text" style="width:90%" id="sfzh" name="sfzh" maxlength="18"  class="TextEditor"/></td>
	               <td class="FieldLabel" nowrap width="10%">救助类型:</td>
			       <td class="FieldInput"  width="20%"><input type="text" id="jzlxDisplay" style="width:65%" readOnly="true" ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="mutiHelp('DmJzlxDataSet','jzlxDisplay','jzlxquery')"/>
								    <input type="hidden" id="jzlxquery" name="jzlxquery">
			        </td>		
			        <td class="FieldInput" align="center"> 
				       <button onclick="reset();" >重 置</button>
				    </td>
			</tr>
			<tr>
				<td class="FieldLabel">住房类型：</td>
				<td class="FieldInput"><select id="houseQuality"
					name="住房类型" field="houseQuality" style="width:75%" >
					<option dataset="DmZfzklxDataSet"></option>
				</select></td>
				<td class="FieldLabel" id="fwzk">房屋状况：</td>
				<td class="FieldInput"><select name="houseStatus" id="houseStatus"
					field="houseStatus" style="width:75%" >
					<option dataset="DmFwjgDataSet"></option>
				</select></td>
				<td class="FieldLabel">住房结构:</td>
				<td class="FieldInput"><select name="buildingStructure" id="buildingStructure"
					field="buildingStructure" style="width:75%" >
					<option dataset="DmzfjgDataSet"></option>
				</select></td>
				 <td class="FieldInput"></td>
			</tr>
			<input type="hidden"  name="hzxm" id="hzxm"/> 
			<input type="hidden"  name="sfzh" id="sfzh"/> 
			<input type="hidden"  name="sgzlquery" id="sgzlquery"/> 
			<input type="hidden"  name="sgssquery" id="sgssquery"/> 
			<input type="hidden"  name="jyzk" id="jyzk"/> 
			<input type="hidden"  name="zhzl" id="zhzl"/> 
			<input type="hidden"  name="zhssje" id="zhssje"/> 
			<input type="hidden"  name="cjlx" id="cjlx"/> 
			<input type="hidden"  name="cjdj" id="cjdj"/> 
			<input type="hidden"  name="hbzl" id="hbzl"/> 
			<input type="hidden"  name="ylzc" id="ylzc"/> 
			<input type="hidden"  name="sylv" id="sylv"/> 
			<input type="hidden"  name="ylnl" id="ylnl"/>
			<input  type="hidden" id="houseQuality"  name="houseQuality"/>
		    <input  type="hidden" id="houseStatus"  name="houseStatus"/>
		    <input  type="hidden" id="buildingStructure"  name="buildingStructure"/> 
		    <input type="hidden"  name="jzfx" id="jzfx" value="ZF"/>
		  </table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="100%" notSelectFirstRow="true" stripeRows="true" height="330" dataset="ds" title="困难户家庭住房救助指数">
	<next:TopBar>
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="JzzsZhfExcel" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column id="JTID"  header="家庭ID" field="JTID" hidden="true" align="center" width="90"/>
		<next:Column id="HZXM"  header="户主" field="HZXM" width="60" align="center"  />
		<next:Column id="SFZH"  header="身份证号" field="SFZH" width="140" align="center"  />
		<next:Column id="RK_SL" header="人口数量" field="RK_SL" width="80" align="center"/>
	    <next:Column id="JTCY"  header="家庭成员" field="JTCY" width="120" align="left"/>
	    <next:Column id="JTDZ"  header="家庭地址" align="left" width="250" field="JTDZ" />
	    <next:Column id="JZLX"  header="受助类型" align="left" width="250" field="JZLX" renderer="szlxRef"/>
	    <next:Column id="HOUSE_QUALITY"  header="住房类型" align="left" width="80" field="HOUSE_QUALITY" renderer="zfzkRef"/>
		<next:Column id="JZZS_ZF" header="救助指数" field="JZZS_ZF" width="90" align="right"/>
		<next:Column id="JZQK"  header="一年内受助情况(元/次)" field="JZQK" width="140" align="center"/>
		</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
