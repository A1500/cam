package com.inspur.sdmz.jtxxcyxx.dao; 

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:YgjzJtxxCyxx
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 @Table(tableName = "YGJZ_JTXX_CYXX" , keyFields = "cyid")
public class YgjzJtxxCyxx extends StatefulDatabean {	
   //成员ID
   	@Rule(value="require")   
	@Column(name = "CYID")
   private String cyid;   
   //家庭ID
   	@Rule(value="require") 
	@Column(name = "JTID")
   private String jtid;   
   //姓名   
	@Column(name = "HZXM")
   private String hzxm;   
   //身份证号   
	@Column(name = "SFZH")
   private String sfzh;   
   //身份证扩展码   
	@Column(name = "SFZH_KZM")
   private String sfzhKzm;   
   //户主关系   
	@Column(name = "HZGXDM")
   private String hzgxdm;   
   //性别   
	@Column(name = "XBDM")
   private String xbdm;   
   //出生日期   
	@Column(name = "CSRQ")
   private String csrq;   
   //户籍性质   
	@Column(name = "HJXZDM")
   private String hjxzdm;   
   //民族   
	@Column(name = "MZDM")
   private String mzdm;   
   //婚姻状况   
	@Column(name = "HYZKDM")
   private String hyzkdm;   
   //联系方式_手机   
	@Column(name = "SJHM")
   private String sjhm;   
   //联系方式_其他   
	@Column(name = "QT")
   private String qt;   
   //医疗状况   
	@Column(name = "YLZKDM")
   private String ylzkdm;   
   //年收入
   	@Rule(value="number")   
	@Column(name = "NSR_JE")
   private BigDecimal nsrJe;   
   //月收入
   	@Rule(value="number")   
	@Column(name = "YSR_JE")
   private BigDecimal ysrJe;   
   //职业状况   
	@Column(name = "JYZKDM")
   private String jyzkdm;   
   //工作单位_名称   
	@Column(name = "GZDW_MC")
   private String gzdwMc;   
   //工作单位_电话   
	@Column(name = "GZDW_DH")
   private String gzdwDh;   
   //工作单位_地址   
	@Column(name = "GZDW_DZ")
   private String gzdwDz;   
   //优抚对象类型   
	@Column(name = "WFDXLXDM")
   private String wfdxlxdm;   
   //抚恤定补金
   	@Rule(value="number")   
	@Column(name = "FXDB_JE")
   private BigDecimal fxdbJe;   
   //残疾类型   
	@Column(name = "CJLXDM")
   private String cjlxdm;   
   //残疾等级   
	@Column(name = "CJDJDM")
   private String cjdjdm;   
   //成员状态标志   
	@Column(name = "CYZTBZ")
   private String cyztbz;   
   //录入人姓名   
	@Column(name = "LRRXM")
   private String lrrxm;   
   //录入人ID   
	@Column(name = "LRR_ID")
   private String lrrId;   
   //录入单位区划   
	@Column(name = "LRDWQH")
   private String lrdwqh;   
   //录入单位名称   
	@Column(name = "LRDWMC")
   private String lrdwmc;   
   //录入单位ID   
	@Column(name = "LRDW_ID")
   private String lrdwId;   
   //录入时间   
	@Column(name = "LRSJ")
   private String lrsj;   
   //修改人姓名   
	@Column(name = "XGRXM")
   private String xgrxm;   
   //修改人ID   
	@Column(name = "XGR_ID")
   private String xgrId;   
   //修改单位区划   
	@Column(name = "XGDWQH")
   private String xgdwqh;   
   //修改单位名称   
	@Column(name = "XGDWMC")
   private String xgdwmc;   
   //修改单位ID   
	@Column(name = "XGDW_ID")
   private String xgdwId;   
   //修改时间   
	@Column(name = "XGSJ")
   private String xgsj;   
   //审核人姓名   
	@Column(name = "SHRXM")
   private String shrxm;   
   //审核人ID   
	@Column(name = "SHR_ID")
   private String shrId;   
   //审核单位区划   
	@Column(name = "SHDWQH")
   private String shdwqh;   
   //审核单位名称   
	@Column(name = "SHDWMC")
   private String shdwmc;   
   //审核单位ID   
	@Column(name = "SHDW_ID")
   private String shdwId;   
   //审核标志   
	@Column(name = "SHBZ")
   private String shbz;   
   //审核时间   
	@Column(name = "SHSJ")
   private String shsj;   
   //删除标志   
	@Column(name = "SCBZ")
   private String scbz;      
   /** 
    * getter for 成员ID
    * @generated
    */
   public String getCyid(){
      return this.cyid;
   }   
   /** 
    * setter for 成员ID
    * @generated
    */
   public void setCyid(String cyid){
      this.cyid = cyid;	
   }  
   
