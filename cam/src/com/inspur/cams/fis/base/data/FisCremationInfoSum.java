package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:FisCremationInfoSum
 * @description:
 * @author:
 * @since:2012-11-13
 * @version:1.0
*/
 @Table(tableName = "FIS_CREMATION_INFO_SUM" , keyFields = "recordId")
public class FisCremationInfoSum extends StatefulDatabean {
   //主键ID
   private String recordId;
   //火化类型
   private String cremationType;
   //火化工编号
   private String stoveId;
   //火化工名称
   private String stovePeople;
   //火化状态
   private String status;
   //开始时间
   private String startTime;
   //结束时间
   private String endTime;
   //所用火化炉编号
   private String serviceUseId;
   //业务编号
   private String applyId;
   //业务类型
   private String applyType;
   //亲属编号
   private String customId;
   //是否接收
   private String ifReceive;
   //接收时间
   private String receiveTime;
   //受理单位
   private String contractOrgan;
   //受理单位名称
   private String contractOrganName;
   //受理人
   private String contractPeople;
   //受理时间
   private String contractDate;
   //是否完成
   private String ifFinish;
   //完成时间
   private String finishTime;
   //是否骨灰交接
   private String ifTakeashes;
   //骨灰交接时间
   private String takeashesTime;
   //是否缴费
   private String ifFeeEnd;
   //缴费时间
   private String feeEndTime;
   //是否打印合同
   private String ifPrint;
   //打印合同时间
   private String printTime;
   //骨灰去向
   private String ashesGo;
   //是否预约
   private String ifBook;
   //预约人
   private String bookCustom;
   //预约受理人
   private String bookPeopleName;
   //预约时间
   private String bookTime;
   //逝者编号
   private String deadId;
   //是否无名尸
   private String ifNameless;
   //逝者姓名
   private String name;
   //性别
   private String sex;
   //证件类型
   private String cardType;
   //证件号
   private String idCard;
   //出生日期
   private String birthday;
   //年龄
   private String age;
   //国籍
   private String nation;
   //民族
   private String folk;
   //职业
   private String profession;
   //文化程度
   private String education;
   //政治面貌
   private String political;
   //宗教信仰
   private String religion;
   //是否本地户籍
   private String ifLocal;
   //户口所在地
   private String populace;
   //生前住址
   private String familyAdd;
   //工作单位
   private String workName;
   //死亡日期
   private String deathDate;
   //死亡地点
   private String deathPlace;
   //死亡原因
   private String deathCause;
   //病种
   private String deathDisease;
   //遗体状态
   private String corpseStatus;
   //遗体状态备注
   private String corpseStatusNote;
   //随身遗物
   private String relics;
   //出具死亡证明单位
   private String deathCertOrg;
   //告别时间
   private String goodbyeTime;
   //火化时间
   private String cremationTime;
   //优惠类型
   private String preferentialType;
   //照片内码
   private String photoId;
   //附件
   private String accessories;
   //备注
   private String note;
   //单位编码
   private String createOrgan;
   //单位名称
   private String createOrganName;
   //更新人编码
   private String createPeople;
   //更新人名称
   private String createPeopleName;
   //更新时间
   private String createTime;
   //出具死亡证明单位名称
   private String deathCertOrgName;
   //是否要灰
   private String ifTodust;
   //户口所在地全称
   private String populaceName;
   
   /**
    * getter for 主键ID
    * @generated
    */
   public String getRecordId(){
      return this.recordId;
   }
   /**
    * setter for 主键ID
    * @generated
    */
   public void setRecordId(String recordId){
      this.recordId = recordId;
   }

   /**
    * getter for 火化类型
    * @generated
    */
   public String getCremationType(){
      return this.cremationType;
   }
   /**
    * setter for 火化类型
    * @generated
    */
   public void setCremationType(String cremationType){
      this.cremationType = cremationType;
   }

   /**
    * getter for 火化工编号
    * @generated
    */
   public String getStoveId(){
      return this.stoveId;
   }
   /**
    * setter for 火化工编号
    * @generated
    */
   public void setStoveId(String stoveId){
      this.stoveId = stoveId;
   }

