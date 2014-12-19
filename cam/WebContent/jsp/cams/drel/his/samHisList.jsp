<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<% 
  String assistanceType=request.getParameter("assistanceType");
  String cardNoHeader="低保证号";
  if("03".equals(assistanceType)){
	  cardNoHeader = "五保证号";
  }
  String hideFlag = request.getParameter("hideFlag");
%>
<html>
<head>

<title>历史数据采集</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../comm/samInfoDetailComm.js"></script>
<script type="text/javascript">
    <%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
	var nowMonth= '<%=DateUtil.getMonth()%>';
	var assistanceType='<%=request.getParameter("assistanceType")%>';
	var hideFlag = '<%=hideFlag%>';
	function init(){
		//加载分类施保类别字典
		var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
	    asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE="+assistanceType+" AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");//城市低保
	    asisstanceClassDataset.load();
	    if(organArea.indexOf("000000")<=0){
	        query();
	    }
		document.getElementById("lrdwmc").value=organName;
		document.getElementById("lrdwId").value=organArea;
		
	}
	//新增
	function insert(){
		var width = screen.width-100;
	    var height = screen.height-140;
		var url='';
		if(assistanceType=='01'){
			url='city/samCityHisInsert.jsp';
		}else if(assistanceType=='02'){
			url='country/samCountryHisInsert.jsp';
		}else if(assistanceType=='03'){
			url='five/samFiveHisInsert.jsp';
		}
		url+='?method=insert&familyId=&applyId=&hrefFlg='+getCurrent();
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
	//修改						
	function update(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			var width = screen.width-100;
		    var height = screen.height-140;
			var url='';
			if(assistanceType=='01'){
				url='city/samCityHisInsert.jsp';
			}else if(assistanceType=='02'){
				url='country/samCountryHisInsert.jsp';
			}else if(assistanceType=='03'){
				url='five/samFiveHisInsert.jsp';
			}
			url+='?method=update&familyId='+records[0].get('FAMILY_ID')+'&applyId='+records[0].get('APPLY_ID')+"&hrefFlg="+getCurrent()+"&hideFlag="+hideFlag;
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	//明细
	function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	    return '<a href="javascript:getFamilyInfo(\''+record.get("TREATMENT_ID")+'\','+assistanceType+',\''+record.get("APPLY_ID")+'\')">'+value+'</a>';
	}
	var num = 1;
	//查询
	function query(){
	   var lrdwId=document.getElementById("lrdwId").value;
	    if(""==lrdwId){
	    	lrdwId=organArea;
	    }
		familyList.setParameter("cardNo",_$("cardNo"));
		familyList.setParameter("familyName",_$("familyName"));
		familyList.setParameter("familyCardNo",_$("familyCardNo"));
		familyList.setParameter("domicileCode",lrdwId);
		familyList.setParameter("queryDate", getCurYM());
		noReclick(familyList,"queryId");
		//翻页
		var grid = L5.getCmp('daiBanGridPanel');
		num = familyList.pageInfo.pageIndex;
		familyList.load();
		if(num == 1){
			return;
		}
		familyList.on('load',turnPageNum);
	}
		//获得当前日期 2011-05
	function getCurYM(){
		var date=new Date();
		var year=""+date.getFullYear();
		var month=date.getMonth()+1;
		if(month<10){month="0"+month;}
		return year+"-"+month;
	}
		
	function turnPageNum(ds){
		ds.un('load',turnPageNum);
		ds.turnPage(num);
	}
	//查询
	function queryButton(){
	   var lrdwId=document.getElementById("lrdwId").value;
	    if(""==lrdwId){
	    	lrdwId=organArea;
	    }
		familyList.setParameter("cardNo",_$("cardNo"));
		familyList.setParameter("familyName",_$("familyName"));
		familyList.setParameter("familyCardNo",_$("familyCardNo"));
		familyList.setParameter("domicileCode",lrdwId);
		familyList.setParameter("queryDate", getCurYM());
		noReclick(familyList,"queryId");
		familyList.load();
	}
	/**
	 * 选择属地行政区划窗口
	 */
	function func_ForDomicileSelect() {
		var revalue = window.showModalDialog(
				L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
						+ organArea + "&organName="
						+ escape(encodeURIComponent(organName)), "",
				"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if (revalue != "" && revalue != undefined) {
			var list = revalue.split(";");
			document.getElementById("lrdwId").value = list[0];
			document.getElementById("lrdwmc").value = list[1];
		}
	}
	//获取当前时间
	function getCurrent(){		
		return (new Date()).getTime();
	}
	
	function deleteApply(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
				if(sta=="yes"){
					L5.getCmp("deleteB").setDisabled(true);
					var command = new L5.Command("com.inspur.cams.drel.his.city.cmd.SamCityHisCmd");
					command.setParameter("applyId",records[0].get('APPLY_ID') );
					command.setParameter("familyId",records[0].get('FAMILY_ID') );
					command.execute("deleteHisInfoByApplyAndFamilyId");
					if (!command.error) {
						L5.Msg.alert("提示","删除成功！",function(){
							query();
							L5.getCmp("deleteB").setDisabled(false);
						});			
					}else{
							L5.Msg.alert('提示',"删除时出现错误！"+command.error);
							L5.getCmp("deleteB").setDisabled(false);
					}
				}else{
					return;
				}
			});
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	
	}
