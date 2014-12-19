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
<title>阳光救助_养老救助指数</title>
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
			<!-- 养老年龄 -->
	<model:dataset id="DmYlnlDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PENSION_AGE'></model:param>
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
				<td class="FieldInput" width="15%"> <select id="quQuery"  onchange="getDzStreet()">
								<option  dataset="DmXzqhDataSetQu"></option>
							</select>
				</td>	
				<td class="FieldLabel" nowrap="nowrap" width="10%">街镇:</td>
				<td class="FieldInput" width="15%">
							<select id="dzZhenquery" onchange="getDzCun()">
								<option dataset="DmXzqhDataSetStreet"></option>
							</select>
				</td>	
				<td class="FieldLabel" nowrap="nowrap" width="10%">村居:</td>
				<td class="FieldInput" width="15%">
							<select id="dzCunquery">
								<option dataset="DmXzqhDataSetVillage"></option>
							</select>
				 </td>
				 <td class="FieldLabel" width="10%">户主姓名:</td>
				<td class="FieldInput" width="16%"><input type="text"  id="hzxm" name="hzxm" maxlength="25" class="TextEditor" style="width:90%"/></td>
			</tr>
			<tr>	
				<td class="FieldLabel" width="10%">户主身份证:</td>
				<td class="FieldInput" width="19%"><input type="text" style="width:90%" id="sfzh" name="sfzh" maxlength="18"  class="TextEditor"/></td>
			    <td class="FieldLabel" nowrap width=90>救助类型:</td>
			    <td class="FieldInput" ><input type="text" id="jzlxDisplay" style="width:70%" readOnly="true" ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="mutiHelp('DmJzlxDataSet','jzlxDisplay','jzlxquery')"/>
								    <input type="hidden" id="jzlxquery" name="jzlxquery">
			    </td>			
			   <td class="FieldLabel" width="10%" nowrap>老人年龄:</td>
			   <td class="FieldInput" width="15%"> <select id="ylnl"> <option dataset="DmYlnlDataSet"></option></select>
		       </td>
		       <td class="FieldInput" COLSPAN="2" align="center"> 
			   <button onclick="jzzsQuery()">查 询</button>
			    <button onclick="reset()" style="margin-left: 15px;">重 置</button>
				</td>
				<input type="hidden"  name="hzxm" id="hzxm"/> 
			 	<input type="hidden"  name="sfzh" id="sfzh"/> 
				 <input  type="hidden" id="zfzklxdm"  name="zfzklxdm"/>
		         <input  type="hidden" id="fwjgdm"  name="fwjgdm"/>
		         <input  type="hidden" id="sgzlquery"  name="sgzlquery"/>
		         <input  type="hidden" id="sgssquery"  name="sgssquery"/>
		         <input  type="hidden" id="jyzk"  name="jyzk"/>
		         <input  type="hidden" id="zhzl"  name="zhzl"/>
		         <input  type="hidden" id="zhssje"  name="zhssje"/>
		         <input  type="hidden" id="cjlx"  name="cjlx"/>
		         <input  type="hidden" id="cjdj"  name="cjdj"/>
		         <input  type="hidden" id="hbzl"  name="hbzl"/>
		         <input  type="hidden" id="ylzc"  name="ylzc"/>
		         <input  type="hidden" id="sylv"  name="sylv"/>
		         <input  type="hidden" id="houseQuality"  name="houseQuality"/>
		    	 <input  type="hidden" id="houseStatus"  name="houseStatus"/>
		    	 <input  type="hidden" id="buildingStructure"  name="buildingStructure"/>
		         <input type="hidden"  name="jzfx" id="jzfx" value="LR"/>
			</tr>
		  </table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="100%" notSelectFirstRow="true" stripeRows="true" height="330" dataset="ds" title="困难户家庭养老救助指数">
	<next:TopBar>
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="JzzsYlaoExcel" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column id="JTID"  header="家庭ID" field="JTID" hidden="true" align="center" width="90"/>
		<next:Column id="HZXM"  header="户主" field="HZXM" width="80" align="center"  />
		<next:Column id="SFZH"  header="身份证号" field="SFZH" width="140" align="center"  />
		<next:Column id="RK_SL" header="人口数量" field="RK_SL" width="80" align="center"/>
	    <next:Column id="JTCY"  header="家庭成员" field="JTCY" width="120" align="left"/>
	    <next:Column id="JTDZ"  header="家庭地址" align="left" width="250" field="JTDZ" />
	    <next:Column id="JZLX"  header="受助类型" align="left" width="200" field="JZLX" renderer="szlxRef"/>
	    <next:Column id="YLXX"  header="老人年龄" align="center" width="80" field="YLXX" />
		<next:Column id="JZZS_LN" header="救助指数" field="JZZS_LN" width="80" align="right"/>
		<next:Column id="JZQK"  header="一年内受助情况(元/次)" field="JZQK" width="140" align="center"/>
		</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