   /** 
    * getter for 家庭ID
    * @generated
    */
   public String getJtid(){
      return this.jtid;
   }   
   /** 
    * setter for 家庭ID
    * @generated
    */
   public void setJtid(String jtid){
      this.jtid = jtid;	
   }  
   
   /** 
    * getter for 姓名
    * @generated
    */
   public String getHzxm(){
      return this.hzxm;
   }   
   /** 
    * setter for 姓名
    * @generated
    */
   public void setHzxm(String hzxm){
      this.hzxm = hzxm;	
   }  
   
   /** 
    * getter for 身份证号
    * @generated
    */
   public String getSfzh(){
      return this.sfzh;
   }   
   /** 
    * setter for 身份证号
    * @generated
    */
   public void setSfzh(String sfzh){
      this.sfzh = sfzh;	
   }  
   
   /** 
    * getter for 身份证扩展码
    * @generated
    */
   public String getSfzhKzm(){
      return this.sfzhKzm;
   }   
   /** 
    * setter for 身份证扩展码
    * @generated
    */
   public void setSfzhKzm(String sfzhKzm){
      this.sfzhKzm = sfzhKzm;	
   }  
   
   /** 
    * getter for 户主关系
    * @generated
    */
   public String getHzgxdm(){
      return this.hzgxdm;
   }   
   /** 
    * setter for 户主关系
    * @generated
    */
   public void setHzgxdm(String hzgxdm){
      this.hzgxdm = hzgxdm;	
   }  
   
   /** 
    * getter for 性别
    * @generated
    */
   public String getXbdm(){
      return this.xbdm;
   }   
   /** 
    * setter for 性别
    * @generated
    */
   public void setXbdm(String xbdm){
      this.xbdm = xbdm;	
   }  
   
   /** 
    * getter for 出生日期
    * @generated
    */
   public String getCsrq(){
      return this.csrq;
   }   
   /** 
    * setter for 出生日期
    * @generated
    */
   public void setCsrq(String csrq){
      this.csrq = csrq;	
   }  
   
   /** 
    * getter for 户籍性质
    * @generated
    */
   public String getHjxzdm(){
      return this.hjxzdm;
   }   
   /** 
    * setter for 户籍性质
    * @generated
    */
   public void setHjxzdm(String hjxzdm){
      this.hjxzdm = hjxzdm;	
   }  
   
   /** 
    * getter for 民族
    * @generated
    */
   public String getMzdm(){
      return this.mzdm;
   }   
   /** 
    * setter for 民族
    * @generated
    */
   public void setMzdm(String mzdm){
      this.mzdm = mzdm;	
   }  
   
   /** 
    * getter for 婚姻状况
    * @generated
    */
   public String getHyzkdm(){
      return this.hyzkdm;
   }   
   /** 
    * setter for 婚姻状况
    * @generated
    */
   public void setHyzkdm(String hyzkdm){
      this.hyzkdm = hyzkdm;	
   }  
   
   /** 
    * getter for 联系方式_手机
    * @generated
    */
   public String getSjhm(){
      return this.sjhm;
   }   
   /** 
    * setter for 联系方式_手机
    * @generated
    */
   public void setSjhm(String sjhm){
      this.sjhm = sjhm;	
   }  
   
   /** 
    * getter for 联系方式_其他
    * @generated
    */
   public String getQt(){
      return this.qt;
   }   
   /** 
    * setter for 联系方式_其他
    * @generated
    */
   public void setQt(String qt){
      this.qt = qt;	
   }  
   
   /** 
    * getter for 医疗状况
    * @generated
    */
   public String getYlzkdm(){
      return this.ylzkdm;
   }   
   /** 
    * setter for 医疗状况
    * @generated
    */
   public void setYlzkdm(String ylzkdm){
      this.ylzkdm = ylzkdm;	
   }  
   
   /** 
    * getter for 年收入
    * @generated
    */
   public BigDecimal getNsrJe(){
      return this.nsrJe;
   }   
   /** 
    * setter for 年收入
    * @generated
    */
   public void setNsrJe(BigDecimal nsrJe){
      this.nsrJe = nsrJe;	
   }  
   