   /**
    * getter for 火化工名称
    * @generated
    */
   public String getStovePeople(){
      return this.stovePeople;
   }
   /**
    * setter for 火化工名称
    * @generated
    */
   public void setStovePeople(String stovePeople){
      this.stovePeople = stovePeople;
   }

   /**
    * getter for 火化状态
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for 火化状态
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for 开始时间
    * @generated
    */
   public String getStartTime(){
      return this.startTime;
   }
   /**
    * setter for 开始时间
    * @generated
    */
   public void setStartTime(String startTime){
      this.startTime = startTime;
   }

   /**
    * getter for 结束时间
    * @generated
    */
   public String getEndTime(){
      return this.endTime;
   }
   /**
    * setter for 结束时间
    * @generated
    */
   public void setEndTime(String endTime){
      this.endTime = endTime;
   }

   /**
    * getter for 所用火化炉编号
    * @generated
    */
   public String getServiceUseId(){
      return this.serviceUseId;
   }
   /**
    * setter for 所用火化炉编号
    * @generated
    */
   public void setServiceUseId(String serviceUseId){
      this.serviceUseId = serviceUseId;
   }

   /**
    * getter for 业务编号
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for 业务编号
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for 业务类型
    * @generated
    */
   public String getApplyType(){
      return this.applyType;
   }
   /**
    * setter for 业务类型
    * @generated
    */
   public void setApplyType(String applyType){
      this.applyType = applyType;
   }

   /**
    * getter for 亲属编号
    * @generated
    */
   public String getCustomId(){
      return this.customId;
   }
   /**
    * setter for 亲属编号
    * @generated
    */
   public void setCustomId(String customId){
      this.customId = customId;
   }

   /**
    * getter for 是否接收
    * @generated
    */
   public String getIfReceive(){
      return this.ifReceive;
   }
   /**
    * setter for 是否接收
    * @generated
    */
   public void setIfReceive(String ifReceive){
      this.ifReceive = ifReceive;
   }

   /**
    * getter for 接收时间
    * @generated
    */
   public String getReceiveTime(){
      return this.receiveTime;
   }
   /**
    * setter for 接收时间
    * @generated
    */
   public void setReceiveTime(String receiveTime){
      this.receiveTime = receiveTime;
   }

   /**
    * getter for 受理单位
    * @generated
    */
   public String getContractOrgan(){
      return this.contractOrgan;
   }
   /**
    * setter for 受理单位
    * @generated
    */
   public void setContractOrgan(String contractOrgan){
      this.contractOrgan = contractOrgan;
   }

   /**
    * getter for 受理单位名称
    * @generated
    */
   public String getContractOrganName(){
      return this.contractOrganName;
   }
   /**
    * setter for 受理单位名称
    * @generated
    */
   public void setContractOrganName(String contractOrganName){
      this.contractOrganName = contractOrganName;
   }

   /**
    * getter for 受理人
    * @generated
    */
   public String getContractPeople(){
      return this.contractPeople;
   }
   /**
    * setter for 受理人
    * @generated
    */
   public void setContractPeople(String contractPeople){
      this.contractPeople = contractPeople;
   }

   /**
    * getter for 受理时间
    * @generated
    */
   public String getContractDate(){
      return this.contractDate;
   }
   /**
    * setter for 受理时间
    * @generated
    */
   public void setContractDate(String contractDate){
      this.contractDate = contractDate;
   }

   /**
    * getter for 是否完成
    * @generated
    */
   public String getIfFinish(){
      return this.ifFinish;
   }
   /**
    * setter for 是否完成
    * @generated
    */
   public void setIfFinish(String ifFinish){
      this.ifFinish = ifFinish;
   }

   /**
    * getter for 完成时间
    * @generated
    */
   public String getFinishTime(){
      return this.finishTime;
   }
   /**
    * setter for 完成时间
    * @generated
    */
   public void setFinishTime(String finishTime){
      this.finishTime = finishTime;
   }

