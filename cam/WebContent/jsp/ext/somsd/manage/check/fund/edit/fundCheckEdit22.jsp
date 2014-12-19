<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	var somJxCheckBusinessActivityDataSet = L5.DatasetMgr.lookup("somJxCheckBusinessActivityDataSet");
	somJxCheckBusinessActivityDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckBusinessActivityDataSet.load();
	somJxCheckBusinessActivityDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckBusinessActivityDataSet.newRecord();
		}
		//收 入													
		for(var i=1;i<=7;i++){
			setSumFei1(i);
			setSumFei2(i);		
			setSumLei1(i);		
			setSumLei2(i);
			setSumYong1(i);		
			setSumYong2(i);	
		}
		//费 用	
		for(var i=1;i<=4;i++){
			setSumYong1(i);
			setSumYong2(i);
			setSumYong3(i);
			setSumYong4(i);
		}	
		for(var i=1;i<=4;i++){
			setSumQizhong(i,1,4);
			setSumQizhong2(i,1,4);
			setSumQizhongLei(i,1,4);
			setSumQizhongLei2(i,1,4);
		}
		
		//限定性
		//净资产
		for(var i=1;i<=4;i++){
			setSum(i);
		}
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var somJxCheckBusinessActivityDataSetIsValidate = somJxCheckBusinessActivityDataSet.isValidate();
	if(somJxCheckBusinessActivityDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckBusinessActivityDataSetIsValidate);
		return "break";
	}
	var somJxCheckBusinessActivityRecord=somJxCheckBusinessActivityDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxCheckBusinessActivityRecord",somJxCheckBusinessActivityRecord);
	command.execute("savePageJ22");
	if (!command.error) {
		alert("保存成功！");			
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<script>
function getYewuFei(ele1,ele2,ele3,ele4,result){
                
    var sum1=0;
    var obj =  document.getElementById(  ele1);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  ele2);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
          
    var obj =  document.getElementById(  ele3);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  ele4);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  result).value = (Math.round(sum1*1000000))/1000000; 
   
   }
function setSumFei1(result1){
   
       
   var sum = 0;
   var sum1 = 0;
   var ele = "mojuanfeixian$mohuifeixian$mofuwufeixian$moxiaoshoufeixian$mobuzhufeixian$motouzifeixian$moqitafeixian";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(  eles[i]);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }     
     document.getElementById(  'mohejifeixian').value = (Math.round(sum*1000000))/1000000;
   if(result1==1) {
    calShouHeji11("mojuanfeixian","mojuanxian","mojuanheji"); 
   }else if(result1==2) { 
    calShouHeji11("mohuifeixian","mohuixian","mohuiheji"); 
   }else if(result1==3) { 
    calShouHeji11("mofuwufeixian","mofuwuxian","mofuwuheji"); 
   }else if(result1==4) { 
    calShouHeji11("moxiaoshoufeixian","moxiaoshouxian","moxiaoshouheji"); 
   }else if(result1==5) { 
    calShouHeji11("mobuzhufeixian","mobuzhuxian","mobuzhuheji"); 
   }else if(result1==6) { 
    calShouHeji11("motouzifeixian","motouzixian","motouziheji"); 
   }else if(result1==7) { 
    calShouHeji11("moqitafeixian","moqitaxian","moqitaheji"); 
   }  
    
   calShouHeji1();
   calJing("mohejifeixian","mofeiyonghejifei","mobiandongfeixian");
}
   
function calShouHeji11(ele1,ele2,result){
                
    var sum1=0;
    var obj =  document.getElementById(  ele1);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  ele2);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  result).value = (Math.round(sum1*1000000))/1000000; 
   
   }


   function calShouHeji1(){
                
    var sum1=0;
    var obj =  document.getElementById(  'mohejifeixian');
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  'mohejixian');
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  'mohejiheji').value = (Math.round(sum1*1000000))/1000000; 
   
   }
  
 function setSumFei2(result1){
   
       
   var sum = 0;
   var sum1 = 0;
   var ele = "mojuanxian$mohuixian$mofuwuxian$moxiaoshouxian$mobuzhuxian$motouzixian$moqitaxian";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(  eles[i]);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }     
     document.getElementById(  'mohejixian').value = (Math.round(sum*1000000))/1000000;
   if(result1==1) {
    calShouHeji11("mojuanfeixian","mojuanxian","mojuanheji"); 
   }else if(result1==2) { 
    calShouHeji11("mohuifeixian","mohuixian","mohuiheji"); 
   }else if(result1==3) { 
    calShouHeji11("mofuwufeixian","mofuwuxian","mofuwuheji"); 
   }else if(result1==4) { 
    calShouHeji11("moxiaoshoufeixian","moxiaoshouxian","moxiaoshouheji"); 
   }else if(result1==5) { 
    calShouHeji11("mobuzhufeixian","mobuzhuxian","mobuzhuheji"); 
   }else if(result1==6) { 
    calShouHeji11("motouzifeixian","motouzixian","motouziheji"); 
   }else if(result1==7) { 
    calShouHeji11("moqitafeixian","moqitaxian","moqitaheji"); 
   }  
    
   calShouHeji1();
   calJing("mohejixian","mofeiyonghejixian","mobiandongxian");
}

//---------------------------------------------------------------------------------------------

function setSumLei1(result1){
   
       
   var sum = 0;
   var sum1 = 0;
   var ele = "leijijuanfeixian$leijihuifeixian$leijifuwufeixian$leijixiaoshoufeixian$leijibuzhufeixian$leijitouzifeixian$leijiqitafeixian";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(  eles[i]);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }     
     document.getElementById(  'leijihejifeixian').value = (Math.round(sum*1000000))/1000000;
   if(result1==1) {
    calLeijiHeji11("leijijuanfeixian","leijijuanxian","leijijuanheji"); 
   }else if(result1==2) { 
    calLeijiHeji11("leijihuifeixian","leijihuixian","leijihuiheji"); 
   }else if(result1==3) { 
    calLeijiHeji11("leijifuwufeixian","leijifuwuxian","leijifuwuheji"); 
   }else if(result1==4) { 
    calLeijiHeji11("leijixiaoshoufeixian","leijixiaoshouxian","leijixiaoshouheji"); 
   }else if(result1==5) { 
    calLeijiHeji11("leijibuzhufeixian","leijibuzhuxian","leijibuzhuheji"); 
   }else if(result1==6) { 
    calLeijiHeji11("leijitouzifeixian","leijitouzixian","leijitouziheji"); 
   }else if(result1==7) { 
    calLeijiHeji11("leijiqitafeixian","leijiqitaxian","leijiqitaheji"); 
   }  
    
   calLeijiHeji1();
   calJing("leijihejifeixian","leijifeiyonghejifei","leijibiandongfeixian");
}
   
