package com.inspur.cams.comm.inform.attachment;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:InInformAttachment
 * @description:
 * @author:
 * @since:2009-10-27
 * @version:1.0
*/
 @Table(tableName = "APPROVALE_IN_INFORM_ATTACHMENT" , keyFields = {"id","filename"})
public class InformAttachment extends StatefulDatabean {
	//ID
	   	@Rule(value="require")
		@Column(name = "ID")
	   private String id;
	   //FILENAME
	   	@Rule(value="require")
		@Column(name = "FILENAME")
	   private String filename;
	   //FILECONTENT
		@Column(name = "FILECONTENT")
	   private UploadFile filecontent;
	   //ATTID
		@Column(name = "ATTID")
	   private String attid;
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
	    * getter for FILENAME
	    * @generated
	    */
	   public String getFilename(){
	      return this.filename;
	   }
	   /**
	    * setter for FILENAME
	    * @generated
	    */
	   public void setFilename(String filename){
	      this.filename = filename;
	   }

	   /**
	    * getter for FILECONTENT
	    * @generated
	    */
	   public UploadFile getFilecontent(){
	      return this.filecontent;
	   }
	   /**
	    * setter for FILECONTENT
	    * @generated
	    */
	   public void setFilecontent(UploadFile filecontent){
	      this.filecontent = filecontent;
	   }

	   /**
	    * getter for ATTID
	    * @generated
	    */
	   public String getAttid(){
	      return this.attid;
	   }
	   /**
	    * setter for ATTID
	    * @generated
	    */
	   public void setAttid(String attid){
	      this.attid = attid;
	   }

}