   /**
    * getter for 是否骨灰交接
    * @generated
    */
   public String getIfTakeashes(){
      return this.ifTakeashes;
   }
   /**
    * setter for 是否骨灰交接
    * @generated
    */
   public void setIfTakeashes(String ifTakeashes){
      this.ifTakeashes = ifTakeashes;
   }

   /**
    * getter for 骨灰交接时间
    * @generated
    */
   public String getTakeashesTime(){
      return this.takeashesTime;
   }
   /**
    * setter for 骨灰交接时间
    * @generated
    */
   public void setTakeashesTime(String takeashesTime){
      this.takeashesTime = takeashesTime;
   }

   /**
    * getter for 是否缴费
    * @generated
    */
   public String getIfFeeEnd(){
      return this.ifFeeEnd;
   }
   /**
    * setter for 是否缴费
    * @generated
    */
   public void setIfFeeEnd(String ifFeeEnd){
      this.ifFeeEnd = ifFeeEnd;
   }

   /**
    * getter for 缴费时间
    * @generated
    */
   public String getFeeEndTime(){
      return this.feeEndTime;
   }
   /**
    * setter for 缴费时间
    * @generated
    */
   public void setFeeEndTime(String feeEndTime){
      this.feeEndTime = feeEndTime;
   }

   /**
    * getter for 是否打印合同
    * @generated
    */
   public String getIfPrint(){
      return this.ifPrint;
   }
   /**
    * setter for 是否打印合同
    * @generated
    */
   public void setIfPrint(String ifPrint){
      this.ifPrint = ifPrint;
   }

   /**
    * getter for 打印合同时间
    * @generated
    */
   public String getPrintTime(){
      return this.printTime;
   }
   /**
    * setter for 打印合同时间
    * @generated
    */
   public void setPrintTime(String printTime){
      this.printTime = printTime;
   }

   /**
    * getter for 骨灰去向
    * @generated
    */
   public String getAshesGo(){
      return this.ashesGo;
   }
   /**
    * setter for 骨灰去向
    * @generated
    */
   public void setAshesGo(String ashesGo){
      this.ashesGo = ashesGo;
   }

   /**
    * getter for 是否预约
    * @generated
    */
   public String getIfBook(){
      return this.ifBook;
   }
   /**
    * setter for 是否预约
    * @generated
    */
   public void setIfBook(String ifBook){
      this.ifBook = ifBook;
   }

   /**
    * getter for 预约人
    * @generated
    */
   public String getBookCustom(){
      return this.bookCustom;
   }
   /**
    * setter for 预约人
    * @generated
    */
   public void setBookCustom(String bookCustom){
      this.bookCustom = bookCustom;
   }

   /**
    * getter for 预约受理人
    * @generated
    */
   public String getBookPeopleName(){
      return this.bookPeopleName;
   }
   /**
    * setter for 预约受理人
    * @generated
    */
   public void setBookPeopleName(String bookPeopleName){
      this.bookPeopleName = bookPeopleName;
   }

   /**
    * getter for 预约时间
    * @generated
    */
   public String getBookTime(){
      return this.bookTime;
   }
   /**
    * setter for 预约时间
    * @generated
    */
   public void setBookTime(String bookTime){
      this.bookTime = bookTime;
   }

   /**
    * getter for 逝者编号
    * @generated
    */
   public String getDeadId(){
      return this.deadId;
   }
   /**
    * setter for 逝者编号
    * @generated
    */
   public void setDeadId(String deadId){
      this.deadId = deadId;
   }

   /**
    * getter for 是否无名尸
    * @generated
    */
   public String getIfNameless(){
      return this.ifNameless;
   }
   /**
    * setter for 是否无名尸
    * @generated
    */
   public void setIfNameless(String ifNameless){
      this.ifNameless = ifNameless;
   }

   /**
    * getter for 逝者姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 逝者姓名
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
    * getter for 证件类型
    * @generated
    */
   public String getCardType(){
      return this.cardType;
   }
   /**
    * setter for 证件类型
    * @generated
    */
   public void setCardType(String cardType){
      this.cardType = cardType;
   }