function calLeijiHeji11(ele1,ele2,result){
                
    var sum1=0;
    var obj =  document.getElementById(  ele1);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  ele2);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  result).value = (Math.round(sum1*1000000))/1000000; 
   
   }


   function calLeijiHeji1(){
                
    var sum1=0;
    var obj =  document.getElementById(  'leijihejifeixian');
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  'leijihejixian');
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  'leijihejiheji').value = (Math.round(sum1*1000000))/1000000; 
   
   }
  
 function setSumLei2(result1){
   
       
   var sum = 0;
   var sum1 = 0;
   var ele = "leijijuanxian$leijihuixian$leijifuwuxian$leijixiaoshouxian$leijibuzhuxian$leijitouzixian$leijiqitaxian";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(  eles[i]);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }     
     document.getElementById(  'leijihejixian').value = (Math.round(sum*1000000))/1000000;
   if(result1==1) {
    calLeijiHeji11("leijijuanfeixian","leijijuanxian","leijijuanheji"); 
   }else if(result1==2) { 
    calLeijiHeji11("leijihuifeixian","leijihuixian","leijihuiheji"); 
   }else if(result1==3) { 
    calLeijiHeji11("leijifuwufeixian","leijifuwuxian","leijifuwuheji"); 
   }else if(result1==4) { 
    calLeijiHeji11("leijixiaoshoufeixian","leijixiaoshouxian","leijixiaoshouheji"); 
   }else if(result1==5) { 
    calLeijiHeji11("leijibuzhufeixian","leijibuzhuxian","leijibuzhuheji"); 
   }else if(result1==6) { 
    calLeijiHeji11("leijitouzifeixian","leijitouzixian","leijitouziheji"); 
   }else if(result1==7) { 
    calLeijiHeji11("leijiqitafeixian","leijiqitaxian","leijiqitaheji"); 
   }  
    
   calLeijiHeji1();
   calJing("leijihejixian","leijifeiyonghejixian","leijibiandongxian");
}
 
 //----------------------------------------------费用---------------------------------
