function float(){
document.getElementById("float").style.top=getScrollTop();
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
	var url='jsp/cams/sorg/check/group/detail/groupCheckDetail'+pageIndex+'.jsp';
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
	var url='jsp/cams/sorg/check/group/edit/groupCheckEdit'+pageIndex+'.jsp';
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
	str+='<option value="14">第14页</option>';
	str+='<option value="15">第15页</option>';
	str+='<option value="16">第16页</option>';
	str+='<option value="17">第17页</option>';
	str+='<option value="18">第18页</option>';
	//str+='<option value="19">第19页</option>';
	str+='</select>';
	return str;
}