   /** 
    * getter for 月收入
    * @generated
    */
   public BigDecimal getYsrJe(){
      return this.ysrJe;
   }   
   /** 
    * setter for 月收入
    * @generated
    */
   public void setYsrJe(BigDecimal ysrJe){
      this.ysrJe = ysrJe;	
   }  
   
   /** 
    * getter for 职业状况
    * @generated
    */
   public String getJyzkdm(){
      return this.jyzkdm;
   }   
   /** 
    * setter for 职业状况
    * @generated
    */
   public void setJyzkdm(String jyzkdm){
      this.jyzkdm = jyzkdm;	
   }  
   
   /** 
    * getter for 工作单位_名称
    * @generated
    */
   public String getGzdwMc(){
      return this.gzdwMc;
   }   
   /** 
    * setter for 工作单位_名称
    * @generated
    */
   public void setGzdwMc(String gzdwMc){
      this.gzdwMc = gzdwMc;	
   }  
   
   /** 
    * getter for 工作单位_电话
    * @generated
    */
   public String getGzdwDh(){
      return this.gzdwDh;
   }   
   /** 
    * setter for 工作单位_电话
    * @generated
    */
   public void setGzdwDh(String gzdwDh){
      this.gzdwDh = gzdwDh;	
   }  
   
   /** 
    * getter for 工作单位_地址
    * @generated
    */
   public String getGzdwDz(){
      return this.gzdwDz;
   }   
   /** 
    * setter for 工作单位_地址
    * @generated
    */
   public void setGzdwDz(String gzdwDz){
      this.gzdwDz = gzdwDz;	
   }  
   
   /** 
    * getter for 优抚对象类型
    * @generated
    */
   public String getWfdxlxdm(){
      return this.wfdxlxdm;
   }   
   /** 
    * setter for 优抚对象类型
    * @generated
    */
   public void setWfdxlxdm(String wfdxlxdm){
      this.wfdxlxdm = wfdxlxdm;	
   }  
   
   /** 
    * getter for 抚恤定补金
    * @generated
    */
   public BigDecimal getFxdbJe(){
      return this.fxdbJe;
   }   
   /** 
    * setter for 抚恤定补金
    * @generated
    */
   public void setFxdbJe(BigDecimal fxdbJe){
      this.fxdbJe = fxdbJe;	
   }  
   
   /** 
    * getter for 残疾类型
    * @generated
    */
   public String getCjlxdm(){
      return this.cjlxdm;
   }   
   /** 
    * setter for 残疾类型
    * @generated
    */
   public void setCjlxdm(String cjlxdm){
      this.cjlxdm = cjlxdm;	
   }  
   
   /** 
    * getter for 残疾等级
    * @generated
    */
   public String getCjdjdm(){
      return this.cjdjdm;
   }   
   /** 
    * setter for 残疾等级
    * @generated
    */
   public void setCjdjdm(String cjdjdm){
      this.cjdjdm = cjdjdm;	
   }  
   
   /** 
    * getter for 成员状态标志
    * @generated
    */
   public String getCyztbz(){
      return this.cyztbz;
   }   
   /** 
    * setter for 成员状态标志
    * @generated
    */
   public void setCyztbz(String cyztbz){
      this.cyztbz = cyztbz;	
   }  
   
   /** 
    * getter for 录入人姓名
    * @generated
    */
   public String getLrrxm(){
      return this.lrrxm;
   }   
   /** 
    * setter for 录入人姓名
    * @generated
    */
   public void setLrrxm(String lrrxm){
      this.lrrxm = lrrxm;	
   }  
   
   /** 
    * getter for 录入人ID
    * @generated
    */
   public String getLrrId(){
      return this.lrrId;
   }   
   /** 
    * setter for 录入人ID
    * @generated
    */
   public void setLrrId(String lrrId){
      this.lrrId = lrrId;	
   }  
   
   /** 
    * getter for 录入单位区划
    * @generated
    */
   public String getLrdwqh(){
      return this.lrdwqh;
   }   
   /** 
    * setter for 录入单位区划
    * @generated
    */
   public void setLrdwqh(String lrdwqh){
      this.lrdwqh = lrdwqh;	
   }  
   
   /** 
    * getter for 录入单位名称
    * @generated
    */
   public String getLrdwmc(){
      return this.lrdwmc;
   }   
   /** 
    * setter for 录入单位名称
    * @generated
    */
   public void setLrdwmc(String lrdwmc){
      this.lrdwmc = lrdwmc;	
   }  
   
   /** 
    * getter for 录入单位ID
    * @generated
    */
   public String getLrdwId(){
      return this.lrdwId;
   }   
   /** 
    * setter for 录入单位ID
    * @generated
    */
   public void setLrdwId(String lrdwId){
      this.lrdwId = lrdwId;	
   }  
   
