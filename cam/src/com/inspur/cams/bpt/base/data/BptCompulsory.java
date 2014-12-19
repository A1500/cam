package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;


/**
 * @title:BptCompulsory
 * @description:
 * @author:
 * @since:2011-06-05
 * @version:1.0
*/
 @Table(tableName = "BPT_COMPULSORY" , keyFields = "id")
public class BptCompulsory extends StatefulDatabean {
   //ID
   
	@Column(name = "ID")
   private String id;
   //姓名
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
   //性别
	@Column(name = "SEX")
   private String sex;
   //身份证号
	@Rule(value="require")
	@Column(name = "ID_CARD")
   private String idCard;
   //年龄
	@Column(name = "BIRTHDAY")
   private String birthday;
   //民族
   	@Rule(value="require")
	@Column(name = "NATION")
   private String nation;
   //优待安置证编号
   	@Rule(value="require")
	@Column(name = "SPECIAL_SETTING_NO")
   private String specialSettingNo;
  //入伍时间
	@Rule(value="require")
	private String conscriptDate;
   //进藏 进疆
   	@Rule(value="require")
	@Column(name = "COMPOSED_PORTRAIT")
   private String composedPortrait;
   //户籍类别
   	@Rule(value="require")
   	private String domicileType;
   //家庭所属行政区划
   	@Rule(value="require")
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //住址
	@Column(name = "ADDRESS")
   private String address;
   //联系方式
	@Column(name = "TEL_CONTACT")
   private String telContact;
   //邮编
	@Column(name = "POSTCODE")
   private String postcode;
   //父亲姓名
	@Column(name = "FATHER_NAME")
   private String fatherName;
   //父亲单位
	@Column(name = "FATHER_UNIT")
   private String fatherUnit;
   //父亲联系方式
	@Column(name = "FATHER_CONTACT")
   private String fatherContact;
   //母亲姓名
	@Column(name = "MOTHER_NAME")
   private String motherName;
   //母亲单位
	@Column(name = "MOTHER_UNIT")
   private String motherUnit;
   //母亲联系方式
	@Column(name = "MOTHER_CONTACT")
   private String motherContact;
   //开户银行
	@Column(name = "BANK")
   private String bank;
   //开户账号
	@Column(name = "ACCOUNT_CODE")
   private String accountCode;
   //录入人ID
	@Column(name = "REG_ID")
   private String regId;
   //录入时间
	@Column(name = "REG_TIME")
   private String regTime;
   //修改人ID
	@Column(name = "MOD_ID")
   private String modId;
   //修改时间
	@Column(name = "MOD_TIME")
   private String modTime;
   //备注
	@Column(name = "NOTE")
   private String note;
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
    * getter for 姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 性别
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for 性别
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
   }

   /**
    * getter for 身份证号
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for 身份证号
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for 出生日期
    * @generated
    */
   public String getBirthday(){
      return this.birthday;
   }
   /**
    * setter for 出生日期
    * @generated
    */
   public void setBirthday(String birthday){
      this.birthday = birthday;
   }

   /**
    * getter for 民族
    * @generated
    */
   public String getNation(){
      return this.nation;
   }
   /**
    * setter for 民族
    * @generated
    */
   public void setNation(String nation){
      this.nation = nation;
   }

   /**
    * getter for 优待安置证编号
    * @generated
    */
   public String getSpecialSettingNo(){
      return this.specialSettingNo;
   }
   /**
    * setter for 优待安置证编号
    * @generated
    */
   public void setSpecialSettingNo(String specialSettingNo){
      this.specialSettingNo = specialSettingNo;
   }

   /**
    * getter for 进藏 进疆
    * @generated
    */
   public String getComposedPortrait(){
      return this.composedPortrait;
   }
   /**
    * setter for 进藏 进疆
    * @generated
    */
   public void setComposedPortrait(String composedPortrait){
      this.composedPortrait = composedPortrait;
   }

   /**
    * getter for 家庭所属行政区划
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for 家庭所属行政区划
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for 住址
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for 住址
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for 联系方式
    * @generated
    */
   public String getTelContact(){
      return this.telContact;
   }
   /**
    * setter for 联系方式
    * @generated
    */
   public void setTelContact(String telContact){
      this.telContact = telContact;
   }

   /**
    * getter for 邮编
    * @generated
    */
   public String getPostcode(){
      return this.postcode;
   }
   /**
    * setter for 邮编
    * @generated
    */
   public void setPostcode(String postcode){
      this.postcode = postcode;
   }

   /**
    * getter for 父亲姓名
    * @generated
    */
   public String getFatherName(){
      return this.fatherName;
   }
   /**
    * setter for 父亲姓名
    * @generated
    */
   public void setFatherName(String fatherName){
      this.fatherName = fatherName;
   }

   /**
    * getter for 父亲单位
    * @generated
    */
   public String getFatherUnit(){
      return this.fatherUnit;
   }
   /**
    * setter for 父亲单位
    * @generated
    */
   public void setFatherUnit(String fatherUnit){
      this.fatherUnit = fatherUnit;
   }

   /**
    * getter for 父亲联系方式
    * @generated
    */
   public String getFatherContact(){
      return this.fatherContact;
   }
   /**
    * setter for 父亲联系方式
    * @generated
    */
   public void setFatherContact(String fatherContact){
      this.fatherContact = fatherContact;
   }

   /**
    * getter for 母亲姓名
    * @generated
    */
   public String getMotherName(){
      return this.motherName;
   }
   /**
    * setter for 母亲姓名
    * @generated
    */
   public void setMotherName(String motherName){
      this.motherName = motherName;
   }

   /**
    * getter for 母亲单位
    * @generated
    */
   public String getMotherUnit(){
      return this.motherUnit;
   }
   /**
    * setter for 母亲单位
    * @generated
    */
   public void setMotherUnit(String motherUnit){
      this.motherUnit = motherUnit;
   }

   /**
    * getter for 母亲联系方式
    * @generated
    */
   public String getMotherContact(){
      return this.motherContact;
   }
   /**
    * setter for 母亲联系方式
    * @generated
    */
   public void setMotherContact(String motherContact){
      this.motherContact = motherContact;
   }

   /**
    * getter for 开户银行
    * @generated
    */
   public String getBank(){
      return this.bank;
   }
   /**
    * setter for 开户银行
    * @generated
    */
   public void setBank(String bank){
      this.bank = bank;
   }

   /**
    * getter for 开户账号
    * @generated
    */
   public String getAccountCode(){
      return this.accountCode;
   }
   /**
    * setter for 开户账号
    * @generated
    */
   public void setAccountCode(String accountCode){
      this.accountCode = accountCode;
   }

   /**
    * getter for 录入人ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for 录入时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 录入时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for 修改人ID
    * @generated
    */
   public String getModId(){
      return this.modId;
   }
   /**
    * setter for 修改人ID
    * @generated
    */
   public void setModId(String modId){
      this.modId = modId;
   }

   /**
    * getter for 修改时间
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for 修改时间
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }
/**
 * @return the domicileType
 */
public String getDomicileType() {
	return domicileType;
}
/**
 * @param domicileType the domicileType to set
 */
public void setDomicileType(String domicileType) {
	this.domicileType = domicileType;
}
/**
 * @return the conscriptDate
 */
public String getConscriptDate() {
	return conscriptDate;
}
/**
 * @param conscriptDate the conscriptDate to set
 */
public void setConscriptDate(String conscriptDate) {
	this.conscriptDate = conscriptDate;
}

}