package com.inspur.cams.dis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.UploadFile;

import com.inspur.cams.dis.base.data.DisPhoto;



/**
 * @title:IDisPhotoDomain
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public interface IDisPhotoDomain {

   public void saveDisPhoto(List<DisPhoto> list);
   

	public DataSet queryDisPhoto(ParameterSet pset);


	public void delete(List<String> list);

	public void uploadDisPhoto(String infoId,List<UploadFile> fileList);
	/**
	 * 根据外键infoId删除所有与之相关的图片记录
	 * @param infoId
	 */
	public void deleteInInfoId(String infoId);

 }