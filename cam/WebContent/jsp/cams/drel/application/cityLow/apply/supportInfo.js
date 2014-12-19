function init(){
if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
	}
	else if(method=="INSERT"){
	
		lowSupportDataset.newRecord({"supportId":supportId,"familyId":familyId,"supportCardType":"0","supportType":"D2"});//家庭信息
	}else if(method=="UPDATE"){
	
		document.getElementById("supportName").disabled=true;
		document.getElementById("supportCardNo").disabled=true;
		document.getElementById("releationType").disabled=true;
		
		lowSupportDataset.setParameter("SUPPORT_ID",supportId);
		lowSupportDataset.setParameter("FAMILY_ID",familyId);
		lowSupportDataset.load();
		
	}
}
function confirmSupport(){
	var ds = L5.DatasetMgr.lookup("lowSupportDataset");
	var lowSupportRecord= ds.getCurrent();
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command= new L5.Command("com.inspur.cams.drel.application.cityLow.cmd.SamLowSupportPeopleCmd");
	command.setParameter("lowSupportRecord", lowSupportRecord);
	if(method=="INSERT"){
		command.execute("lowSupportInsert");
	}else if(method=="UPDATE"){
		command.execute("lowSupportUpdate");
	}
	if (!command.error) {
		saveSuccessAlert();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}

}
//保存成功的提示信息
function saveSuccessAlert(){
	if(supportId==''||supportId=='null'){
		L5.MessageBox.confirm('提示','保存成功！是否继续添加赡养人员？',function(state){
			if(state=="yes"){		
				//继续添加成员
				goOnInsert();
				//刷新父窗口
				confirmClosePeople();
			}else{
				//关闭窗口
				window.close();
				//刷新父窗口
				confirmClosePeople();
			}
		});
	}else{
		L5.Msg.alert("提示","保存成功！",function(){
			window.close();
			confirmClosePeople();
		});	
	}	
}
//继续添加成员
function goOnInsert(){
	lowSupportDataset.newRecord({"supportId":"","familyId":familyId,"supportCardType":"1"});//家庭信息

}
//刷新父窗口
function confirmClosePeople(){
	var parent=window.dialogArguments;
	var lowSupportDataset=parent.lowSupportDataset;
	lowSupportDataset.setParameter("FAMILY_ID",familyId);
	lowSupportDataset.load();
	parent.countTotle();
}
function closeSupport(){
window.close();
}

function checkCardNo(obj){
	var cardNo = obj.value;
	if(cardNo==''){
		L5.Msg.alert("提示","请输入身份证号");
		return;
	}
	//身份证号
	if(checkIdcard(cardNo) != true && !(cardNo.length==18 && cardNo.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		obj.value='';
		return;
	}
	return false;
			
}
function checkIdcard(num) 
{   
        num = num.toUpperCase();  
        //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。   
        if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num)))   
        { 
            //alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。'); 
            return false; 
        } 
        //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
        //下面分别分析出生日期和校验位 
        var len, re; 
        len = num.length; 
        if (len == 15) 
        { 
            re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/); 
            var arrSplit = num.match(re);

            //检查生日日期是否正确 
            var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]); 
            var bGoodDay; 
            bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4])); 
            if (!bGoodDay) 
            { 
                //alert('输入的身份证号里出生日期不对！');   
                return false; 
            } 
            else 
            { 
                    //将15位身份证转成18位 
                    //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
                    var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
                    var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
                    var nTemp = 0, i;   
                    num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6); 
                    for(i = 0; i < 17; i ++) 
                    { 
                        nTemp += num.substr(i, 1) * arrInt[i]; 
                    } 
                    num += arrCh[nTemp % 11];   
                    return true;   
            }   
        } 
        if (len == 18) 
        { 
            re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/); 
            var arrSplit = num.match(re);

            //检查生日日期是否正确 
            var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]); 
            var bGoodDay; 
            bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4])); 
            if (!bGoodDay) 
            { 
                //alert(dtmBirth.getYear()); 
                //alert(arrSplit[2]); 
                //alert('输入的身份证号里出生日期不对！'); 
                return false; 
            } 
        else 
        { 
            //检验18位身份证的校验码是否正确。 
            //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
            var valnum; 
            var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
            var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
            var nTemp = 0, i; 
            for(i = 0; i < 17; i ++) 
            { 
                nTemp += num.substr(i, 1) * arrInt[i]; 
            } 
            valnum = arrCh[nTemp % 11]; 
            if (valnum != num.substr(17, 1)) 
            { 
                //alert('18位身份证的校验码不正确！应该为：' + valnum); 
                return false; 
            } 
            return true; 
        } 
        } 
        return false; 
}  
//计算人均
function getave(){
	var supportFamilyNum = document.getElementById("supportFamilyNum").value;
	
	var monthIncome = document.getElementById("monthIncome").value;
	//alert(supportFamilyNum+"--"+monthIncome);
	if(supportFamilyNum==""||monthIncome==""){
		return false;
	}
    var reg = new RegExp("^[0-9]*$");
    if(!reg.test(supportFamilyNum)){
        L5.Msg.alert("提示","家庭人口数请输入数字!");
		return false;
    }
    if(!/^[0-9]*$/.test(monthIncome)){
        L5.Msg.alert("提示","月总收入请输入数字!!");
		return false;
  	}
   //var ave = (monthIncome/supportFamilyNum).toFixed(2);
   var ave =Math.round(monthIncome/supportFamilyNum);
   document.getElementById("monthAveIncome").value= ave;
   lowSupportDataset.set("monthAveIncome",ave);
   
return true;	
}	