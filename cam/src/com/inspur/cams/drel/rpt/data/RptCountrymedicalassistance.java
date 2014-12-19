package com.inspur.cams.drel.rpt.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:农村医疗救助工作情况bean
 * @description:
 * @author:yanliangliang
 * @since:2011-06-22
 * @version:1.0
*/
 @Table(tableName = "RPT_COUNTRYMEDICALASSISTANCE" , keyFields = "id")
public class RptCountrymedicalassistance extends StatefulDatabean {
   //编号
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //年份
	@Column(name = "REPORTYEAR")
   private String reportyear;
   //季度
	@Column(name = "REPORTQUARTER")
   private String reportquarter;
   //行政区划
	@Column(name = "REGION")
   private String region;
   //填表单位
	@Column(name = "REPORTCORP")
   private String reportcorp;
   //填表人
	@Column(name = "REPORTER")
   private String reporter;
   //科室审批人
	@Column(name = "EXAMINER")
   private String examiner;
   //局领导意见
	@Column(name = "OFFICEOPINION")
   private String officeopinion;
   //填报时间
	@Column(name = "REPORTTIME")
   private String reporttime;
   //需纳入医疗救助人数（人）
   	@Rule(value="number")
	@Column(name = "C1")
   private BigDecimal c1;
   //患大病人数（人）
   	@Rule(value="number")
	@Column(name = "C2")
   private BigDecimal c2;
   //救助资金筹集总额（万元）
   	@Rule(value="number")
	@Column(name = "C3")
   private BigDecimal c3;
   //C4上年基金结转（万元）
   	@Rule(value="number")
	@Column(name = "C4")
   private BigDecimal c4;
   //C5地方财政及彩票公益金合计（万元）
   	@Rule(value="number")
	@Column(name = "C5")
   private BigDecimal c5;
   //C6省本级（万元）
   	@Rule(value="number")
	@Column(name = "C6")
   private BigDecimal c6;
   //C7地市本级（万元）
   	@Rule(value="number")
	@Column(name = "C7")
   private BigDecimal c7;
   //C8县（市、区）级（万元）
   	@Rule(value="number")
	@Column(name = "C8")
   private BigDecimal c8;
   //C9基金总收入（万元）
   	@Rule(value="number")
	@Column(name = "C9")
   private BigDecimal c9;
   //C10累计救助总人次（人次）
   	@Rule(value="number")
	@Column(name = "C10")
   private BigDecimal c10;
   //C11直接救助人次（人次）
   	@Rule(value="number")
	@Column(name = "C11")
   private BigDecimal c11;
   //C12住院人次（人次）
   	@Rule(value="number")
	@Column(name = "C12")
   private BigDecimal c12;
   //C13门诊人次（人次）
   	@Rule(value="number")
	@Column(name = "C13")
   private BigDecimal c13;
   //C14资助新农合人数（人）
   	@Rule(value="number")
	@Column(name = "C14")
   private BigDecimal c14;
   //C15资金累计支出总额（万元）
   	@Rule(value="number")
	@Column(name = "C15")
   private BigDecimal c15;
   //C16直接救助支出（万元）
   	@Rule(value="number")
	@Column(name = "C16")
   private BigDecimal c16;
   //C17住院支出（万元）
   	@Rule(value="number")
	@Column(name = "C17")
   private BigDecimal c17;
   //C18门诊支出（万元）
   	@Rule(value="number")
	@Column(name = "C18")
   private BigDecimal c18;
   //C19资助新农合资金支出（万元）
   	@Rule(value="number")
	@Column(name = "C19")
   private BigDecimal c19;
   //C20住院(元/年/人)
   	@Rule(value="number")
	@Column(name = "C20")
   private BigDecimal c20;
   //C21门诊（元/年/人）
   	@Rule(value="number")
	@Column(name = "C21")
   private BigDecimal c21;
   //C22医疗救助总支出（万元）
   	@Rule(value="number")
	@Column(name = "C22")
   private BigDecimal c22;
   //C23社会捐赠支出（万元）
   	@Rule(value="number")
	@Column(name = "C23")
   private BigDecimal c23;
   //C24资助参合总人数（人）
   	@Rule(value="number")
	@Column(name = "C24")
   private BigDecimal c24;
   //C25财政直接资助参合人数（人）
   	@Rule(value="number")
	@Column(name = "C25")
   private BigDecimal c25;
   //C26大型企业或集体经济等资助参合人数（人）（万元）
   	@Rule(value="number")
	@Column(name = "C26")
   private BigDecimal c26;
   //C27资助参合总支出（万元）
   	@Rule(value="number")
	@Column(name = "C27")
   private BigDecimal c27;
   //C28财政直接资助参合资金（万元）
   	@Rule(value="number")
	@Column(name = "C28")
   private BigDecimal c28;
   //C29大型企业或集体经济等资助参保资金（万元）
   	@Rule(value="number")
	@Column(name = "C29")
   private BigDecimal c29;
   //C30人均住院救助金额（元）
   	@Rule(value="number")
	@Column(name = "C30")
   private BigDecimal c30;
   //C31低保对象（人）
   	@Rule(value="number")
	@Column(name = "C31")
   private BigDecimal c31;
   //C32五保对象（人）
   	@Rule(value="number")
	@Column(name = "C32")
   private BigDecimal c32;
   //C33其他困难群众（人）
   	@Rule(value="number")
	@Column(name = "C33")
   private BigDecimal c33;
   //C34低保优抚对象（人）
   	@Rule(value="number")
	@Column(name = "C34")
   private BigDecimal c34;
   //是否已经上报
	@Column(name = "REPORTED")
   private String reported;
   /**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for REPORTYEAR
    * @generated
    */
   public String getReportyear(){
      return this.reportyear;
   }
   /**
    * setter for REPORTYEAR
    * @generated
    */
   public void setReportyear(String reportyear){
      this.reportyear = reportyear;
   }