</script>
</head>
<body>
<!-- 加载扫描控件，解决模态窗口不加载控件的问题 -->
<div style="display:none">
  <OBJECT classid="clsid:BE09AB71-8C98-4B7A-B539-08E8F61D5453" 
    codebase=L5.webPath+"/jsp/cams/btp/comm/video.CAB#version=1,0,22,0" width=1 height=1 ></OBJECT>
</div>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="familyList" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" method="querySamFamilyList" global="true"  >
		<model:params>
			<model:param name="assistanceType" value='<%=request.getParameter("assistanceType")%>'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 分类施保类别 -->
	<model:dataset id="asisstanceClassDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
			<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
			<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 属别 -->
	<model:dataset id="belongingDataSet" enumName="SAM_BELONGING" autoLoad="true" global="true"></model:dataset>
	<!-- 供养方式 -->
	<model:dataset id="supportWayDataset" enumName="SAM.SUPPORT_WAY" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:Panel title="历史数据查询" width="100%" autoHeight="true" titleCollapse="true" >	
		<next:Html>			
				<form class="L5form">
					<table  border="1" width="100%">
						<tr>
						 	<td class="FieldLabel" style="width:10%">地区</td>
			                <td class="FieldInput" style="width:20%">
			                 <input type="text" id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" value="<%=BspUtil.getCorpOrgan().getOrganName()%>" style='width:80%'/>
						  <input type="text" style="display: none;"  name="lrdwId" id="lrdwId" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
						  <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
			               
			               </td>
			                <td class="FieldLabel" style="width:10%"><%= "03".equals(assistanceType)?"五保证号":"低保证号" %></td>
			                <td class="FieldInput" style="width:20%"><input type="text" id="cardNo" style="width:79%"/></td>
			                <td class="FieldButton" style="width:10%"><button style="width:100" id="queryId" onclick="queryButton();">查询</button></td>
						</tr>
						<tr>
						 	<td class="FieldLabel" style="width:10%">户主姓名</td>
			                <td class="FieldInput" style="width:10%"><input type="text"  id="familyName" style='width:80%'/></td>
			                <td class="FieldLabel" style="width:10%">身份证号码</td>
			                <td class="FieldInput" style="width:10%"><input type="text" id="familyCardNo" style="width:79%"  onchange="checkIDCard(this)"/></td>
			                 <td class="FieldButton" style="width:10%"><button type="reset" style="width:100">重置</button></td>
						</tr>
					</table>
				</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="daiBanGridPanel" title="历史数据列表" dataset="familyList" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>	
			<%if(!"true".equals(hideFlag)){ %>
			<next:ToolBarItem iconCls="add"  text="新增" handler="insert"/>
			<%} %>
			<next:ToolBarItem iconCls="edit"  text="修改" handler="update"/>
			<%if(!"true".equals(hideFlag)){ %>
			<next:ToolBarItem iconCls="remove" id="deleteB" text="删除" handler="deleteApply"/>
			<%} %>
		</next:TopBar>
		<next:Columns>
  				<next:RowNumberColumn/>
   			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="100"  ></next:Column>							
	        <next:Column header="户主姓名" field="FAMILY_NAME" width="70" renderer="detailHref"></next:Column>
        	<next:Column header="身份证号码" field="FAMILY_CARD_NO" width="150" ></next:Column>
			<next:Column header="<%=cardNoHeader %>" field="CARD_NO" width="130" align="center"></next:Column>
			<next:Column header="保障人口数" field="ASSISTANCE_PEOPLE_NUM" width="70" align="right"></next:Column>
			<%
			  if("03".equals(assistanceType)){
			%>
            <next:Column header="供养方式" field="SUPPORT_WAY" dataset='supportWayDataset' width="100"align="right"></next:Column>
            <%}else{ 
            	%>
           	 <next:Column header="户月保障金（元）" field="ASSISTANCE_MONEY" width="110" align="right" renderer="formatNum"></next:Column>
			<next:Column header="分类施保类别" field="ASSISTANCE_CLASS" width="100" dataset="asisstanceClassDataset" align="center"></next:Column>
			<next:Column header="分类施保金（元）" field="ASSISTANCE_CLASS_MONEY" width="110" align="right" renderer="formatNum"></next:Column>
            <%} 
            if("01".equals(assistanceType)){%>
           	 <next:Column header="属别" field="BELONGING" dataset="belongingDataSet"width="100" align="center"></next:Column>
             <%} %>
           <next:Column header="起始保障年月" field="BEGIN_DATE" width="100" align="center"></next:Column>
			
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="familyList" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
</body>
</html>