package com.inspur.cams.dis.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dis.base.dao.IDisPhotoDao;
import com.inspur.cams.dis.base.data.DisPhoto;
import com.inspur.cams.dis.base.domain.IDisPhotoDomain;

/**
 * @title:DisPhotoDomain
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public class DisPhotoDomain implements IDisPhotoDomain {

	private IDisPhotoDao disphotoDao;
	

	@Reference
	public void setDisPhotoDao(IDisPhotoDao disphotoDao) {
		this.disphotoDao = disphotoDao;
	}

	public void saveDisPhoto(List<DisPhoto> list) {
		this.disphotoDao.save(list);

	}

	public void delete(List<String> list) {
		String[] disphotoIds = list.toArray(new String[list.size()]);
		if (list != null && !list.isEmpty()) {
			this.disphotoDao.batchDelete(disphotoIds);
		}
	}

	public DataSet queryDisPhoto(ParameterSet pset) {
		return disphotoDao.query(pset);
	}

	public void uploadDisPhoto(String infoId, List<UploadFile> fileList) {
		for(UploadFile uploadfile : fileList) {
			DisPhoto disPhoto = new DisPhoto();
			disPhoto.setPhotoId(IdHelp.getUUID32());
			disPhoto.setPhotoContent(uploadfile);
			disPhoto.setInfoId(infoId);
			disPhoto.setCreateDate(DateUtil.getTime());
			disPhoto.setCreateOrgan(BspUtil.getOrganName());
			this.disphotoDao.insert(disPhoto);
		}		
	}

	/**
	 * 根据外键infoId删除所有与之相关的图片记录
	 * @param infoId
	 */
	public void deleteInInfoId(String infoId){
		disphotoDao.deleteInInfoId(infoId);
	}



}