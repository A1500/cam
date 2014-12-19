<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /> 
<meta http-equiv="x-ua-compatible" content="ie=7" />
<link href="css/style.css" rel="stylesheet" type="text/css" />

<title>殡仪馆收费价格公示表</title>
<next:ScriptManager></next:ScriptManager>
</head>
<script type="text/javascript">
	var funeralCode='<%=request.getParameter("funeral_code")%>';
	var priceApplyId='<%=request.getParameter("priceApplyId")%>';
</script>
<script language="javascript">
	function init(){
		var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		if(funeralCode!=null&&funeralCode!=""&&funeralCode!='null'){
			fisPriceGoodsServiceDS.setParameter("funeralCode", funeralCode);
		}
		if(priceApplyId!=null&&priceApplyId!=""&&priceApplyId!='null'){
			fisPriceGoodsServiceDS.setParameter("priceApplyId", priceApplyId);
		}
		fisPriceGoodsServiceDS.load(true);
		var fisPriceApplyDS=L5.DatasetMgr.lookup("fisPriceApplyDS");
		if(funeralCode!=null&&funeralCode!=""&&funeralCode!='null'){
			fisPriceApplyDS.setParameter("CREATE_ORGAN", funeralCode);
		}
		if(priceApplyId!=null&&priceApplyId!=""&&priceApplyId!='null'){
			fisPriceApplyDS.setParameter("price_Apply_Id", priceApplyId);
		}
		fisPriceApplyDS.load(true);
		document.getElementById("totalNum").innerHTML=fisPriceGoodsServiceDS.getTotalCount()+" 个";
		document.getElementById("currentPageNum").innerHTML=fisPriceGoodsServiceDS.getPageIndex()+"/"+fisPriceGoodsServiceDS.getTotalPage()+"页";
		if(funeralCode==null||funeralCode==""){
			document.getElementById("funeral_name").innerHTML="";
			document.getElementById("create_people_name").innerHTML="";
			document.getElementById("organ_name").innerHTML="";
			document.getElementById("create_time").innerHTML="";
		}else{
			if(fisPriceGoodsServiceDS.getTotalCount()!=""&&fisPriceGoodsServiceDS.getTotalCount()!=null){
				document.getElementById("funeral_name").innerHTML=fisPriceApplyDS.getAt(0).get("createOrganName");
				document.getElementById("create_people_name").innerHTML=fisPriceApplyDS.getAt(0).get("createPeopleName");
				document.getElementById("organ_name").innerHTML=fisPriceApplyDS.getAt(0).get("organName");
				document.getElementById("create_time").innerHTML=fisPriceApplyDS.getAt(0).get("createTime");
			}
		}
		
	}
	function turnNext(){
		var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		fisPriceGoodsServiceDS.turnNext();
	}
	function turnPre(){
		var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		fisPriceGoodsServiceDS.turnPrev();
	}
	function turnLast(){
		var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		fisPriceGoodsServiceDS.turnLast();
	}
	function turnFirst(){
		var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		fisPriceGoodsServiceDS.turnFirst();
	}
	function turnPage(){
		var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		fisPriceGoodsServiceDS.turnPage(document.getElementById("to_page").value);
	}
	
	function onSubmit(){
		var funeralCode=document.getElementsByName("funeralCode")[0].value;
		var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		if(funeralCode!=null&&funeralCode!=""){
			fisPriceGoodsServiceDS.setParameter("funeralCode", funeralCode);
		}
		fisPriceGoodsServiceDS.load(true);
		var fisPriceApplyDS=L5.DatasetMgr.lookup("fisPriceApplyDS");
		fisPriceApplyDS.setParameter("CREATE_ORGAN",funeralCode);
		fisPriceApplyDS.load(true);
		document.getElementById("totalNum").innerHTML=fisPriceGoodsServiceDS.getTotalCount()+" 个";
		document.getElementById("currentPageNum").innerHTML=fisPriceGoodsServiceDS.getPageIndex()+"/"+fisPriceGoodsServiceDS.getTotalPage()+"页";
		if(funeralCode==null||funeralCode==""){
			document.getElementById("funeral_name").innerHTML="";
			document.getElementById("create_people_name").innerHTML="";
			document.getElementById("organ_name").innerHTML="";
			document.getElementById("create_time").innerHTML="";
		}else{
			if(fisPriceGoodsServiceDS.getTotalCount()!=""&&fisPriceGoodsServiceDS.getTotalCount()!=null){
				document.getElementById("funeral_name").innerHTML=fisPriceApplyDS.getAt(0).get("createOrganName");
				document.getElementById("create_people_name").innerHTML=fisPriceApplyDS.getAt(0).get("createPeopleName");
				document.getElementById("organ_name").innerHTML=fisPriceApplyDS.getAt(0).get("organName");
				document.getElementById("create_time").innerHTML=fisPriceApplyDS.getAt(0).get("createTime");
			}
		}
	}

	function forExcel(){
		var funeral_name=document.getElementById("funeral_name").innerHTML;
		var dataset=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		if(dataset.getCount()<=0){
			L5.Msg.alert('提示', "无查询结果，不能导出!");
			return false;
		}
		var pageSize = dataset.pageInfo.pageSize;
		var pageIndex = dataset.pageInfo.pageIndex;
		var startCursor = dataset.pageInfo.startCursor;
		dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
		dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
		dataset.baseParams["limitExcel"]=dataset.getTotalCount();	
		L5.dataset2excel(dataset, "/jsp/ext/onlineService/fis/query/apply/fisServiceExcel.jsp?funeral_name="+funeral_name);
		dataset.baseParams["excelType"]="reset"; //重置导出类型
	}