   /**
    * getter for REPORTQUARTER
    * @generated
    */
   public String getReportquarter(){
      return this.reportquarter;
   }
   /**
    * setter for REPORTQUARTER
    * @generated
    */
   public void setReportquarter(String reportquarter){
      this.reportquarter = reportquarter;
   }

   /**
    * getter for REGION
    * @generated
    */
   public String getRegion(){
      return this.region;
   }
   /**
    * setter for REGION
    * @generated
    */
   public void setRegion(String region){
      this.region = region;
   }

   /**
    * getter for REPORTCORP
    * @generated
    */
   public String getReportcorp(){
      return this.reportcorp;
   }
   /**
    * setter for REPORTCORP
    * @generated
    */
   public void setReportcorp(String reportcorp){
      this.reportcorp = reportcorp;
   }

   /**
    * getter for REPORTER
    * @generated
    */
   public String getReporter(){
      return this.reporter;
   }
   /**
    * setter for REPORTER
    * @generated
    */
   public void setReporter(String reporter){
      this.reporter = reporter;
   }

   /**
    * getter for EXAMINER
    * @generated
    */
   public String getExaminer(){
      return this.examiner;
   }
   /**
    * setter for EXAMINER
    * @generated
    */
   public void setExaminer(String examiner){
      this.examiner = examiner;
   }

   /**
    * getter for OFFICEOPINION
    * @generated
    */
   public String getOfficeopinion(){
      return this.officeopinion;
   }
   /**
    * setter for OFFICEOPINION
    * @generated
    */
   public void setOfficeopinion(String officeopinion){
      this.officeopinion = officeopinion;
   }

   /**
    * getter for REPORTTIME
    * @generated
    */
   public String getReporttime(){
      return this.reporttime;
   }
   /**
    * setter for REPORTTIME
    * @generated
    */
   public void setReporttime(String reporttime){
      this.reporttime = reporttime;
   }

   /**
    * getter for C1
    * @generated
    */
   public BigDecimal getC1(){
      return this.c1;
   }
   /**
    * setter for C1
    * @generated
    */
   public void setC1(BigDecimal c1){
      this.c1 = c1;
   }

   /**
    * getter for C2
    * @generated
    */
   public BigDecimal getC2(){
      return this.c2;
   }
   /**
    * setter for C2
    * @generated
    */
   public void setC2(BigDecimal c2){
      this.c2 = c2;
   }

