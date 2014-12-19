package com.inspur.cams.sorg.assess.assessconfig.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomAssessConfig
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 @Table(tableName = "SOM_ASSESS_CONFIG" , keyFields = "configId")
public class SomAssessConfig extends StatefulDatabean {
   //CONFIG_ID
	@Column(name = "CONFIG_ID")
   private String configId;
   //LEVEL
	@Column(name = "CONFIG_LEVEL")
   private String configLevel;
   //ASSESS_TYPE
	@Column(name = "ASSESS_TYPE")
   private String assessType;
   //SEQ
	@Column(name = "SEQ")
   private String seq;
   //ASSESS_CONTENT
	@Column(name = "ASSESS_CONTENT")
   private String assessContent;
   //ASSESS_SCORE
	@Column(name = "ASSESS_SCORE")
   private String assessScore;
   //UP_ID
	@Column(name = "UP_ID")
   private String upId;
   //FONT_SIZE
	@Column(name = "FONT_SIZE")
   private String fontSize;
   //FONT_STYLE
	@Column(name = "FONT_STYLE")
   private String fontStyle;
   //IF_MAKE_SCORE
	@Column(name = "IF_MAKE_SCORE")
   private String ifMakeScore;
   //IF_VALID
	@Column(name = "IF_VALID")
   private String ifValid;
	
	@Transient
	private String assessMakeScore;
   /**
    * getter for CONFIG_ID
    * @generated
    */
   public String getConfigId(){
      return this.configId;
   }
   /**
    * setter for CONFIG_ID
    * @generated
    */
   public void setConfigId(String configId){
      this.configId = configId;
   }

   /**
    * getter for LEVEL
    * @generated
    */
   public String getConfigLevel(){
      return this.configLevel;
   }
   /**
    * setter for LEVEL
    * @generated
    */
   public void setConfigLevel(String configLevel){
      this.configLevel = configLevel;
   }

   /**
    * getter for ASSESS_TYPE
    * @generated
    */
   public String getAssessType(){
      return this.assessType;
   }
   /**
    * setter for ASSESS_TYPE
    * @generated
    */
   public void setAssessType(String assessType){
      this.assessType = assessType;
   }

   /**
    * getter for SEQ
    * @generated
    */
   public String getSeq(){
      return this.seq;
   }
   /**
    * setter for SEQ
    * @generated
    */
   public void setSeq(String seq){
      this.seq = seq;
   }

   /**
    * getter for ASSESS_CONTENT
    * @generated
    */
   public String getAssessContent(){
      return this.assessContent;
   }
   /**
    * setter for ASSESS_CONTENT
    * @generated
    */
   public void setAssessContent(String assessContent){
      this.assessContent = assessContent;
   }

   /**
    * getter for ASSESS_SCORE
    * @generated
    */
   public String getAssessScore(){
      return this.assessScore;
   }
   /**
    * setter for ASSESS_SCORE
    * @generated
    */
   public void setAssessScore(String assessScore){
      this.assessScore = assessScore;
   }

   /**
    * getter for UP_ID
    * @generated
    */
   public String getUpId(){
      return this.upId;
   }
   /**
    * setter for UP_ID
    * @generated
    */
   public void setUpId(String upId){
      this.upId = upId;
   }

   /**
    * getter for FONT_SIZE
    * @generated
    */
   public String getFontSize(){
      return this.fontSize;
   }
   /**
    * setter for FONT_SIZE
    * @generated
    */
   public void setFontSize(String fontSize){
      this.fontSize = fontSize;
   }

   /**
    * getter for FONT_STYLE
    * @generated
    */
   public String getFontStyle(){
      return this.fontStyle;
   }
   /**
    * setter for FONT_STYLE
    * @generated
    */
   public void setFontStyle(String fontStyle){
      this.fontStyle = fontStyle;
   }

   /**
    * getter for IF_MAKE_SCORE
    * @generated
    */
   public String getIfMakeScore(){
      return this.ifMakeScore;
   }
   /**
    * setter for IF_MAKE_SCORE
    * @generated
    */
   public void setIfMakeScore(String ifMakeScore){
      this.ifMakeScore = ifMakeScore;
   }

   /**
    * getter for IF_VALID
    * @generated
    */
   public String getIfValid(){
      return this.ifValid;
   }
   /**
    * setter for IF_VALID
    * @generated
    */
   public void setIfValid(String ifValid){
      this.ifValid = ifValid;
   }
public String getAssessMakeScore() {
	return assessMakeScore;
}
public void setAssessMakeScore(String assessMakeScore) {
	this.assessMakeScore = assessMakeScore;
}

}