   /**
    * getter for 证件号
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for 证件号
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
    * getter for 年龄
    * @generated
    */
   public String getAge(){
      return this.age;
   }
   /**
    * setter for 年龄
    * @generated
    */
   public void setAge(String age){
      this.age = age;
   }

   /**
    * getter for 国籍
    * @generated
    */
   public String getNation(){
      return this.nation;
   }
   /**
    * setter for 国籍
    * @generated
    */
   public void setNation(String nation){
      this.nation = nation;
   }

   /**
    * getter for 民族
    * @generated
    */
   public String getFolk(){
      return this.folk;
   }
   /**
    * setter for 民族
    * @generated
    */
   public void setFolk(String folk){
      this.folk = folk;
   }

   /**
    * getter for 职业
    * @generated
    */
   public String getProfession(){
      return this.profession;
   }
   /**
    * setter for 职业
    * @generated
    */
   public void setProfession(String profession){
      this.profession = profession;
   }

   /**
    * getter for 文化程度
    * @generated
    */
   public String getEducation(){
      return this.education;
   }
   /**
    * setter for 文化程度
    * @generated
    */
   public void setEducation(String education){
      this.education = education;
   }

   /**
    * getter for 政治面貌
    * @generated
    */
   public String getPolitical(){
      return this.political;
   }
   /**
    * setter for 政治面貌
    * @generated
    */
   public void setPolitical(String political){
      this.political = political;
   }

   /**
    * getter for 宗教信仰
    * @generated
    */
   public String getReligion(){
      return this.religion;
   }
   /**
    * setter for 宗教信仰
    * @generated
    */
   public void setReligion(String religion){
      this.religion = religion;
   }

   /**
    * getter for 是否本地户籍
    * @generated
    */
   public String getIfLocal(){
      return this.ifLocal;
   }
   /**
    * setter for 是否本地户籍
    * @generated
    */
   public void setIfLocal(String ifLocal){
      this.ifLocal = ifLocal;
   }

   /**
    * getter for 户口所在地
    * @generated
    */
   public String getPopulace(){
      return this.populace;
   }
   /**
    * setter for 户口所在地
    * @generated
    */
   public void setPopulace(String populace){
      this.populace = populace;
   }

   /**
    * getter for 生前住址
    * @generated
    */
   public String getFamilyAdd(){
      return this.familyAdd;
   }
   /**
    * setter for 生前住址
    * @generated
    */
   public void setFamilyAdd(String familyAdd){
      this.familyAdd = familyAdd;
   }

   /**
    * getter for 工作单位
    * @generated
    */
   public String getWorkName(){
      return this.workName;
   }
   /**
    * setter for 工作单位
    * @generated
    */
   public void setWorkName(String workName){
      this.workName = workName;
   }

   /**
    * getter for 死亡日期
    * @generated
    */
   public String getDeathDate(){
      return this.deathDate;
   }
   /**
    * setter for 死亡日期
    * @generated
    */
   public void setDeathDate(String deathDate){
      this.deathDate = deathDate;
   }

   /**
    * getter for 死亡地点
    * @generated
    */
   public String getDeathPlace(){
      return this.deathPlace;
   }
   /**
    * setter for 死亡地点
    * @generated
    */
   public void setDeathPlace(String deathPlace){
      this.deathPlace = deathPlace;
   }

   /**
    * getter for 死亡原因
    * @generated
    */
   public String getDeathCause(){
      return this.deathCause;
   }
   /**
    * setter for 死亡原因
    * @generated
    */
   public void setDeathCause(String deathCause){
      this.deathCause = deathCause;
   }

   /**
    * getter for 病种
    * @generated
    */
   public String getDeathDisease(){
      return this.deathDisease;
   }
   /**
    * setter for 病种
    * @generated
    */
   public void setDeathDisease(String deathDisease){
      this.deathDisease = deathDisease;
   }

   /**
    * getter for 遗体状态
    * @generated
    */
   public String getCorpseStatus(){
      return this.corpseStatus;
   }
   /**
    * setter for 遗体状态
    * @generated
    */
   public void setCorpseStatus(String corpseStatus){
      this.corpseStatus = corpseStatus;
   }