</script>
<script> 
	function SetWinHeight(obj)
{
	
    var win=obj;
    if (document.getElementById)
    {
        if (win && !window.opera)
        {
            if (win.contentDocument && win.contentDocument.body.offsetHeight) 

                win.height = win.contentDocument.body.offsetHeight; 
            else if(win.Document && win.Document.body.scrollHeight)
                win.height = win.Document.body.scrollHeight;
        }
    }
}
</script>
<body>

<model:datasets>
	<%--基本信息--%>
	<model:dataset id="fisPriceGoodsServiceDS" cmd="com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceQueryCommand" method="queryPrice"  pageSize="20">
	</model:dataset>
	<model:dataset id="fisPriceApplyDS" cmd="com.inspur.cams.fis.ex.cmd.FisPriceApplyQueryCommand"  pageSize="10">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceApply"/>
	</model:dataset>
	<!-- 定价形式 -->
	<model:dataset id="dingjiaDS" enumName="FIS.PRICE_STANDARD" autoLoad="true" global="true"></model:dataset>
	<!-- 服务类型 -->
	<model:dataset id="workTypeDS" enumName="FIS.WORK_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 费用类型 -->
	<model:dataset id="feeTypeDS" enumName="FIS.FEE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 收费性质 -->
	<model:dataset id="shoufeiDS" enumName="FIS.INVOICE_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div >
	<div class="f-div" style="margin:0 auto;">
		<div class="bscx-div-1">
		
		<div class="bscx-div-10">
<table width="1260" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd">
	<tr>
		<td colspan="13"  bgcolor="#FFFFFF" align="center">
		  	<span style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'楷体_GB2312';font-weight:bold;">殡仪馆收费价格公示表</span>
		</td>
	</tr>
	<tr id="a1">
		<td colspan="7"  bgcolor="#FFFFFF" align="left">
		  	<span style="mso-spacerun:'yes'; font-size:8.0000pt; font-family:'仿宋_GB2312';"><label>殡仪馆名称：</label><label  id="funeral_name"/></span>
		</td>
		<td colspan="6" bgcolor="#FFFFFF" align="right">
		  	<span style="mso-spacerun:'yes'; font-size:8.0000pt; font-family:'仿宋_GB2312';"><label>殡仪馆负责人：</label><label  id="create_people_name"/></span>
		</td>
	</tr>
  <tr class="word-22">
    <td width="6%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">服务类型</td>
    <td width="6%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">收费类型</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">项目名称</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">收费标准</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">收费性质</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">定价形式</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">收费依据</td>
    <td width="6%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">执行时间</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">减免对象</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">政府减免标准</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">减免依据</td>
    <td width="7%" class="FieldButton" align="center" valign="middle" bgcolor="#d5e4eb">减免执行时间</td>
  </tr>
</table>
<table width="1260" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd" dataset="fisPriceGoodsServiceDS">
  <tr  repeat="true" class="word-22">
    <td width="6%" align="center" valign="middle" bgcolor="#FFFFFF"><label  field="WORK_TYPE" dataset="workTypeDS"/></td>
    <td width="6%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="FEE_TYPE" dataset="feeTypeDS"/></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="SERVICE_NAME" /></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="PRICE_DESC"/></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="INVOICE_CODE_TYPE" dataset="shoufeiDS"/></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label  field="PRICE_STANDARD" dataset="dingjiaDS"/></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="PRICE_FILE_NUM" /></td>
    <td width="6%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="PRICE_EXE_TIME" /></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label  field="REMISSION_TARGET"/></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="REMISSION_DESC"/></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="REMISSION_FILE_NUM" /></td>
    <td width="7%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="REMISSION_EXE_TIME" /></td>
  </tr>
</table>
<table width="1260" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd">
	<tr id="a2">
		<td colspan="7"  bgcolor="#FFFFFF" align="left">
		  	<span style="mso-spacerun:'yes'; font-size:8.0000pt; font-family:'仿宋_GB2312';"><label>殡仪馆所属民政局：</label><label  id="organ_name"/></span>
		</td>
		<td colspan="6" bgcolor="#FFFFFF" align="right">
		  	<span style="mso-spacerun:'yes'; font-size:8.0000pt; font-family:'仿宋_GB2312';"><label>填表时间：</label><label  id="create_time"/></span>
		</td>
	</tr>
</table>
<div class="bscx-div-8">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="41%" height="40" align="left">查到的殡仪馆共有 <label id="totalNum" /></td>
        <td width="59%" align="right">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="page">
				<tr>
					<form name="searchOrgForm" action="searchOrgList.do?action=searchOrgList" method="post">
						<td align="left">
							<input type="hidden" name="orgName" value="">    	        
							<input type="hidden" name="corporateType" value="">
							<input type="hidden" name="managerDeptCode" value="">
							<input type="hidden" name="registrationNo" value="">
							<input type="hidden" name="page_flag" value="true">
							<input type="hidden" name="pagesize_key" value="result">
							<input type="hidden" name="goto_page" value="">
							<input type="hidden" name="current_page" value="1">
							<input type="hidden" name="total_count" value="2136">
							<td align="right">
								&nbsp;<a href="#" onclick="forExcel()">导出Excel</a>&nbsp;|&nbsp;<a href="#" onclick="turnFirst()">首页</a>&nbsp;|&nbsp;<a href="#" onclick="turnPre();">上页</a>&nbsp;|&nbsp;<a href="#" onclick="turnNext();">下页</a>&nbsp;|&nbsp;<a href="#" onclick="turnLast();">末页</a>&nbsp;&nbsp;第<label id="currentPageNum" />&nbsp;转到<input type="text" id="to_page" size="2">页<button onclick="turnPage();">-&gt;</button>
							</td>
						</td>
					</form>
				</tr>
			</table>
 		</td>
      </tr>
</table>
</div>
</body>
</html>