//------------------------------其中 上年末数------------------------
 function setSumQizhong(num, start, end){
    
    
    var leixing = "moqizhongfeixian";
        
    var sum = 0;
    for(i=start;i<=end;i++){
       
       var obj =  document.getElementById(  leixing +i);
           if(obj.value != ""){
              sum += parseFloat(obj.value);
           }
      }
    if(document.getElementById(  "mochengbenfeixian").value < (Math.round(sum*1000000))/1000000){
       //alert("各分项的加和不能大于业务活动成本总数！");
    };  
    
    if(num==1) {
     calHeji("moqizhongfeixian1","moqizhongxian1","moqizhongheji1");
     //公益活动支出
     getYewuFei("moqizhongfeixian1","moqizhongfeixian2","moqizhongfeixian3","moqizhongfeixian4","mochengbenfeixian");
     calHeji("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
    }if(num==2) {
     calHeji("moqizhongfeixian2","moqizhongxian2","moqizhongheji2");     
     //公益活动支出
     getYewuFei("moqizhongfeixian1","moqizhongfeixian2","moqizhongfeixian3","moqizhongfeixian4","mochengbenfeixian");
     calHeji("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
    }if(num==3) {
     calHeji("moqizhongfeixian3","moqizhongxian3","moqizhongheji3");
     //公益活动支出
     getYewuFei("moqizhongfeixian1","moqizhongfeixian2","moqizhongfeixian3","moqizhongfeixian4","mochengbenfeixian");
     calHeji("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
    }if(num==4) {
     calHeji("moqizhongfeixian4","moqizhongxian4","moqizhongheji4");
     //公益活动支出
     getYewuFei("moqizhongfeixian1","moqizhongfeixian2","moqizhongfeixian3","moqizhongfeixian4","mochengbenfeixian");
     calHeji("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
    }
 //   calQizhong();

 }
 
 function calHeji(ele1,ele2,result){
                 
     var sum1=0;
     var obj =  document.getElementById(  ele1);
           if(obj.value != ""){
              sum1 += parseFloat(obj.value);
           }
     var obj =  document.getElementById(  ele2);
           if(obj.value != ""){
              sum1 += parseFloat(obj.value);
           }
     document.getElementById(  result).value = (Math.round(sum1*1000000))/1000000; 
    
    }
     function calJing(ele1,ele2,result){
                 
     var sum1=0;
     var obj =  document.getElementById(  ele1);
           if(obj.value != ""){
              sum1 += parseFloat(obj.value);
           }
     var obj =  document.getElementById(  ele2);
           if(obj.value != ""){
              sum1 -= parseFloat(obj.value);
           }
     document.getElementById(  result).value = (Math.round(sum1*1000000))/1000000; 
    
    }
  
 
 function calQizhong(){
     

     var a1 = document.getElementById(  "mochengbenfeixian");
     var a2 = document.getElementById(   "moguanlifeixian"); 
     var a3 = document.getElementById(   "mochouzifeixian");
     var a4 = document.getElementById(   "moqitafeiyongfei");
     var sum = 0;
     var eles = new Array(a1, a2, a3, a4);
     for(i=0;i<eles.length;i++){
  
           if(eles[i].value != ""){ 
              sum += parseFloat(eles[i].value);
           }
      }
      
     document.getElementById(  "mofeiyonghejifei").value = (Math.round(sum*1000000))/1000000;
     
     calHeji("mofeiyonghejifei", "mofeiyonghejixian", "mofeiyonghejiheji");
 }

 function setSumQizhong2(num, start, end){
    
    
    var leixing = "moqizhongxian";
        
    var sum = 0;
    for(i=start;i<=end;i++){
       
       var obj =  document.getElementById(  leixing +i);
           if(obj.value != ""){
              sum += parseFloat(obj.value);
           }
      }
   // document.getElementById(  "mochengbenxian").value = (Math.round(sum*1000000))/1000000; 
    if(document.getElementById(  "mochengbenxian").value < (Math.round(sum*1000000))/1000000){
       //alert("各分项的加和不能大于业务活动成本总数！");
    };  
    if(num==1) {
     calHeji("moqizhongfeixian1","moqizhongxian1","moqizhongheji1");
     //公益活动支出
     getYewuFei("moqizhongxian1","moqizhongxian2","moqizhongxian3","moqizhongxian4","mochengbenxian");
     calHeji("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
    }if(num==2) {
     calHeji("moqizhongfeixian2","moqizhongxian2","moqizhongheji2");
     //公益活动支出
     getYewuFei("moqizhongxian1","moqizhongxian2","moqizhongxian3","moqizhongxian4","mochengbenxian");
     calHeji("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
    }if(num==3) {
     calHeji("moqizhongfeixian3","moqizhongxian3","moqizhongheji3");
     //公益活动支出
     getYewuFei("moqizhongxian1","moqizhongxian2","moqizhongxian3","moqizhongxian4","mochengbenxian");
     calHeji("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
    }if(num==4) {
     calHeji("moqizhongfeixian4","moqizhongxian4","moqizhongheji4");
     //公益活动支出
     getYewuFei("moqizhongxian1","moqizhongxian2","moqizhongxian3","moqizhongxian4","mochengbenxian");
     calHeji("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
    }
//    calQizhong2();

 }
 
 function calQizhong2(){
     

     var a1 = document.getElementById(  "mochengbenxian");
     var a2 = document.getElementById(   "moguanlixian"); 
     var a3 = document.getElementById(   "mochouzixian");
     var a4 = document.getElementById(   "moqitafeiyongxian");
     var sum = 0;
     var eles = new Array(a1, a2, a3, a4);
     for(i=0;i<eles.length;i++){
  
           if(eles[i].value != ""){ 
              sum += parseFloat(eles[i].value);
           }
      }
      
     document.getElementById(  "mofeiyonghejixian").value = (Math.round(sum*1000000))/1000000;
     
     calHeji("mofeiyonghejifei", "mofeiyonghejixian", "mofeiyonghejiheji");
 }

//------------------------------其中 本年累计数------------------------
 function setSumQizhongLei(num, start, end){
    
    
    var leixing = "leijiqizhongfeixian";
        
    var sum = 0;
    for(i=start;i<=end;i++){
       
       var obj =  document.getElementById(  leixing +i);
           if(obj.value != ""){
              sum += parseFloat(obj.value);
           }
      }
   // document.getElementById(  "leijichengbenfeixian").value = (Math.round(sum*1000000))/1000000;  
    if(document.getElementById(  "leijichengbenfeixian").value < (Math.round(sum*1000000))/1000000){
       //alert("各分项的加和不能大于业务活动成本总数！");
    }; 
    if(num==1) {
     calHeji("leijiqizhongfeixian1","leijiqizhongxian1","leijiqizhongheji1");
     //公益活动支出
     getYewuFei("leijiqizhongfeixian1","leijiqizhongfeixian2","leijiqizhongfeixian3","leijiqizhongfeixian4","leijichengbenfeixian");
     calHeji("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
    }if(num==2) {
     calHeji("leijiqizhongfeixian2","leijiqizhongxian2","leijiqizhongheji2");
     //公益活动支出
     getYewuFei("leijiqizhongfeixian1","leijiqizhongfeixian2","leijiqizhongfeixian3","leijiqizhongfeixian4","leijichengbenfeixian");
     calHeji("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
    }if(num==3) {
     calHeji("leijiqizhongfeixian3","leijiqizhongxian3","leijiqizhongheji3");
     //公益活动支出
     getYewuFei("leijiqizhongfeixian1","leijiqizhongfeixian2","leijiqizhongfeixian3","leijiqizhongfeixian4","leijichengbenfeixian");
     calHeji("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
    }if(num==4) {
     calHeji("leijiqizhongfeixian4","leijiqizhongxian4","leijiqizhongheji4");
     //公益活动支出
     getYewuFei("leijiqizhongfeixian1","leijiqizhongfeixian2","leijiqizhongfeixian3","leijiqizhongfeixian4","leijichengbenfeixian");
     calHeji("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
    }
//    calQizhongLei();

 }

 function calQizhongLei(){
     

     var a1 = document.getElementById(  "leijichengbenfeixian");
     var a2 = document.getElementById(   "leijiguanlifeixian"); 
     var a3 = document.getElementById(   "leijichouzifeixian");
     var a4 = document.getElementById(   "leijiqitafeiyongfeixian");
     var sum = 0;
     var eles = new Array(a1, a2, a3, a4);
     for(i=0;i<eles.length;i++){
  
           if(eles[i].value != ""){ 
              sum += parseFloat(eles[i].value);
           }
      }
      
     document.getElementById(  "leijifeiyonghejifei").value = (Math.round(sum*1000000))/1000000;
     
     calHeji("leijifeiyonghejifei", "leijifeiyonghejixian", "leijifeiyonghejiheji");
 }
  
  
  
 function setSumQizhongLei2(num, start, end){
    
    
    var leixing = "leijiqizhongxian";
        
    var sum = 0;
    for(i=start;i<=end;i++){
       
       var obj =  document.getElementById(  leixing +i);
           if(obj.value != ""){
              sum += parseFloat(obj.value);
           }
      }
    // document.getElementById(  "leijichengbenxian").value = (Math.round(sum*1000000))/1000000;
    if(document.getElementById(  "leijichengbenxian").value < (Math.round(sum*1000000))/1000000){
       //alert("各分项的加和不能大于业务活动成本总数！");
    };   
    if(num==1) {
     calHeji("leijiqizhongfeixian1","leijiqizhongxian1","leijiqizhongheji1");
     //公益活动支出
     getYewuFei("leijiqizhongxian1","leijiqizhongxian2","leijiqizhongxian3","leijiqizhongxian4","leijichengbenxian");
     calHeji("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
    }if(num==2) {
     calHeji("leijiqizhongfeixian2","leijiqizhongxian2","leijiqizhongheji2");
     //公益活动支出
     getYewuFei("leijiqizhongxian1","leijiqizhongxian2","leijiqizhongxian3","leijiqizhongxian4","leijichengbenxian");
     calHeji("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
    }if(num==3) {
     calHeji("leijiqizhongfeixian3","leijiqizhongxian3","leijiqizhongheji3");
     //公益活动支出
     getYewuFei("leijiqizhongxian1","leijiqizhongxian2","leijiqizhongxian3","leijiqizhongxian4","leijichengbenxian");
     calHeji("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
    }if(num==4) {
     calHeji("leijiqizhongfeixian4","leijiqizhongxian4","leijiqizhongheji4");
     //公益活动支出
     getYewuFei("leijiqizhongxian1","leijiqizhongxian2","leijiqizhongxian3","leijiqizhongxian4","leijichengbenxian");
     calHeji("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
    }
//    calQizhongLei2();

 }

 function calQizhongLei2(){
     

     var a1 = document.getElementById(  "leijichengbenxian");
     var a2 = document.getElementById(   "leijiguanlixian"); 
     var a3 = document.getElementById(   "leijichouzixian");
     var a4 = document.getElementById(   "leijiqitafeiyongxian");
     var sum = 0;
     var eles = new Array(a1, a2, a3, a4);
     for(i=0;i<eles.length;i++){
  
           if(eles[i].value != ""){ 
              sum += parseFloat(eles[i].value);
           }
      }
      
     document.getElementById(  "leijifeiyonghejixian").value = (Math.round(sum*1000000))/1000000;
     
     calHeji("leijifeiyonghejifei", "leijifeiyonghejixian", "leijifeiyonghejiheji");
 }

 
 //-----------------------------------------------上年------------------------------------
 
function setSumYong1(result1){
   
       
   var sum = 0;
   var sum1 = 0;
   var ele = "mochengbenfeixian$moguanlifeixian$mochouzifeixian$moqitafeiyongfei";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(  eles[i]);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }     
     document.getElementById(  'mofeiyonghejifei').value = (Math.round(sum*1000000))/1000000;
   if(result1==1) {
    calFeiyongHeji11("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
   }else if(result1==2) { 
    calFeiyongHeji11("moguanlifeixian","moguanlixian","moguanliheji"); 
   }else if(result1==3) { 
    calFeiyongHeji11("mochouzifeixian","mochouzixian","mochouziheji"); 
   }else if(result1==4) { 
    calFeiyongHeji11("moqitafeiyongfei","moqitafeiyongxian","moqitafeiyongheji"); 
   }
    
   calFeiYongHeji1();
   calJing("mohejifeixian","mofeiyonghejifei","mobiandongfeixian");
}
   
function calFeiyongHeji11(ele1,ele2,result){
                
    var sum1=0;
    var obj =  document.getElementById(  ele1);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  ele2);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  result).value = (Math.round(sum1*1000000))/1000000; 
   
   }


   function calFeiYongHeji1(){
                
    var sum1=0;
    var obj =  document.getElementById(  'mofeiyonghejifei');
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  'mofeiyonghejixian');
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  'mofeiyonghejiheji').value = (Math.round(sum1*1000000))/1000000; 
   
   }
  
 function setSumYong2(result1){
   
       
   var sum = 0;
   var sum1 = 0;
   var ele = "mochengbenxian$moguanlixian$mochouzixian$moqitafeiyongxian";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(  eles[i]);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }     
     document.getElementById(  'mofeiyonghejixian').value = (Math.round(sum*1000000))/1000000;
   if(result1==1) {
    calFeiyongHeji11("mochengbenfeixian","mochengbenxian","mochengbenheji"); 
   }else if(result1==2) { 
    calFeiyongHeji11("moguanlifeixian","moguanlixian","moguanliheji"); 
   }else if(result1==3) { 
    calFeiyongHeji11("mochouzifeixian","mochouzixian","mochouziheji"); 
   }else if(result1==4) { 
    calFeiyongHeji11("moqitafeiyongfei","moqitafeiyongxian","moqitafeiyongheji"); 
   }
    
   calFeiYongHeji1();
   calJing("mohejixian","mofeiyonghejixian","mobiandongxian");
}

//-----------------------------------------------------------------------------------------------------------------------

function setSumYong3(result1){
   
       
   var sum = 0;
   var sum1 = 0;
   var ele = "leijichengbenfeixian$leijiguanlifeixian$leijichouzifeixian$leijiqitafeiyongfeixian";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(  eles[i]);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }     
     document.getElementById(  'leijifeiyonghejifei').value = (Math.round(sum*1000000))/1000000;
   if(result1==1) {
    calFeiyongHeji21("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
   }else if(result1==2) { 
    calFeiyongHeji21("leijiguanlifeixian","leijiguanlixian","leijiguanliheji"); 
   }else if(result1==3) { 
    calFeiyongHeji21("leijichouzifeixian","leijichouzixian","leijichouziheji"); 
   }else if(result1==4) { 
    calFeiyongHeji21("leijiqitafeiyongfeixian","leijiqitafeiyongxian","leijiqitafeiyongheji"); 
   }
    
   calFeiYongHeji2();
   calJing("leijihejifeixian","leijifeiyonghejifei","leijibiandongfeixian");
}
   
function calFeiyongHeji21(ele1,ele2,result){
                
    var sum1=0;
    var obj =  document.getElementById(  ele1);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  ele2);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  result).value = (Math.round(sum1*1000000))/1000000; 
   
   }


   function calFeiYongHeji2(){
                
    var sum1=0;
    var obj =  document.getElementById(  'leijifeiyonghejifei');
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  'leijifeiyonghejixian');
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  'leijifeiyonghejiheji').value = (Math.round(sum1*1000000))/1000000; 
   
   }
  
 function setSumYong4(result1){
   
       
   var sum = 0;
   var sum1 = 0;
   var ele = "leijichengbenxian$leijiguanlixian$leijichouzixian$leijiqitafeiyongxian";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(  eles[i]);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }     
     document.getElementById(  'leijifeiyonghejixian').value = (Math.round(sum*1000000))/1000000;
   if(result1==1) {
    calFeiyongHeji21("leijichengbenfeixian","leijichengbenxian","leijichengbenheji"); 
   }else if(result1==2) { 
    calFeiyongHeji21("leijiguanlifeixian","leijiguanlixian","leijiguanliheji"); 
   }else if(result1==3) { 
    calFeiyongHeji21("leijichouzifeixian","leijichouzixian","leijichouziheji"); 
   }else if(result1==4) { 
    calFeiyongHeji21("leijiqitafeiyongfeixian","leijiqitafeiyongxian","leijiqitafeiyongheji"); 
   }
    
   calFeiYongHeji2();
   calJing("leijihejixian","leijifeiyonghejixian","leijibiandongxian");
}


//-----------------------限定性净资产转为非限定性净资产-----------------------------------------------
function setSum(result1){

   if(result1==1) {
    calMozhuanHeji3("mozhuanfeixian","mozhuanxian","mozhuanheji"); 
   }else if(result1==2) { 
    calMozhuanHeji3("leijizhuanfeixian","leijizhuanxian","leijizhuanheji"); 
   }else if(result1==3) { 
    calMozhuanHeji3("mobiandongfeixian","mobiandongxian","mobiandongheji"); 
   }else if(result1==4) { 
    calMozhuanHeji3("leijibiandongfeixian","leijibiandongxian","leijibiandongheji"); 
   }

}

function calMozhuanHeji3(ele1,ele2,result){
                
    var sum1=0;
    var obj =  document.getElementById(  ele1);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    var obj =  document.getElementById(  ele2);
          if(obj.value != ""){
             sum1 += parseFloat(obj.value);
          }
    document.getElementById(  result).value = (Math.round(sum1*1000000))/1000000; 
   
   }
</script>
<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	font-size: 12px;
	font-family: '宋体 ';
	font-weight: normal;
	line-height: 18px;
}

table {
	color: #000000;
	font-size: 14px;
	font-family: '宋体 ';
	font-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text {
	font-size: 14px;
	line-height: 20px;
}

.text1 {
	font-size: 16px;
	letter-spacing: normal;
}

.text2 {
	font-size: 16px;
	line-height: 30px;
	letter-spacing: normal;
}

.unnamed1 {
	border: 1 solid #000000;
	font-size: 14px;
}

.unnamed2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 12px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.unnamed4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed5 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed6 {
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.f16ps-size1 {
	border: 1 solid #000000;
	font-size: 16pt;
}

.f16ps-size2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.f16ps-size3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16pt;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f16ps-size4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.boder1 {
	border: 1 solid #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.table {
	font-size: 14px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder-0 {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
}

.boder16pt-0 {
	font-size: 16pt;
	border: 0px none;
	vertical-align: middle;
}

.boderbgh-0 {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	color: #000000;
	background-color: #CCCCCC;
}

.boder0-color {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	background-color: #D8D8D8;
}

.table-text16 {
	font-size: 16px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder16-0 {
	font-size: 16px;
	border: 0px none;
	vertical-align: middle;
}

.title {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}

.title1 {
	font-family: '宋体';
	font-size: 23px;
	font-weight: bold;
	color: #000000;
}

.text-12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	line-height: 21px;
	word-spacing: 120em;
}

.title2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-family: '宋体';
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-size: 23px;
	font-weight: bold;
	color: #000000;
}

.biaoti {
	font-family: '宋体';
	font-size: 15px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt {
	font-family: '黑体';
	font-size: 32px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt1 {
	font-family: '宋体';
	font-size: 20px;
	color: #000000;
}

.minfei-bt2 {
	font-size: 20px;
	font-weight: bold;
	color: #000000;
	letter-spacing: 4pt;
}

.npo-bt {
	font-size: 42px;
	line-height: 25px;
	font-weight: bold;
	color: #000000;
	font-family: '宋体';
	text-indent: 10pt;
}

.npo-zi {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}

.npo-font {
	font-family: '黑体';
	font-size: 20px;
	font-weight: normal;
	color: #000000;
}

.npo-bottomtext {
	font-family: '宋体';
	font-size: 28px;
	line-height: 15px;
	font-weight: bolder;
	color: #000000;
}

.font12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
}

.font12size {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	letter-spacing: 4px;
}

.font16pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.table-text12 {
	font-size: 12px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.font12size1 {
	border: 1 solid #000000;
	font-size: 12px;
	line-height: 20px;
}

.font12size2 {
	line-height: 20px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.font12size3 {
	line-height: 20px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 12px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.font12size4 {
	line-height: 20px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.boder12-0 {
	width:100%;
	font-size: 12px;
	vertical-align: middle;
}

.boder-cal1 {
	width:100%;
	background-color: #F1F1F3;
	font-size: 12px;
	vertical-align: middle;
}

.font-cal {
	background-color: #f1f1f3;
	line-height: 20px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.font-cal2 {
	background-color: #f1f1f3;
	line-height: 20px;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.font-calend {
	background-color: #f1f1f3;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 12px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.font-calend2 {
	background-color: #f1f1f3;
	border-bottom-color: #000000;
	font-size: 12px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.input-line16 {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-family: '宋体';
	color: #000000;
}

.font16fpt {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.font18pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 45px;
}

.input-line16f {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋';
}

.input-line16zc {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋';
	background-position: center center;
	text-align: center;
}

.input-line18 {
	font-size: 18pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '宋体';
	line-height: 40pt;
}

.stb-bt {
	font-family: '黑体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.stb-bt1 {
	font-family: '宋体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.boder18-0 {
	font-size: 18pt;
	border: 0px none;
	vertical-align: middle;
}

.select {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	width: 80px;
}

.font16fpt-001 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.font16pt-001 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.hw-bt {
	font-family: '华文中宋';
	font-size: 26pt;
	font-weight: bold;
	color: #000000;
	letter-spacing: 2pt;
}

.kt-text {
	font-family: '楷体_GB2312';
	font-size: 16pt;
	color: #000000;
	font-weight: normal;
}

.hw-bt2 {
	font-family: '华文中宋';
	font-size: 18pt;
	font-weight: bold;
	color: #000000;
}

.fs-text {
	font-family: '仿宋';
	font-size: 16pt;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
	line-height: 160%;
}

.ht-text {
	font-family: '黑体';
	font-size: 16pt;
	line-height: 110%;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
}

.red {
	font-family: '仿宋';
	font-size: 16pt;
	color: #FF0000;
	line-height: 160%;
	letter-spacing: 1pt;
}

.textarea01 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 1pt;
	border: 1px solid #000000;
	line-height: 160%;
}
</STYLE>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckBusinessActivityDataSet" cmd="com.inspur.cams.sorg.check.businessactivity.cmd.SomCheckBusinessActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity">
			<model:field name="donationIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="donationIncomeTyLimit" type="string" rule="require" />			
			<model:field name="duesIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="duesIncomeTyLimit" type="string" rule="require" />			
			<model:field name="serviceIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="serviceIncomeTyLimit" type="string" rule="require" />			
			<model:field name="productIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="productIncomeTyLimit" type="string" rule="require" />			
			<model:field name="govGrantsTyUnlimit" type="string" rule="require" />
			<model:field name="govGrantsTyLimit" type="string" rule="require" />			
			<model:field name="invIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="invIncomeTyLimit" type="string" rule="require" />
			<model:field name="otherIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="otherIncomeTyLimit" type="string" rule="require" />
			<model:field name="publicWelfarreTyUnlimit" type="string" rule="require" />
			<model:field name="publicWelfarreTyLimit" type="string" rule="require" />
			<model:field name="staffCostTyUnlimit" type="string" rule="require" />
			<model:field name="staffCostTyLimit" type="string" rule="require" />
			<model:field name="runningCostTyUnlimit" type="string" rule="require" />
			<model:field name="runningCostTyLimit" type="string" rule="require" />
			<model:field name="depreciationAssetsTyUnlimit" type="string" rule="require" />
			<model:field name="depreciationAssetsTyLimit" type="string" rule="require" />
			<model:field name="manageCostTyUnlimit" type="string" rule="require" />
			<model:field name="manageCostTyLimit" type="string" rule="require" />
			<model:field name="raisingCostTyUnlimit" type="string" rule="require" />
			<model:field name="raisingCostTyLimit" type="string" rule="require" />
			<model:field name="otherCostTyUnlimit" type="string" rule="require" />
			<model:field name="otherCostTyLimit" type="string" rule="require" />
			<model:field name="limitToUnlimitTyUnlimit" type="string" rule="require" />
			<model:field name="limitToUnlimitTyLimit" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ('23')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ('21')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backJ();"/>
</div>
<div align=center>
<div align=center style="width: 800px">
<form dataset="somJxCheckBusinessActivityDataSet" name="myform" method="post" onsubmit="return false">

<TABLE height=852 cellSpacing=0 cellPadding=0 width=710 align=center
	border=0>
	<TBODY>
		<TR>
			<TD height=53>&nbsp;</TD>
		</TR>
		<TR>
			<TD align=middle width=595 height=30>
			<div align='center'><STRONG>业务活动表</STRONG></div>
			</TD>
		</TR>
		<TR>
			<TD vAlign=top height=769>
			<TABLE height=634 cellSpacing=0 cellPadding=0 width=710 align=center
				border=0>
				<TBODY>
					<TR>
						<TD vAlign=top align=middle>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' align=center
							border=0>
							<TBODY>
								<TR>
									<TD align=right height=22>
									<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
										<TBODY>
											<TR>
												<TD width='33%' height='36' align=right>单位：<span style="color:red">人民币万元</span></TD>
											</TR>
										</TBODY>
									</TABLE>
									</TD>
								</TR>
								<TR>
									<TD height=631>
									<TABLE class=font12size1 cellSpacing=0 cellPadding=0
										width='100%' border=0>
										<TBODY>
											<TR>
												<TD class=unnamed2 align=middle width=19% height=30
													rowSpan=2>项 目</TD>
												<TD class=unnamed2 align=middle width=3% height=30 rowSpan=2>行次</TD>
												<TD class=unnamed2 align=middle colSpan=3 height=30>上年数</TD>
												<TD class=unnamed3 align=middle colSpan=3 height=30>本年累计数</TD>
											</TR>
											<TR>
												<TD class=unnamed2 align=middle width=13% height=30>非限定性</TD>
												<TD class=unnamed2 align=middle width=13% height=30>限定性</TD>
												<TD class=unnamed2 align=middle width=13% height=30>合计</TD>
												<TD class=unnamed2 align=middle width=13% height=30>非限定性</TD>
												<TD class=unnamed2 align=middle width=13% height=30>限定性</TD>
												<TD class=unnamed3 align=middle width=13% height=30>合计</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>一、收 入</TD>
												<TD class=font12size2 align=middle width=3% height=30>&nbsp;</TD>
												<TD class=font12size2 align=middle width=13% height=30>&nbsp;</TD>
												<TD class=font12size2 align=middle width=13% height=30>&nbsp;</TD>
												<TD class=font12size2 width=13% height=30>&nbsp;</TD>
												<TD class=font12size2 align=middle width=13% height=30>&nbsp;</TD>
												<TD class=font12size2 align=middle width=13% height=30>&nbsp;</TD>
												<TD class=unnamed3 align=middle width=13% height=30>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>其中：捐赠收入</TD>
												<TD class=font12size2 align=middle width=3% height=30>1</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mojuanfeixian' value=''
													name='捐赠收入' MAXLENGTH='15' CLASS='boder-cal1' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei1(1);" 
													field="donationIncomePyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mojuanxian' value=''
													name='捐赠收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei2(1);" 
													field="donationIncomePyLimit" style="width: 98%; "
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='mojuanheji' value=''
													name='捐赠收入' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="donationIncomePySum" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijijuanfeixian' value=''
													name='捐赠收入' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei1(1);" 
													field="donationIncomeTyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijijuanxian' value=''
													name='捐赠收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei2(1);" 
													field="donationIncomeTyLimit" style="width: 98%; "
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijijuanheji' value=''
													name='捐赠收入' readonly MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="donationIncomeTySum" style="width: 98%; "
													></TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>会费收入</TD>
												<TD class=font12size2 align=middle width=3% height=30>2</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mohuifeixian' value=''
													name='会费收入' MAXLENGTH='15' CLASS='boder-cal1' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei1(2);" 
													field="duesIncomePyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mohuixian' value=''
													name='会费收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei2(2);" 
													field="duesIncomePyLimit" style="width: 98%; "
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='mohuiheji' value=''
													name='会费收入' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="duesIncomePySum" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijihuifeixian' value=''
													name='会费收入' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei1(2);" 
													field="duesIncomeTyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijihuixian' value=''
													name='会费收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei2(2);" 
													field="duesIncomeTyLimit" style="width: 98%; "
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijihuiheji' value=''
													name='会费收入' readonly MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="duesIncomeTySum" style="width: 98%; "
													></TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>提供服务收入</TD>
												<TD class=font12size2 align=middle width=3% height=30>3</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mofuwufeixian' value=''
													name='提供服务收入' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei1(3);" 
													field="serviceIncomePyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mofuwuxian' value=''
													name='提供服务收入' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei2(3);" 
													field="serviceIncomePyLimit" style="width: 98%; "
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='mofuwuheji' value=''
													name='提供服务收入' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="serviceIncomePySum" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijifuwufeixian' value=''
													name='提供服务收入' MAXLENGTH='15' CLASS='boder12-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei1(3);" 
													field="serviceIncomeTyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijifuwuxian' value=''
													name='提供服务收入' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei2(3);" 
													field="serviceIncomeTyLimit" style="width: 98%; "
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijifuwuheji' value=''
													name='提供服务收入' readonly MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' 
													field="serviceIncomeTySum" style="width: 98%; "
													>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>商品销售收入</TD>
												<TD class=font12size2 align=middle width=3% height=30>4</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moxiaoshoufeixian'
													value='' name='商品销售收入' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei1(4);" 
													field="productIncomePyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moxiaoshouxian' value=''
													name='商品销售收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei2(4);" 
													field="productIncomePyLimit" style="width: 98%; "
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='moxiaoshouheji' value=''
													name='商品销售收入' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="productIncomePySum" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijixiaoshoufeixian'
													value='' name='商品销售收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei1(4);" 
													field="productIncomeTyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijixiaoshouxian'
													value='' name='商品销售收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei2(4);" 
													field="productIncomeTyLimit" style="width: 98%; "
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijixiaoshouheji'
													value='' name='商品销售收入' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="productIncomeTySum" style="width: 98%; "
													></TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>政府补助收入</TD>
												<TD class=font12size2 align=middle width=3% height=30>5</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mobuzhufeixian' value=''
													name='政府补助收入' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei1(5);" 
													field="govGrantsPyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mobuzhuxian' value=''
													name='政府补助收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei2(5);" 
													field="govGrantsPyLimit" style="width: 98%; "
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='mobuzhuheji' value=''
													name='政府补助收入' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="govGrantsPySum" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijibuzhufeixian'
													value='' name='政府补助收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei1(5);" 
													field="govGrantsTyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijibuzhuxian' value=''
													name='政府补助收入' MAXLENGTH='15' CLASS='boder12-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei2(5);" 
													field="govGrantsTyLimit" style="width: 98%; "
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijibuzhuheji' value=''
													name='政府补助收入' readonly MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' 
													field="govGrantsTySum" style="width: 98%; "
													>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>投资收益</TD>
												<TD class=font12size2 align=middle width=3% height=30>6</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='motouzifeixian' value=''
													name='投资收益' MAXLENGTH='15' CLASS='boder-cal1' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei1(6);" 
													field="invIncomePyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='motouzixian' value=''
													name='投资收益' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei2(6);" 
													field="invIncomePyLimit" style="width: 98%; "
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='motouziheji' value=''
													name='投资收益' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="invIncomePySum" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijitouzifeixian'
													value='' name='投资收益' isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder12-0'
													SIZE='14' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei1(6);" 
													field="invIncomeTyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijitouzixian' value=''
													name='投资收益' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei2(6);" 
													field="invIncomeTyLimit" style="width: 98%; "
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijitouziheji' value=''
													name='投资收益' readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="invIncomeTySum" style="width: 98%; "
													>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>其他收入</TD>
												<TD class=font12size2 align=middle width=3% height=30>9</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqitafeixian' value=''
													name='其他收入' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei1(7);" 
													field="otherIncomePyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqitaxian' value=''
													name='其他收入' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumFei2(7);" 
													field="otherIncomePyLimit" style="width: 98%; "
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='moqitaheji' value=''
													name='其他收入' readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="otherIncomePySum" style="width: 98%; "
													>
												</TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqitafeixian' value=''
													name='其他收入' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei1(7);" 
													field="otherIncomeTyUnlimit" style="width: 98%; "
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqitaxian' value=''
													name='其他收入' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumLei2(7);" 
													field="otherIncomeTyLimit" style="width: 98%; "
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijiqitaheji' value=''
													name='其他收入' readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="otherIncomeTySum" style="width: 98%; "
													>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>收入合计</TD>
												<TD class=font12size2 align=middle width=3% height=30>11</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mohejifeixian' value=''
													name='末合计非限'readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="incomeSumPyUnlimit" style="width: 98%; "
													>
												</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mohejixian' value=''
													name='末合计限' readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="incomeSumPyLimit" style="width: 98%; "
													>
												</TD>
												<TD class=font-cal width=13% height=30><input
													id='mohejiheji' value=''
													name='末合计合计'readonly readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="incomeSumPySum" style="width: 98%; "
													>
												</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='leijihejifeixian' value=''
													name='累计合计非限'readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="incomeSumTyUnlimit" style="width: 98%; "
													>
												</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='leijihejixian' value=''
													name='累计合计限'readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="incomeSumTyLimit" style="width: 98%; "
													>
												</TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijihejiheji' value=''
													name='累计合计合计'readonly readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="incomeSumTySum" style="width: 98%; "
													>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>二、费 用</TD>
												<TD class=font12size2 align=middle width=3% height=30>&nbsp;</TD>
												<TD class=font12size2 align=middle width=13% height=30>&nbsp;</TD>
												<TD class=font12size2 align=middle width=13% height=30>&nbsp;</TD>
												<TD class=font12size2 width=13% height=30>&nbsp;</TD>
												<TD class=font12size2 align=middle width=13% height=30>&nbsp;</TD>
												<TD class=font12size2 align=middle width=13% height=30>&nbsp;</TD>
												<TD class=font-calend align=middle width=13% height=30>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>(一)业务活动成本</TD>
												<TD class=font12size2 align=middle width=3% height=30>12</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mochengbenfeixian'
													value='' name='业务活动成本' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder-cal1'
													SIZE='14' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong1(1);" 
													field="businessCostPyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mochengbenxian' value=''
													name='业务活动成本' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong2(1);" 
													field="businessCostPyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='mochengbenheji' value=''
													name='业务活动成本' readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="businessCostPySum" style="width: 98%; " 
													>
												</TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijichengbenfeixian'
													value='' name='业务活动成本' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder12-0'
													SIZE='14' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong3(1);" 
													field="businessCostTyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijichengbenxian'
													value='' name='业务活动成本' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder12-0'
													SIZE='14' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong4(1);" 
													field="businessCostTyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijichengbenheji'
													value='' name='业务活动成本' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="businessCostTySum" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>其中1：公益活动支出<input
													id='qizhong1' value=''
													name='公益活动支出' type='hidden' value='公益活动支出' ></TD>
												<TD class=font12size2 align=middle width=3% height=30>13</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqizhongfeixian1'
													value='' name='公益活动支出' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhong(1,1,4);" 
													field=publicWelfarrePyUnlimit></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqizhongxian1' value=''
													name='公益活动支出' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhong2(1,1,4);" 
													field=publicWelfarrePyLimit></TD>
												<TD class=font-cal width=13% height=30><input
													id='moqizhongheji1' value=''
													name='公益活动支出' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field=publicWelfarrePySun></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqizhongfeixian1'
													value='' name='公益活动支出' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhongLei(1,1,4);" 
													field=publicWelfarreTyUnlimit></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqizhongxian1'
													value='' name='公益活动支出' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhongLei2(1,1,4);" 
													field=publicWelfarreTyLimit></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijiqizhongheji1'
													value='' name='公益活动支出' readonly MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' 
													field=publicWelfarreTySum>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>其中2：</TD>
												<TD class=font12size2 align=middle width=3% height=30>14</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqizhongfeixian2'
													value='' name='末其中非限2' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhong(2,1,4);" field=staffCostPyUnlimit></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqizhongxian2' value=''
													name='末其中限2' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhong2(2,1,4);" field=staffCostPyLimit></TD>
												<TD class=font-cal width=13% height=30><input
													id='moqizhongheji2' value=''
													name='末其中合计2' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													readonly field=staffCostPySum></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqizhongfeixian2'
													value='' name='累计其中非限2' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhongLei(2,1,4);" field=staffCostTyUnlimit></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqizhongxian2'
													value='' name='累计其中限2' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhongLei2(2,1,4);" field=staffCostTyLimit></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijiqizhongheji2'
													value='' name='累计其中合计2' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' readonly field=staffCostTySum>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>其中3：</TD>
												<TD class=font12size2 align=middle width=3% height=30>15</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqizhongfeixian3'
													value='' name='末其中非限3' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhong(3,1,4);" field=runningCostPyUnlimit></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqizhongxian3' value=''
													name='末其中限3' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhong2(3,1,4);" field=runningCostPyLimit></TD>
												<TD class=font-cal width=13% height=30><input
													id='moqizhongheji3' value=''
													name='末其中合计3' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' readonly field=runningCostPySum>
												</TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqizhongfeixian3'
													value='' name='累计其中非限3' MAXLENGTH='15' CLASS='boder12-0'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhongLei(3,1,4);" field=runningCostTyUnlimit></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqizhongxian3'
													value='' name='累计其中限3' MAXLENGTH='15' CLASS='boder12-0'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhongLei2(3,1,4);" field=runningCostTyLimit></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijiqizhongheji3'
													value='' name='累计其中合计3' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' readonly field=runningCostTySum>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>其中4：</TD>
												<TD class=font12size2 align=middle width=3% height=30>16</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqizhongfeixian4'
													value='' name='末其中非限4' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhong(4,1,4);"  field=depreciationAssetsPyUnlimit></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqizhongxian4' value=''
													name='末其中限4' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhong2(4,1,4);"  field=depreciationAssetsPyLimit></TD>
												<TD class=font-cal width=13% height=30><input
													id='moqizhongheji4' value=''
													name='末其中合计4' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' readonly field=depreciationAssetsPySum>
												</TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqizhongfeixian4'
													value='' name='累计其中非限4' MAXLENGTH='15' CLASS='boder12-0'
													SIZE='14' isMoney='true' style='text-align:right;padding-right:2px;'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhongLei(4,1,4);"  field=depreciationAssetsTyUnlimit></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqizhongxian4'
													value='' name='累计其中限4' MAXLENGTH='15' CLASS='boder12-0'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumQizhongLei2(4,1,4);"  field=depreciationAssetsTyLimit></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijiqizhongheji4'
													value='' name='累计其中合计4' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' readonly field=depreciationAssetsTySum>
												</TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>（二）管理费用</TD>
												<TD class=font12size2 align=middle width=3% height=30>21</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moguanlifeixian' value=''
													name='管理费用' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong1(2);" 
													field="manageCostPyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moguanlixian' value=''
													name='管理费用' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong2(2);" 
													field="manageCostPyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='moguanliheji' value=''
													name='管理费用' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="manageCostPySum" style="width: 98%; " 
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiguanlifeixian'
													value='' name='管理费用' MAXLENGTH='15' CLASS='boder12-0'
													SIZE='14' isMoney='true' style='text-align:right;padding-right:2px;'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong3(2);" 
													field="manageCostTyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiguanlixian' value=''
													name='管理费用' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong4(2);" 
													field="manageCostTyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijiguanliheji' value=''
													name='管理费用' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="manageCostTySumlimit" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>（三）筹资费用</TD>
												<TD class=font12size2 align=middle width=3% height=30>24</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mochouzifeixian' value=''
													name='筹资费用' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong1(3);" 
													field="raisingCostPyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mochouzixian' value=''
													name='筹资费用' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong2(3);" 
													field="raisingCostPyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='mochouziheji' value=''
													name='筹资费用' readonly MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="raisingCostPySum" style="width: 98%; " 
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijichouzifeixian'
													value='' name='筹资费用' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong3(3);" 
													field="raisingCostTyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijichouzixian' value=''
													name='筹资费用' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong4(3);" 
													field="raisingCostTyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijichouziheji' value=''
													name='筹资费用' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="raisingCostTySum" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>（四）其他费用</TD>
												<TD class=font12size2 align=middle width=3% height=30>28</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqitafeiyongfei' value=''
													name='其他费用' MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong1(4);" 
													field="otherCostPyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='moqitafeiyongxian'
													value='' name='其他费用' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong2(4);" 
													field="otherCostPyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='moqitafeiyongheji'
													value='' name='其他费用' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="otherCostPySum" style="width: 98%; " 
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqitafeiyongfeixian'
													value='' name='其他费用' MAXLENGTH='15' CLASS='boder12-0'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong3(4);" 
													field="otherCostTyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijiqitafeiyongxian'
													value='' name='其他费用' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYong4(4);" 
													field="otherCostTyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijiqitafeiyongheji'
													value='' name='其他费用' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="otherCostTySum" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=font12size2 align=middle width=19% height=30>费用合计</TD>
												<TD class=font12size2 align=middle width=3% height=30>35</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mofeiyonghejifei' value=''
													name='末费用合计非' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="costSumPyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mofeiyonghejixian'
													value='' name='末费用合计限'readonly MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' 
													field="costSumPyLimit" style="width: 98%; " 
													>
												</TD>
												<TD class=font-cal width=13% height=30><input
													id='mofeiyonghejiheji'
													value='' name='末费用合计合计' readonly MAXLENGTH='15' CLASS='boder-cal1'
													isMoney='true' style='text-align:right;padding-right:2px;' SIZE='14' 
													field="costSumPySum" style="width: 98%; " 
													>
												</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='leijifeiyonghejifei'
													value='' name='累计费用合计非'readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="costSumTyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='leijifeiyonghejixian'
													value='' name='累计费用合计限'readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="costSumTyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijifeiyonghejiheji'
													value='' name='累计费用合计合计' readonly MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal1' SIZE='14'
													field="costSumTySum" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=font12size2 width=19% height=30>三、限定性净资产转为非限定性净资产</TD>
												<TD class=font12size2 align=middle width=3% height=30>40</TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mozhuanfeixian' value=''
													name='限定性净资产转为非限定性净资产' MAXLENGTH='15' CLASS='boder-cal1' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1);"
													field="limitToUnlimitPyUnlimt" style="width: 98%; " 
													></TD>
												<TD class=font-cal align=middle width=13% height=30><input
													id='mozhuanxian' value=''
													name='限定性净资产转为非限定性净资产' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1);" 
													field="limitToUnlimitPyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-cal width=13% height=30><input
													id='mozhuanheji' value=''
													name='限定性净资产转为非限定性净资产' readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="limitToUnlimitPySum" style="width: 98%; " 
													>
												</TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijizhuanfeixian'
													value='' name='限定性净资产转为非限定性净资产' isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder12-0'
													SIZE='14' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2);" 
													field="limitToUnlimitTyUnlimit" style="width: 98%; " 
													></TD>
												<TD class=font12size2 align=middle width=13% height=30><input
													id='leijizhuanxian' value=''
													name='限定性净资产转为非限定性净资产' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder12-0' SIZE='14'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2);" 
													field="limitToUnlimitTyLimit" style="width: 98%; " 
													></TD>
												<TD class=font-calend align=middle width=13% height=30><input
													id='leijizhuanheji' value=''
													name='限定性净资产转为非限定性净资产' readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="limitToUnlimitTySum" style="width: 98%; " 
													>
												</TD>
											</TR>
											<TR>
												<TD class=font12size4 width=19% height=56>四、净资产变动额（若为净资产减少额，以“-”号填列）</TD>
												<TD class=font12size4 align=middle width=3% height=56>45</TD>
												<TD class=font-cal2 align=middle width=13% height=56><input
													id='mobiandongfeixian'
													value='' name='净资产变动额' isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder-cal1'
													SIZE='14' onKeyUp="value=value.replace(/[^\d-]/g,'');setSum(3);" 
													field="assetsChangePyUnlimit" style="width: 98%; " 
													readonly></TD>
												<TD class=font-cal2 align=middle width=13% height=56><input
													id='mobiandongxian' value=''
													name='净资产变动额' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14'
													onKeyUp="value=value.replace(/[^\d-]/g,'');setSum(3);" 
													field="assetsChangePyLimit" style="width: 98%; " 
													readonly></TD>
												<TD class=font-cal2 width=13% height=56><input
													id='mobiandongheji' value=''
													name='净资产变动额' readonly isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal1' SIZE='14' 
													field="assetsChangePySum" style="width: 98%; " 
													>
												</TD>
												<TD class=font12size4 align=middle width=13% height=56><input
													id='leijibiandongfeixian'
													value='' name='净资产变动额' isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder12-0'
													SIZE='14' onKeyUp="value=value.replace(/[^\d-]/g,'');setSum(4);" 
													field="assetsChangeTyUnlimit" style="width: 98%; " 
													readonly></TD>
												<TD class=font12size4 align=middle width=13% height=56><input
													id='leijibiandongxian'
													value='' name='净资产变动额' isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder12-0'
													SIZE='14' onKeyUp="value=value.replace(/[^\d-]/g,'');setSum(4);" 
													field="assetsChangeTyLimit" style="width: 98%; " 
													readonly></TD>
												<TD class=font-calend2 align=middle width=13% height=56><input
													id='leijibiandongheji'
													value='' name='净资产变动额' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' MAXLENGTH='15' CLASS='boder-cal1'
													SIZE='14' 
													field="assetsChangeTySum" style="width: 98%; " 
													></TD>
											</TR>
										</TBODY>
									</TABLE>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<table width='668' border='0' align='center' cellpadding='0'
	cellspacing='0'>
	<tr>
		<td width='669' height='30' align='left'>说明：银行存款利息计入其他收入</td>
	</tr>
	<tr>
		<td align='center'></td>
	</tr>
</table>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		第22页</td>
	</tr>
</TABLE>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