   /**
    * getter for 遗体状态备注
    * @generated
    */
   public String getCorpseStatusNote(){
      return this.corpseStatusNote;
   }
   /**
    * setter for 遗体状态备注
    * @generated
    */
   public void setCorpseStatusNote(String corpseStatusNote){
      this.corpseStatusNote = corpseStatusNote;
   }

   /**
    * getter for 随身遗物
    * @generated
    */
   public String getRelics(){
      return this.relics;
   }
   /**
    * setter for 随身遗物
    * @generated
    */
   public void setRelics(String relics){
      this.relics = relics;
   }

   /**
    * getter for 出具死亡证明单位
    * @generated
    */
   public String getDeathCertOrg(){
      return this.deathCertOrg;
   }
   /**
    * setter for 出具死亡证明单位
    * @generated
    */
   public void setDeathCertOrg(String deathCertOrg){
      this.deathCertOrg = deathCertOrg;
   }

   /**
    * getter for 告别时间
    * @generated
    */
   public String getGoodbyeTime(){
      return this.goodbyeTime;
   }
   /**
    * setter for 告别时间
    * @generated
    */
   public void setGoodbyeTime(String goodbyeTime){
      this.goodbyeTime = goodbyeTime;
   }

   /**
    * getter for 火化时间
    * @generated
    */
   public String getCremationTime(){
      return this.cremationTime;
   }
   /**
    * setter for 火化时间
    * @generated
    */
   public void setCremationTime(String cremationTime){
      this.cremationTime = cremationTime;
   }

   /**
    * getter for 优惠类型
    * @generated
    */
   public String getPreferentialType(){
      return this.preferentialType;
   }
   /**
    * setter for 优惠类型
    * @generated
    */
   public void setPreferentialType(String preferentialType){
      this.preferentialType = preferentialType;
   }

   /**
    * getter for 照片内码
    * @generated
    */
   public String getPhotoId(){
      return this.photoId;
   }
   /**
    * setter for 照片内码
    * @generated
    */
   public void setPhotoId(String photoId){
      this.photoId = photoId;
   }

   /**
    * getter for 附件
    * @generated
    */
   public String getAccessories(){
      return this.accessories;
   }
   /**
    * setter for 附件
    * @generated
    */
   public void setAccessories(String accessories){
      this.accessories = accessories;
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
    * getter for 单位编码
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for 单位编码
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for 单位名称
    * @generated
    */
   public String getCreateOrganName(){
      return this.createOrganName;
   }
   /**
    * setter for 单位名称
    * @generated
    */
   public void setCreateOrganName(String createOrganName){
      this.createOrganName = createOrganName;
   }

   /**
    * getter for 更新人编码
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for 更新人编码
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for 更新人名称
    * @generated
    */
   public String getCreatePeopleName(){
      return this.createPeopleName;
   }
   /**
    * setter for 更新人名称
    * @generated
    */
   public void setCreatePeopleName(String createPeopleName){
      this.createPeopleName = createPeopleName;
   }

   /**
    * getter for 更新时间
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for 更新时间
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

   /**
    * getter for 出具死亡证明单位名称
    * @generated
    */
   public String getDeathCertOrgName(){
      return this.deathCertOrgName;
   }
   /**
    * setter for 出具死亡证明单位名称
    * @generated
    */
   public void setDeathCertOrgName(String deathCertOrgName){
      this.deathCertOrgName = deathCertOrgName;
   }

   /**
    * getter for 是否要灰
    * @generated
    */
   public String getIfTodust(){
      return this.ifTodust;
   }
   /**
    * setter for 是否要灰
    * @generated
    */
   public void setIfTodust(String ifTodust){
      this.ifTodust = ifTodust;
   }

   /**
    * getter for 户口所在地全称
    * @generated
    */
   public String getPopulaceName(){
      return this.populaceName;
   }
   /**
    * setter for 户口所在地全称
    * @generated
    */
   public void setPopulaceName(String populaceName){
      this.populaceName = populaceName;
   }

}