package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IComPhotoDao;
import com.inspur.cams.jcm.data.ComPhoto;
import com.inspur.cams.jcm.domain.IComPhotoDomain;

/**
 * 人员照片表domain
 * @author 
 * @date 2014-05-16
 */
public class ComPhotoDomain implements IComPhotoDomain {

	@Reference
	private IComPhotoDao comPhotoDao;

	/**
	 * 查询 人员照片表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return comPhotoDao.query(pset);
	}

	/**
	 * 获取 人员照片表
	 * @param pset
	 * @return
	 */
	public ComPhoto get(String photoId) {
		return comPhotoDao.get(photoId);
	}

	/**
	 * 增加 人员照片表
	 * @param comPhoto
	 */
	public void insert(ComPhoto comPhoto) {
		comPhotoDao.insert(comPhoto);
	}
	
	/**
	 * 修改 人员照片表
	 * @param comPhoto
	 */
	public void update(ComPhoto comPhoto) {
		comPhotoDao.update(comPhoto);
	}
	
	/**
	 * 删除 人员照片表
	 * @param photoId
	 */
	public void delete(String photoId) {
		comPhotoDao.delete(photoId);
	}

}