   /**
    * getter for C3
    * @generated
    */
   public BigDecimal getC3(){
      return this.c3;
   }
   /**
    * setter for C3
    * @generated
    */
   public void setC3(BigDecimal c3){
      this.c3 = c3;
   }

   /**
    * getter for C4
    * @generated
    */
   public BigDecimal getC4(){
      return this.c4;
   }
   /**
    * setter for C4
    * @generated
    */
   public void setC4(BigDecimal c4){
      this.c4 = c4;
   }

   /**
    * getter for C5
    * @generated
    */
   public BigDecimal getC5(){
      return this.c5;
   }
   /**
    * setter for C5
    * @generated
    */
   public void setC5(BigDecimal c5){
      this.c5 = c5;
   }

   /**
    * getter for C6
    * @generated
    */
   public BigDecimal getC6(){
      return this.c6;
   }
   /**
    * setter for C6
    * @generated
    */
   public void setC6(BigDecimal c6){
      this.c6 = c6;
   }

   /**
    * getter for C7
    * @generated
    */
   public BigDecimal getC7(){
      return this.c7;
   }
   /**
    * setter for C7
    * @generated
    */
   public void setC7(BigDecimal c7){
      this.c7 = c7;
   }

   /**
    * getter for C8
    * @generated
    */
   public BigDecimal getC8(){
      return this.c8;
   }
   /**
    * setter for C8
    * @generated
    */
   public void setC8(BigDecimal c8){
      this.c8 = c8;
   }

   /**
    * getter for C9
    * @generated
    */
   public BigDecimal getC9(){
      return this.c9;
   }
   /**
    * setter for C9
    * @generated
    */
   public void setC9(BigDecimal c9){
      this.c9 = c9;
   }

   /**
    * getter for C10
    * @generated
    */
   public BigDecimal getC10(){
      return this.c10;
   }
   /**
    * setter for C10
    * @generated
    */
   public void setC10(BigDecimal c10){
      this.c10 = c10;
   }

   /**
    * getter for C11
    * @generated
    */
   public BigDecimal getC11(){
      return this.c11;
   }
   /**
    * setter for C11
    * @generated
    */
   public void setC11(BigDecimal c11){
      this.c11 = c11;
   }

   /**
    * getter for C12
    * @generated
    */
   public BigDecimal getC12(){
      return this.c12;
   }
   /**
    * setter for C12
    * @generated
    */
   public void setC12(BigDecimal c12){
      this.c12 = c12;
   }

   /**
    * getter for C13
    * @generated
    */
   public BigDecimal getC13(){
      return this.c13;
   }
   /**
    * setter for C13
    * @generated
    */
   public void setC13(BigDecimal c13){
      this.c13 = c13;
   }

   /**
    * getter for C14
    * @generated
    */
   public BigDecimal getC14(){
      return this.c14;
   }
   /**
    * setter for C14
    * @generated
    */
   public void setC14(BigDecimal c14){
      this.c14 = c14;
   }

   /**
    * getter for C15
    * @generated
    */
   public BigDecimal getC15(){
      return this.c15;
   }
   /**
    * setter for C15
    * @generated
    */
   public void setC15(BigDecimal c15){
      this.c15 = c15;
   }

   /**
    * getter for C16
    * @generated
    */
   public BigDecimal getC16(){
      return this.c16;
   }
   /**
    * setter for C16
    * @generated
    */
   public void setC16(BigDecimal c16){
      this.c16 = c16;
   }

   /**
    * getter for C17
    * @generated
    */
   public BigDecimal getC17(){
      return this.c17;
   }
   /**
    * setter for C17
    * @generated
    */
   public void setC17(BigDecimal c17){
      this.c17 = c17;
   }

   /**
    * getter for C18
    * @generated
    */
   public BigDecimal getC18(){
      return this.c18;
   }
   /**
    * setter for C18
    * @generated
    */
   public void setC18(BigDecimal c18){
      this.c18 = c18;
   }

