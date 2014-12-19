function float(){
	if(document.getElementById("float")!=null){
		document.getElementById("float").style.top=getScrollTop();
	}
}

function floatScall(){
float();
//floatBottom();
}
window.onscroll=floatScall;
window.onresize=floatScall;
window.onload=floatScall;

function getScrollTop()
{
    if (typeof window.pageYOffset != 'undefined')
    {
       return window.pageYOffset;
    }
    else if (typeof document.compatMode != 'undefined' &&
         document.compatMode != 'BackCompat')
    {
       return document.documentElement.scrollTop;
    }
    else if (typeof document.body != 'undefined')
    {
       return document.body.scrollTop;
    }
}

function floatBottom(){
	document.getElementById("floatBottom").style.top='50';
}

function getScrollBottom()
{
    if (typeof window.pageYOffset != 'undefined')
    {
       return window.pageYOffset;
    }
    else if (typeof document.compatMode != 'undefined' &&
         document.compatMode != 'BackCompat')
    {
       return parseInt(document.documentElement.offsetHeight)-parseInt(250) ;
    }
    else if (typeof document.body != 'undefined')
    {
       alert(document.body.offsetHeight);
       return parseInt(document.body.offsetHeight)-parseInt(250) ;
    }
}

//社会团体明细页面导航创建
function createGroupDetailSelect(){
	var floatDiv = document.getElementById("float");
	var sHTML='<select name="导航" field="borgName" onchange="groupDetailJumpTo(this.value)" style="height: 25px; width: 150px; position: absolute; margin-left: 420px;;margin-top:5px" >';
    floatDiv.insertAdjacentHTML("afterBegin",createGroupContent(sHTML));
}
//社会团体明细页面导航跳转
function groupDetailJumpTo(pageIndex){
	var data = new L5.Map();
	data.put("taskCode",taskCode);
	var url='jsp/ext/som/manage/check/group/detail/groupJXCheckDetail'+pageIndex+'.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
//社会团体修改页面导航创建
function createGroupEditSelect(){
	var floatDiv = document.getElementById("float");
	var sHTML='<select name="导航" onchange="groupEditJumpTo(this.value)" style="height: 25px; width: 150px; position: absolute; margin-left: 420px;margin-top:5px" >';
    floatDiv.insertAdjacentHTML("afterBegin",createGroupContent(sHTML));
}
//社会团体修改页面导航跳转
function groupEditJumpTo(pageIndex){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	data.put("taskCode",taskCode);
	var url='jsp/ext/som/manage/check/group/edit/groupJXCheckEdit'+pageIndex+'.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
//社会团体导航内容组装
function createGroupContent(str){
	str+='<option value="0">请选择跳转页面</option>';
	str+='<option value="1">第1页</option>';
	str+='<option value="2">第2页</option>';
	str+='<option value="3">第3页</option>';
	str+='<option value="4">第4页</option>';
	str+='<option value="5">第5页</option>';
	str+='<option value="6">第6页</option>';
	str+='<option value="7">第7页</option>';
	str+='<option value="8">第8页</option>';
	str+='<option value="9">第9页</option>';
	str+='<option value="10">第10页</option>';
	str+='<option value="11">第11页</option>';
	str+='<option value="12">第12页</option>';
	str+='<option value="13">第13页</option>';
	str+='</select>';
	return str;
}
function back(){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/group/filllist/somgroupjxcheckfill_list.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
function lastPage(page){
	if(save() == "break"){
	return;
	}
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/group/edit/groupJXCheckEdit'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function nextPage(page){
	if(save() == "break"){
	return;
	}
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/group/edit/groupJXCheckEdit'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function lastPage1(page){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/group/detail/groupJXCheckDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function nextPage1(page){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/group/detail/groupJXCheckDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
/////##############################################   民非   ############################################################

//明细页面导航创建
function createUngovDetailSelect(){
	var floatDiv = document.getElementById("float");
	var sHTML='<select name="导航" field="borgName" onchange="ungovDetailJumpTo(this.value)" style="height: 25px; width: 150px; position: absolute; margin-left: 420px;;margin-top:5px" >';
    floatDiv.insertAdjacentHTML("afterBegin",createUngovContent(sHTML));
}
//明细页面导航跳转
function ungovDetailJumpTo(pageIndex){
	var data = new L5.Map();
	data.put("taskCode",taskCode);
	var url='jsp/ext/som/manage/check/ungov/detail/ungovJXCheckDetail'+pageIndex+'.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
//修改页面导航创建
function createUngovEditSelect(){
	var floatDiv = document.getElementById("float");
	var sHTML='<select name="导航" onchange="ungovEditJumpTo(this.value)" style="height: 25px; width: 150px; position: absolute; margin-left: 420px;margin-top:5px" >';
    floatDiv.insertAdjacentHTML("afterBegin",createUngovContent(sHTML));
}
//修改页面导航跳转
function ungovEditJumpTo(pageIndex){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	data.put("taskCode",taskCode);
	var url='jsp/ext/som/manage/check/ungov/edit/ungovJXCheckEdit'+pageIndex+'.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
//社会团体导航内容组装
function createUngovContent(str){
	str+='<option value="0">请选择跳转页面</option>';
	str+='<option value="1">第1页</option>';
	str+='<option value="2">第2页</option>';
	str+='<option value="3">第3页</option>';
	str+='<option value="4">第4页</option>';
	str+='<option value="5">第5页</option>';
	str+='<option value="6">第6页</option>';
	str+='<option value="7">第7页</option>';
	str+='<option value="8">第8页</option>';
	str+='<option value="9">第9页</option>';
	str+='<option value="10">第10页</option>';
	str+='<option value="11">第11页</option>';
	str+='<option value="12">第12页</option>';
	str+='</select>';
	return str;
}
function nextPageM(page){
	if(save() == "break"){
	return;
	}
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/ungov/edit/ungovJXCheckEdit'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function lastPageM(page){
	if(save() == "break"){
	return;
	}
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/ungov/edit/ungovJXCheckEdit'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function backM(){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/ungov/filllist/somungovjxcheckfill_list.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
function lastPageM1(page){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/ungov/detail/ungovJXCheckDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function nextPageM1(page){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/ungov/detail/ungovJXCheckDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
/////##############################################   基金会   ############################################################

//明细页面导航创建
function createFundDetailSelect(){
	var floatDiv = document.getElementById("float");
	var sHTML='<select name="导航" field="borgName" onchange="fundDetailJumpTo(this.value)" style="height: 25px; width: 150px; position: absolute; margin-left: 420px;;margin-top:5px" >';
    floatDiv.insertAdjacentHTML("afterBegin",createFundContent(sHTML));
}
//明细页面导航跳转
function fundDetailJumpTo(pageIndex){
	var data = new L5.Map();
	data.put("taskCode",taskCode);
	var url='jsp/ext/som/manage/check/fund/detail/fundJXCheckDetail'+pageIndex+'.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
//修改页面导航创建
function createFundEditSelect(){
	var floatDiv = document.getElementById("float");
	var sHTML='<select name="导航" onchange="fundEditJumpTo(this.value)" style="height: 25px; width: 150px; position: absolute; margin-left: 420px;margin-top:5px" >';
    floatDiv.insertAdjacentHTML("afterBegin",createFundContent(sHTML));
}
//修改页面导航跳转
function fundEditJumpTo(pageIndex){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	data.put("taskCode",taskCode);
	var url='jsp/ext/som/manage/check/fund/edit/fundJXCheckEdit'+pageIndex+'.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
//导航内容组装
function createFundContent(str){
	str+='<option value="0">请选择跳转页面</option>';
	str+='<option value="1">第1页</option>';
	str+='<option value="2">第2页</option>';
	str+='<option value="3">第3页</option>';
	str+='<option value="4">第4页</option>';
	str+='<option value="5">第5页</option>';
	str+='<option value="6">第6页</option>';
	str+='<option value="7">第7页</option>';
	str+='<option value="12">第8页</option>';
	str+='<option value="13">第9页</option>';
	str+='<option value="14">第10页</option>';
	str+='<option value="15">第11页</option>';
	str+='<option value="16">第12页</option>';
	str+='<option value="17">第13页</option>';
	str+='<option value="18">第14页</option>';
	str+='<option value="19">第15页</option>';
	str+='<option value="20">第16页</option>';
	str+='<option value="21">第17页</option>';
	str+='<option value="22">第18页</option>';
	str+='<option value="23">第19页</option>';
	str+='<option value="24">第20页</option>';
	str+='<option value="25">第21页</option>';
	str+='<option value="26">第22页</option>';
	str+='<option value="27">第23页</option>';
	str+='<option value="28">第24页</option>';
	str+='<option value="29">第25页</option>';
	str+='<option value="30">第26页</option>';

	str+='</select>';
	return str;
}
function nextPageJ(page){
	if(save() == "break"){
	return;
	}
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/fund/edit/fundJXCheckEdit'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function lastPageJ(page){
	if(save() == "break"){
	return;
	}
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/fund/edit/fundJXCheckEdit'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function backJ(){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/fund/filllist/somfundjxcheckfill_list.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
function lastPageJ1(page){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/fund/detail/fundJXCheckDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function nextPageJ1(page){
	var data = new L5.Map();
	var url='jsp/ext/som/manage/check/fund/detail/fundJXCheckDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}

function docPrint(){
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.execute("printCheck");
	var flag= command.getReturn("flag");
	if(taskCode == 'null'){
		document.execCommand("Print", false);
		return;
	}
	if(flag == "Y"){
		document.execCommand("Print", false);
	}else{
		L5.Msg.alert("提示",flag);
		return;
	}
}
function checkFloat(obj){
	var reg=/^[+|-]{0,1}\d*\.?\d+$/;
	var val=obj.value;
	if(val!=""&& !reg.test(val)){
		alert("数据输入错误，请重新输入！");
		obj.value="";
	}
}
function operDesc(){
	L5.getCmp('winOperDesc').show();
}
function closeOperDesc(){
	L5.getCmp('winOperDesc').hide();
}

function setPrint(){
	var hkey_root,hkey_path,hkey_key;
	hkey_root="HKEY_CURRENT_USER";
	hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
	//页边距，10毫米
	var length = "0.3937007874015748";
	//设置网页打印的页眉页脚为空
	try{
		var RegWsh = new ActiveXObject("WScript.Shell");
		//设置页眉为空
		hkey_key="header" ;
	    RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
		//设置页脚为空
		hkey_key="footer";
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
		//设置下页边距（0）
		hkey_key="margin_bottom";
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,length);
		//设置左页边距（0）
		hkey_key="margin_left";
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,length);
		//设置右页边距（0）
		hkey_key="margin_right";
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,length);
		//设置上页边距（0）
		hkey_key="margin_top";
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,length);
	}catch(e){
		alert('请使用IE浏览器打印,并将本系统地址加入"受信任的站点"，否则打印格式可能会不正确！');
		}
	}