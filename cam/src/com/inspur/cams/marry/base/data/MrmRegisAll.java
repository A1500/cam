package com.inspur.cams.marry.base.data; 

import java.math.BigDecimal;
import java.util.Date;

import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:MrmRegisArea
 * @description:
 * @author:
 * @since:2011-11-26
 * @version:1.0
*/
// @Table(tableName = "MRM_REGIS_AREA" , keyFields = "functionId")
public class MrmRegisAll extends StatefulDatabean {	
   //登记机关ID
   private String deptId;   
   //登记机关名称
   private String deptName;    
   //咨询电话
   private String deptTel;
   //网址
   private String homeUrl;
   //实际人口数量
   private String deptNumRy;
   //编制性质
   private String types;
   //工作经费：上年度拨付
   private String lastYearBudget;
   //工作经费：本年度拨付
   private String thisYearBudget;
   
   //颁证大厅面积
   private BigDecimal bzdtArea;   
   //辅导区面积
   private BigDecimal fdsArea;  
   //间数
   private BigDecimal jianShu;
   //候登大厅座椅
   private BigDecimal hdChair;  
   //填表区座椅
   private BigDecimal tbChair;
   //离婚登记区面积
   private BigDecimal lhArea;  
   //离婚登记区窗口
   private BigDecimal lhWindow; 
   //结婚登记区面积
   private BigDecimal marryArea;  
   //结婚登记区窗口
   private BigDecimal marryWindow;
   //电脑
   private BigDecimal computer;
   //打印机
   private BigDecimal printer;
   //身份识别系统
   private BigDecimal cardReader;
   
   //复印机
   private BigDecimal fyj;
   //传真机
   private BigDecimal czj;
   //扫描仪 
   private BigDecimal smy;
   //电视机
   private BigDecimal dsj;
   // 读卡器 
   private BigDecimal dkq;
   //叫号机 
   private BigDecimal jhj;
   //电子显示屏 
   private BigDecimal dzxsp;
   //监控设备
   private BigDecimal jksb;
   //亲友观礼席
   private BigDecimal qyglx;
   //无障碍通道 
   private BigDecimal wzatd;
   //服务评价系统 
   private BigDecimal fwpjxt;
   //卫生间
   private String wc;
   //结婚登记数
   private BigDecimal marryNum;
   //离婚登记数
   private BigDecimal divorceNum;
   //补发婚姻登记证
   private BigDecimal reissueNum;
   //出具(无)婚姻登记员证明数量
   private BigDecimal attestNum;
   //上年度工作量
   private BigDecimal AllNum;
   //登记员
   private BigDecimal djyNum;
   //颁证员人数
   private BigDecimal bzyNum;
   //行政编制
   private BigDecimal xzbzNum;
   //参公管理事业编
   private BigDecimal cgglNum;
   //全额拨款事业编
   private BigDecimal qebkNum;
   
   //辅导员人数
   private BigDecimal fdyNum;
   //政府购买人数
   private BigDecimal zfgmNum;
   //志愿者人数
   private BigDecimal zyzNum;
   //公开招募
   private BigDecimal gkzmNum;
   //其他情况
   private String qtqksc;
   //网络预约系统启用时间
   private String wlyyqysj;
   //网络预约量
   private BigDecimal wlyyl;
   //上年度预约量
   private BigDecimal sndyyl;
   //在线时间
   private String zxsj;
   //联网时间
   private String lwsj;
   