   /**
    * getter for C19
    * @generated
    */
   public BigDecimal getC19(){
      return this.c19;
   }
   /**
    * setter for C19
    * @generated
    */
   public void setC19(BigDecimal c19){
      this.c19 = c19;
   }

   /**
    * getter for C20
    * @generated
    */
   public BigDecimal getC20(){
      return this.c20;
   }
   /**
    * setter for C20
    * @generated
    */
   public void setC20(BigDecimal c20){
      this.c20 = c20;
   }

   /**
    * getter for C21
    * @generated
    */
   public BigDecimal getC21(){
      return this.c21;
   }
   /**
    * setter for C21
    * @generated
    */
   public void setC21(BigDecimal c21){
      this.c21 = c21;
   }

   /**
    * getter for C22
    * @generated
    */
   public BigDecimal getC22(){
      return this.c22;
   }
   /**
    * setter for C22
    * @generated
    */
   public void setC22(BigDecimal c22){
      this.c22 = c22;
   }

   /**
    * getter for C23
    * @generated
    */
   public BigDecimal getC23(){
      return this.c23;
   }
   /**
    * setter for C23
    * @generated
    */
   public void setC23(BigDecimal c23){
      this.c23 = c23;
   }

   /**
    * getter for C24
    * @generated
    */
   public BigDecimal getC24(){
      return this.c24;
   }
   /**
    * setter for C24
    * @generated
    */
   public void setC24(BigDecimal c24){
      this.c24 = c24;
   }

   /**
    * getter for C25
    * @generated
    */
   public BigDecimal getC25(){
      return this.c25;
   }
   /**
    * setter for C25
    * @generated
    */
   public void setC25(BigDecimal c25){
      this.c25 = c25;
   }

   /**
    * getter for C26
    * @generated
    */
   public BigDecimal getC26(){
      return this.c26;
   }
   /**
    * setter for C26
    * @generated
    */
   public void setC26(BigDecimal c26){
      this.c26 = c26;
   }

   /**
    * getter for C27
    * @generated
    */
   public BigDecimal getC27(){
      return this.c27;
   }
   /**
    * setter for C27
    * @generated
    */
   public void setC27(BigDecimal c27){
      this.c27 = c27;
   }

   /**
    * getter for C28
    * @generated
    */
   public BigDecimal getC28(){
      return this.c28;
   }
   /**
    * setter for C28
    * @generated
    */
   public void setC28(BigDecimal c28){
      this.c28 = c28;
   }

   /**
    * getter for C29
    * @generated
    */
   public BigDecimal getC29(){
      return this.c29;
   }
   /**
    * setter for C29
    * @generated
    */
   public void setC29(BigDecimal c29){
      this.c29 = c29;
   }

   /**
    * getter for C30
    * @generated
    */
   public BigDecimal getC30(){
      return this.c30;
   }
   /**
    * setter for C30
    * @generated
    */
   public void setC30(BigDecimal c30){
      this.c30 = c30;
   }

   /**
    * getter for C31
    * @generated
    */
   public BigDecimal getC31(){
      return this.c31;
   }
   /**
    * setter for C31
    * @generated
    */
   public void setC31(BigDecimal c31){
      this.c31 = c31;
   }

   /**
    * getter for C32
    * @generated
    */
   public BigDecimal getC32(){
      return this.c32;
   }
   /**
    * setter for C32
    * @generated
    */
   public void setC32(BigDecimal c32){
      this.c32 = c32;
   }

   /**
    * getter for C33
    * @generated
    */
   public BigDecimal getC33(){
      return this.c33;
   }
   /**
    * setter for C33
    * @generated
    */
   public void setC33(BigDecimal c33){
      this.c33 = c33;
   }

   /**
    * getter for C34
    * @generated
    */
   public BigDecimal getC34(){
      return this.c34;
   }
   /**
    * setter for C34
    * @generated
    */
   public void setC34(BigDecimal c34){
      this.c34 = c34;
   }

   /**
    * getter for REPORTED
    * @generated
    */
   public String getReported(){
      return this.reported;
   }
   /**
    * setter for REPORTED
    * @generated
    */
   public void setReported(String reported){
      this.reported = reported;
   }

}