   /** 
    * getter for 录入时间
    * @generated
    */
   public String getLrsj(){
      return this.lrsj;
   }   
   /** 
    * setter for 录入时间
    * @generated
    */
   public void setLrsj(String lrsj){
      this.lrsj = lrsj;	
   }  
   
   /** 
    * getter for 修改人姓名
    * @generated
    */
   public String getXgrxm(){
      return this.xgrxm;
   }   
   /** 
    * setter for 修改人姓名
    * @generated
    */
   public void setXgrxm(String xgrxm){
      this.xgrxm = xgrxm;	
   }  
   
   /** 
    * getter for 修改人ID
    * @generated
    */
   public String getXgrId(){
      return this.xgrId;
   }   
   /** 
    * setter for 修改人ID
    * @generated
    */
   public void setXgrId(String xgrId){
      this.xgrId = xgrId;	
   }  
   
   /** 
    * getter for 修改单位区划
    * @generated
    */
   public String getXgdwqh(){
      return this.xgdwqh;
   }   
   /** 
    * setter for 修改单位区划
    * @generated
    */
   public void setXgdwqh(String xgdwqh){
      this.xgdwqh = xgdwqh;	
   }  
   
   /** 
    * getter for 修改单位名称
    * @generated
    */
   public String getXgdwmc(){
      return this.xgdwmc;
   }   
   /** 
    * setter for 修改单位名称
    * @generated
    */
   public void setXgdwmc(String xgdwmc){
      this.xgdwmc = xgdwmc;	
   }  
   
   /** 
    * getter for 修改单位ID
    * @generated
    */
   public String getXgdwId(){
      return this.xgdwId;
   }   
   /** 
    * setter for 修改单位ID
    * @generated
    */
   public void setXgdwId(String xgdwId){
      this.xgdwId = xgdwId;	
   }  
   
   /** 
    * getter for 修改时间
    * @generated
    */
   public String getXgsj(){
      return this.xgsj;
   }   
   /** 
    * setter for 修改时间
    * @generated
    */
   public void setXgsj(String xgsj){
      this.xgsj = xgsj;	
   }  
   
   /** 
    * getter for 审核人姓名
    * @generated
    */
   public String getShrxm(){
      return this.shrxm;
   }   
   /** 
    * setter for 审核人姓名
    * @generated
    */
   public void setShrxm(String shrxm){
      this.shrxm = shrxm;	
   }  
   
   /** 
    * getter for 审核人ID
    * @generated
    */
   public String getShrId(){
      return this.shrId;
   }   
   /** 
    * setter for 审核人ID
    * @generated
    */
   public void setShrId(String shrId){
      this.shrId = shrId;	
   }  
   
   /** 
    * getter for 审核单位区划
    * @generated
    */
   public String getShdwqh(){
      return this.shdwqh;
   }   
   /** 
    * setter for 审核单位区划
    * @generated
    */
   public void setShdwqh(String shdwqh){
      this.shdwqh = shdwqh;	
   }  
   
   /** 
    * getter for 审核单位名称
    * @generated
    */
   public String getShdwmc(){
      return this.shdwmc;
   }   
   /** 
    * setter for 审核单位名称
    * @generated
    */
   public void setShdwmc(String shdwmc){
      this.shdwmc = shdwmc;	
   }  
   
   /** 
    * getter for 审核单位ID
    * @generated
    */
   public String getShdwId(){
      return this.shdwId;
   }   
   /** 
    * setter for 审核单位ID
    * @generated
    */
   public void setShdwId(String shdwId){
      this.shdwId = shdwId;	
   }  
   
   /** 
    * getter for 审核标志
    * @generated
    */
   public String getShbz(){
      return this.shbz;
   }   
   /** 
    * setter for 审核标志
    * @generated
    */
   public void setShbz(String shbz){
      this.shbz = shbz;	
   }  
   
   /** 
    * getter for 审核时间
    * @generated
    */
   public String getShsj(){
      return this.shsj;
   }   
   /** 
    * setter for 审核时间
    * @generated
    */
   public void setShsj(String shsj){
      this.shsj = shsj;	
   }  
   
   /** 
    * getter for 删除标志
    * @generated
    */
   public String getScbz(){
      return this.scbz;
   }   
   /** 
    * setter for 删除标志
    * @generated
    */
   public void setScbz(String scbz){
      this.scbz = scbz;	
   }  
      
}