   //补录时间
   private Date blsj;
   //补录数据量（万条）
   private BigDecimal blNum;
   @Transient		
   //成立 时间
   private String createDate;
   
   
   
public String getCreateDate() {
	return createDate;
}
public void setCreateDate(String createDate) {
	this.createDate = createDate;
}
public BigDecimal getJianShu() {
	return jianShu;
}
public void setJianShu(BigDecimal jianShu) {
	this.jianShu = jianShu;
}
public BigDecimal getDjyNum() {
	return djyNum;
}
public void setDjyNum(BigDecimal djyNum) {
	this.djyNum = djyNum;
}
public BigDecimal getBzyNum() {
	return bzyNum;
}
public void setBzyNum(BigDecimal bzyNum) {
	this.bzyNum = bzyNum;
}
public BigDecimal getXzbzNum() {
	return xzbzNum;
}
public void setXzbzNum(BigDecimal xzbzNum) {
	this.xzbzNum = xzbzNum;
}
public BigDecimal getCgglNum() {
	return cgglNum;
}
public void setCgglNum(BigDecimal cgglNum) {
	this.cgglNum = cgglNum;
}
public BigDecimal getQebkNum() {
	return qebkNum;
}
public void setQebkNum(BigDecimal qebkNum) {
	this.qebkNum = qebkNum;
}
public BigDecimal getBzdtArea() {
	return bzdtArea;
}
public void setBzdtArea(BigDecimal bzdtArea) {
	this.bzdtArea = bzdtArea;
}
public BigDecimal getFdsArea() {
	return fdsArea;
}
public void setFdsArea(BigDecimal fdsArea) {
	this.fdsArea = fdsArea;
}
public BigDecimal getHdChair() {
	return hdChair;
}
public void setHdChair(BigDecimal hdChair) {
	this.hdChair = hdChair;
}
public BigDecimal getLhArea() {
	return lhArea;
}
public void setLhArea(BigDecimal lhArea) {
	this.lhArea = lhArea;
}
public BigDecimal getLhWindow() {
	return lhWindow;
}
public void setLhWindow(BigDecimal lhWindow) {
	this.lhWindow = lhWindow;
}
public BigDecimal getMarryArea() {
	return marryArea;
}
public void setMarryArea(BigDecimal marryArea) {
	this.marryArea = marryArea;
}
public BigDecimal getMarryWindow() {
	return marryWindow;
}
public void setMarryWindow(BigDecimal marryWindow) {
	this.marryWindow = marryWindow;
}
public String getDeptId() {
	return deptId;
}
public void setDeptId(String deptId) {
	this.deptId = deptId;
}
public String getDeptName() {
	return deptName;
}
public void setDeptName(String deptName) {
	this.deptName = deptName;
}
public String getDeptTel() {
	return deptTel;
}
public void setDeptTel(String deptTel) {
	this.deptTel = deptTel;
}
public String getHomeUrl() {
	return homeUrl;
}
public void setHomeUrl(String homeUrl) {
	this.homeUrl = homeUrl;
}
public String getDeptNumRy() {
	return deptNumRy;
}
public void setDeptNumRy(String deptNumRy) {
	this.deptNumRy = deptNumRy;
}
public String getTypes() {
	return types;
}
public void setTypes(String types) {
	this.types = types;
}
public BigDecimal getTbChair() {
	return tbChair;
}
public void setTbChair(BigDecimal tbChair) {
	this.tbChair = tbChair;
}
public BigDecimal getFyj() {
	return fyj;
}
public void setFyj(BigDecimal fyj) {
	this.fyj = fyj;
}
public BigDecimal getCzj() {
	return czj;
}
public void setCzj(BigDecimal czj) {
	this.czj = czj;
}
public BigDecimal getSmy() {
	return smy;
}
public void setSmy(BigDecimal smy) {
	this.smy = smy;
}
public BigDecimal getDsj() {
	return dsj;
}
public void setDsj(BigDecimal dsj) {
	this.dsj = dsj;
}
public BigDecimal getDkq() {
	return dkq;
}
public void setDkq(BigDecimal dkq) {
	this.dkq = dkq;
}
public BigDecimal getJhj() {
	return jhj;
}
public void setJhj(BigDecimal jhj) {
	this.jhj = jhj;
}
public BigDecimal getDzxsp() {
	return dzxsp;
}
public void setDzxsp(BigDecimal dzxsp) {
	this.dzxsp = dzxsp;
}
public BigDecimal getJksb() {
	return jksb;
}
public void setJksb(BigDecimal jksb) {
	this.jksb = jksb;
}
public BigDecimal getQyglx() {
	return qyglx;
}
public void setQyglx(BigDecimal qyglx) {
	this.qyglx = qyglx;
}
public BigDecimal getWzatd() {
	return wzatd;
}
public void setWzatd(BigDecimal wzatd) {
	this.wzatd = wzatd;
}
public BigDecimal getFwpjxt() {
	return fwpjxt;
}
public void setFwpjxt(BigDecimal fwpjxt) {
	this.fwpjxt = fwpjxt;
} 
public String getWc() {
	return wc;
}
public void setWc(String wc) {
	this.wc = wc;
}
public BigDecimal getComputer() {
	return computer;
}
public void setComputer(BigDecimal computer) {
	this.computer = computer;
}
public BigDecimal getPrinter() {
	return printer;
}
public void setPrinter(BigDecimal printer) {
	this.printer = printer;
}
public BigDecimal getCardReader() {
	return cardReader;
}
public void setCardReader(BigDecimal cardReader) {
	this.cardReader = cardReader;
}
public BigDecimal getMarryNum() {
	return marryNum;
}
public void setMarryNum(BigDecimal marryNum) {
	this.marryNum = marryNum;
}
public BigDecimal getDivorceNum() {
	return divorceNum;
}
public void setDivorceNum(BigDecimal divorceNum) {
	this.divorceNum = divorceNum;
}
public BigDecimal getReissueNum() {
	return reissueNum;
}
public void setReissueNum(BigDecimal reissueNum) {
	this.reissueNum = reissueNum;
}
public BigDecimal getAttestNum() {
	return attestNum;
}
public void setAttestNum(BigDecimal attestNum) {
	this.attestNum = attestNum;
}
public BigDecimal getAllNum() {
	return AllNum;
}
public void setAllNum(BigDecimal allNum) {
	AllNum = allNum;
}
public String getLastYearBudget() {
	return lastYearBudget;
}
public void setLastYearBudget(String lastYearBudget) {
	this.lastYearBudget = lastYearBudget;
}
public String getThisYearBudget() {
	return thisYearBudget;
}
public void setThisYearBudget(String thisYearBudget) {
	this.thisYearBudget = thisYearBudget;
}
public BigDecimal getFdyNum() {
	return fdyNum;
}
public void setFdyNum(BigDecimal fdyNum) {
	this.fdyNum = fdyNum;
}
public BigDecimal getZfgmNum() {
	return zfgmNum;
}
public void setZfgmNum(BigDecimal zfgmNum) {
	this.zfgmNum = zfgmNum;
}
public BigDecimal getZyzNum() {
	return zyzNum;
}
public void setZyzNum(BigDecimal zyzNum) {
	this.zyzNum = zyzNum;
}
public BigDecimal getGkzmNum() {
	return gkzmNum;
}
public void setGkzmNum(BigDecimal gkzmNum) {
	this.gkzmNum = gkzmNum;
}
public String getQtqksc() {
	return qtqksc;
}
public void setQtqksc(String qtqksc) {
	this.qtqksc = qtqksc;
}
public String getWlyyqysj() {
	return wlyyqysj;
}
public void setWlyyqysj(String wlyyqysj) {
	this.wlyyqysj = wlyyqysj;
}
public BigDecimal getWlyyl() {
	return wlyyl;
}
public void setWlyyl(BigDecimal wlyyl) {
	this.wlyyl = wlyyl;
}
public BigDecimal getSndyyl() {
	return sndyyl;
}
public void setSndyyl(BigDecimal sndyyl) {
	this.sndyyl = sndyyl;
}
public String getZxsj() {
	return zxsj;
}
public void setZxsj(String zxsj) {
	this.zxsj = zxsj;
}
public String getLwsj() {
	return lwsj;
}
public void setLwsj(String lwsj) {
	this.lwsj = lwsj;
}
 
public Date getBlsj() {
	return blsj;
}
public void setBlsj(Date blsj) {
	this.blsj = blsj;
}
public BigDecimal getBlNum() {
	return blNum;
}
public void setBlNum(BigDecimal blNum) {
	this.blNum = blNum;
}
 
    }